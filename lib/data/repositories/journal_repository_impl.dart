import 'dart:async';

import 'package:logging/logging.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/data/data_source/local/journal_local_data_source.dart';
import 'package:moodlog/data/data_source/local/tag_local_data_source.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';
import 'package:moodlog/domain/models/create_journal_request.dart';
import 'package:moodlog/domain/models/update_journal_ai_response_request.dart';
import 'package:moodlog/domain/models/update_journal_request.dart';
import 'package:moodlog/domain/repositories/journal_repository.dart';

class JournalRepositoryImpl implements JournalRepository {
  final JournalLocalDataSource _journalLocalDataSource;
  final TagLocalDataSource _tagLocalDataSource;
  final Logger _log = Logger('JournalRepositoryImpl');

  JournalRepositoryImpl({
    required JournalLocalDataSource localDataSource,
    required TagLocalDataSource tagLocalDataSource,
  }) : _journalLocalDataSource = localDataSource,
       _tagLocalDataSource = tagLocalDataSource;

  final _journalStreamController = StreamController<List<Journal>>.broadcast();

  @override
  Stream<List<Journal>> get journalStream => _journalStreamController.stream;

  @override
  Future<Result<List<Journal>>> getJournals() async {
    try {
      final journals = await _journalLocalDataSource.getJournals();
      // Fetch tags for each journal
      final journalsWithTags = <Journal>[];
      for (final journal in journals) {
        final tags = await _tagLocalDataSource.getTagsByJournalId(journal.id);
        journalsWithTags.add(journal.attachTags(tags));
      }
      return Result.ok(journalsWithTags);
    } catch (e) {
      return Result.error(Exception('Failed to get journals: $e'));
    }
  }

  @override
  Future<Result<List<Journal>>> getJournalsByMonth(DateTime date) async {
    final startOfMonth = DateTime(date.year, date.month, 1);
    final endOfMonth = DateTime(date.year, date.month + 1, 0);
    try {
      final journals = await _journalLocalDataSource.getJournalsByMonth(
        startOfMonth,
        endOfMonth,
      );
      final journalsWithTags = <Journal>[];
      for (final journal in journals) {
        final tags = await _tagLocalDataSource.getTagsByJournalId(journal.id);
        journalsWithTags.add(journal.attachTags(tags));
      }
      return Result.ok(journalsWithTags);
    } catch (e) {
      return Result.error(Exception('Failed to get journals: $e'));
    }
  }

  @override
  Future<Result<List<Journal>>> getJournalsByDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
    try {
      final journals = await _journalLocalDataSource.getJournalsByDate(
        startOfDay,
        endOfDay,
      );

      // Fetch tags for each journal
      final journalsWithTags = <Journal>[];
      for (final journal in journals) {
        final tags = await _tagLocalDataSource.getTagsByJournalId(journal.id);
        journalsWithTags.add(journal.attachTags(tags));
      }

      return Result.ok(journalsWithTags);
    } catch (e) {
      return Result.error(Exception('Failed to get journals: $e'));
    }
  }

  @override
  Future<Result<List<Journal>>> getJournalsByTagId(int tagId) async {
    try {
      final journals = await _journalLocalDataSource.getJournalsByTagId(tagId);
      final journalsWithTags = <Journal>[];
      for (final journal in journals) {
        final tags = await _tagLocalDataSource.getTagsByJournalId(journal.id);
        journalsWithTags.add(journal.attachTags(tags));
      }
      return Result.ok(journalsWithTags);
    } catch (e) {
      return Result.error(Exception('Failed to get journals by tag: $e'));
    }
  }

  @override
  Future<Result<Journal>> getJournalById(int id) async {
    try {
      final journal = await _journalLocalDataSource.getJournalById(id);
      if (journal == null) {
        return Result.error(Exception('Journal not found'));
      }
      final tags = await _tagLocalDataSource.getTagsByJournalId(journal.id);
      final journalWithTags = journal.attachTags(tags);
      return Result.ok(journalWithTags);
    } catch (e, s) {
      _log.severe('Failed to get journal by id', e, s);
      return Result.error(Exception('Failed to get journal: $e'));
    }
  }

  @override
  Future<Result<Map<String, dynamic>>> createJournal(
    CreateJournalRequest dto,
  ) async {
    final request = CreateJournalRequest(
      content: dto.content,
      moodType: dto.moodType,
      entryType: dto.entryType,
      note: dto.note,
      imageUri: dto.imageUri,
      aiResponseEnabled: dto.aiResponseEnabled,
      aiResponse: dto.aiResponse,
      createdAt: dto.createdAt,
      latitude: dto.latitude,
      longitude: dto.longitude,
      address: dto.address,
      temperature: dto.temperature,
      tagNames: dto.tagNames,
      weatherIcon: dto.weatherIcon,
      weatherDescription: dto.weatherDescription,
    );
    try {
      final journal = await _journalLocalDataSource.addJournal(request);
      final response = {
        'id': journal?.id,
        'aiResponseEnabled': journal?.aiResponseEnabled,
      };
      notifyJournalUpdate();
      return Result.ok(response);
    } catch (e) {
      return Result.error(Exception('Failed to add journal: $e'));
    }
  }

  @override
  Future<Result<int>> updateJournal(UpdateJournalRequest dto) async {
    try {
      final updatedRows = await _journalLocalDataSource.updateJournal(dto);
      if (updatedRows == 0) {
        return Result.error(Exception('Failed to update journal'));
      }
      notifyJournalUpdate();
      return Result.ok(updatedRows);
    } catch (e) {
      return Result.error(Exception('Failed to update journal: $e'));
    }
  }

  @override
  Future<Result<int>> updateJournalAiResponse(
    UpdateJournalAiResponseRequest dto,
  ) async {
    try {
      final updatedRows = await _journalLocalDataSource.updateJournalAiResponse(
        dto,
      );
      if (updatedRows == 0) {
        return Result.error(Exception('Failed to update journal'));
      }
      notifyJournalUpdate();
      return Result.ok(updatedRows);
    } catch (e) {
      return Result.error(Exception('Failed to update journal: $e'));
    }
  }

  @override
  Future<Result<void>> deleteJournalById(int id) async {
    try {
      final deletedRows = await _journalLocalDataSource.deleteJournalById(id);
      if (deletedRows == 0) {
        return Result.error(Exception('Failed to delete journal'));
      }
      notifyJournalUpdate();
      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Failed to delete journal: $e'));
    }
  }

  @override
  Future<void> notifyJournalUpdate() async {
    if (!_journalStreamController.isClosed) {
      final result = await getJournals();
      if (result is Ok<List<Journal>>) {
        _journalStreamController.add(result.value);
      }
    }
  }

  void dispose() {
    _journalStreamController.close();
  }
}
