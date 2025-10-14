import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:file_picker/file_picker.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/data/data_source/local/database/database.dart';
import 'package:moodlog/domain/entities/backup/backup_data.dart';
import 'package:moodlog/domain/entities/backup/backup_journal.dart';
import 'package:moodlog/domain/entities/backup/backup_settings.dart';
import 'package:moodlog/domain/entities/backup/backup_stat.dart';
import 'package:moodlog/domain/entities/backup/backup_tag.dart';
import 'package:moodlog/domain/entities/backup/backup_user.dart';
import 'package:moodlog/domain/repositories/journal_repository.dart';
import 'package:moodlog/domain/repositories/local_backup_repository.dart';
import 'package:moodlog/domain/repositories/local_user_repository.dart';
import 'package:moodlog/domain/repositories/settings_repository.dart';
import 'package:moodlog/domain/repositories/tag_repository.dart';
import 'package:path_provider/path_provider.dart';

class LocalBackupRepositoryImpl implements LocalBackupRepository {
  final JournalRepository _journalRepository;
  final TagRepository _tagRepository;
  final LocalUserRepository _localUserRepository;
  final SettingsRepository _settingsRepository;
  final MoodLogDatabase _database;
  final Logger _log = Logger('LocalBackupRepositoryImpl');

  LocalBackupRepositoryImpl({
    required JournalRepository journalRepository,
    required TagRepository tagRepository,
    required LocalUserRepository localUserRepository,
    required SettingsRepository settingsRepository,
    required MoodLogDatabase database,
  }) : _journalRepository = journalRepository,
       _tagRepository = tagRepository,
       _localUserRepository = localUserRepository,
       _settingsRepository = settingsRepository,
       _database = database;

  @override
  Future<String> exportBackup() async {
    try {
      final backupData = await createBackupData();

      final jsonString = jsonEncode(backupData.toJson());
      final bytes = utf8.encode(jsonString);
      final fileName =
          'moodlog_backup_${DateTime.now().millisecondsSinceEpoch}.json';

      final result = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Backup File',
        fileName: fileName,
        type: FileType.custom,
        allowedExtensions: ['json'],
        bytes: bytes,
      );

      if (result != null) {
        _log.info('Backup exported successfully to: $result');
        return result;
      } else {
        throw Exception('Backup export cancelled by user');
      }
    } catch (e, s) {
      _log.severe('Error exporting backup', e, s);
      rethrow;
    }
  }

  @override
  Future<void> importBackup(String filePath) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        throw Exception('Backup file not found: $filePath');
      }

      final jsonString = await file.readAsString();
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;

      final backupData = BackupData.fromJson(jsonMap);

      await restoreBackupData(backupData);

      _log.info('Backup imported successfully from: $filePath');
    } catch (e, s) {
      _log.severe('Error importing backup', e, s);
      rethrow;
    }
  }

  @override
  Future<BackupData> createBackupData() async {
    try {
      final user = await _localUserRepository.getUser();
      if (user == null) {
        throw Exception('User not found');
      }

      final settings = await _settingsRepository.loadSettings();

      final journalsResult = await _journalRepository.getJournals();
      final journals = switch (journalsResult) {
        Ok() => journalsResult.value,
        Error() => throw Exception(
          'Failed to get journals: ${journalsResult.error}',
        ),
      };

      final tagsResult = await _tagRepository.getAllTags();
      final tags = switch (tagsResult) {
        Ok() => tagsResult.value,
        Error() => throw Exception('Failed to get tags: ${tagsResult.error}'),
      };

      final statsList = await _database.select(_database.stats).get();
      final stat = statsList.isNotEmpty ? statsList.first : null;

      final images = <String, String>{};
      for (final journal in journals) {
        if (journal.imageUri != null) {
          for (final imagePath in journal.imageUri!) {
            try {
              final imageFile = File(imagePath);
              if (await imageFile.exists()) {
                final bytes = await imageFile.readAsBytes();
                final base64String = base64Encode(bytes);
                images[imagePath] = base64String;
              }
            } catch (e) {
              _log.warning('Failed to read image: $imagePath', e);
            }
          }
        }
      }

      return BackupData(
        version: '1.0',
        backupDate: DateTime.now(),
        user: BackupUser.fromLocalUser(user),
        settings: BackupSettings.fromSettings(settings),
        stat: stat != null ? BackupStat.fromStat(stat) : null,
        journals: journals.map((j) => BackupJournal.fromJournal(j)).toList(),
        tags: tags.map((t) => BackupTag.fromTag(t)).toList(),
        images: images,
      );
    } catch (e, s) {
      _log.severe('Error creating backup data', e, s);
      rethrow;
    }
  }

  @override
  Future<void> restoreBackupData(BackupData backupData) async {
    try {
      await _database.clearAllTables();

      await _localUserRepository.updateUser(backupData.user.toLocalUser());

      await _settingsRepository.updateSettings(
        backupData.settings.toSettings(),
      );

      if (backupData.stat != null) {
        await _database
            .into(_database.stats)
            .insert(
              StatsCompanion.insert(
                id: Value(backupData.stat!.id),
                currentStreak: Value(backupData.stat!.currentStreak),
                maxStreak: Value(backupData.stat!.maxStreak),
                lastActiveDate: backupData.stat!.lastActiveDate,
              ),
            );
      }

      final tagMap = <int, int>{};
      for (final backupTag in backupData.tags) {
        final tagId = await _database
            .into(_database.tags)
            .insert(
              TagsCompanion.insert(
                id: Value(backupTag.id),
                name: backupTag.name,
                color: Value(backupTag.color),
                createdAt: Value(backupTag.createdAt),
              ),
            );
        tagMap[backupTag.id] = tagId;
      }

      final appDocDir = await getApplicationDocumentsDirectory();
      final imagesDir = Directory('${appDocDir.path}/images');
      if (!await imagesDir.exists()) {
        await imagesDir.create(recursive: true);
      }

      for (final backupJournal in backupData.journals) {
        List<String>? restoredImagePaths;
        if (backupJournal.imageUri != null &&
            backupJournal.imageUri!.isNotEmpty) {
          restoredImagePaths = [];
          for (final oldPath in backupJournal.imageUri!) {
            if (backupData.images.containsKey(oldPath)) {
              try {
                final base64String = backupData.images[oldPath]!;
                final bytes = base64Decode(base64String);

                final fileName = oldPath.split('/').last;
                final newPath = '${imagesDir.path}/$fileName';
                final newFile = File(newPath);
                await newFile.writeAsBytes(bytes);

                restoredImagePaths.add(newPath);
              } catch (e) {
                _log.warning('Failed to restore image: $oldPath', e);
              }
            }
          }
        }

        await _database
            .into(_database.journals)
            .insert(
              JournalsCompanion.insert(
                id: Value(backupJournal.id),
                moodType: MoodType.values.byName(backupJournal.moodType),
                createdAt: Value(backupJournal.createdAt),
                aiResponseEnabled: backupJournal.aiResponseEnabled,
                content: Value(backupJournal.content),
                imageUri: Value(restoredImagePaths),
                aiResponse: Value(backupJournal.aiResponse),
                latitude: Value(backupJournal.latitude),
                longitude: Value(backupJournal.longitude),
                address: Value(backupJournal.address),
                temperature: Value(backupJournal.temperature),
                weatherIcon: Value(backupJournal.weatherIcon),
                weatherDescription: Value(backupJournal.weatherDescription),
                tagNames: Value(backupJournal.tagNames),
              ),
            );

        if (backupJournal.tagNames != null &&
            backupJournal.tagNames!.isNotEmpty) {
          for (final tagName in backupJournal.tagNames!) {
            final tag = backupData.tags.firstWhere(
              (t) => t.name == tagName,
              orElse: () => throw Exception('Tag not found: $tagName'),
            );

            await _database
                .into(_database.journalTags)
                .insert(
                  JournalTagsCompanion.insert(
                    journalId: backupJournal.id,
                    tagId: tagMap[tag.id]!,
                  ),
                );
          }
        }
      }

      _log.info('Backup data restored successfully');
    } catch (e, s) {
      _log.severe('Error restoring backup data', e, s);
      rethrow;
    }
  }
}
