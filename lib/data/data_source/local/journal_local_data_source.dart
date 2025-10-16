import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/data/data_source/local/database/database.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';
import 'package:moodlog/domain/entities/journal/tag.dart';
import 'package:moodlog/domain/models/create_journal_request.dart';
import 'package:moodlog/domain/models/update_journal_ai_response_request.dart';
import 'package:moodlog/domain/models/update_journal_request.dart';

class JournalLocalDataSource {
  final MoodLogDatabase _db;
  final Logger _log = Logger('JournalLocalDataSource');

  JournalLocalDataSource({MoodLogDatabase? db}) : _db = db ?? MoodLogDatabase();

  Future<List<Journal>> getJournals() async {
    try {
      return await _db.select(_db.journals).get();
    } on SqliteException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Tag>> getAllTags() async {
    try {
      return await _db.select(_db.tags).get();
    } on SqliteException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Journal?> getJournalById(int journalId) async {
    try {
      return await (_db.select(
        _db.journals,
      )..where((t) => t.id.equals(journalId))).getSingleOrNull();
    } on SqliteException catch (e, s) {
      _log.severe('Error in getJournalById', e, s);
      throw Exception(e);
    } catch (e, s) {
      _log.severe('Error in getJournalById', e, s);
      throw Exception(e);
    }
  }

  Future<List<Journal>> getJournalsByMonth(
    DateTime startOfMonth,
    DateTime endOfMonth,
  ) async {
    try {
      return await (_db.select(_db.journals)..where(
            (t) => t.createdAt.isBetween(
              Variable(startOfMonth),
              Variable(endOfMonth),
            ),
          ))
          .get();
    } on SqliteException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Journal>> getJournalsByDate(
    DateTime startOfDay,
    DateTime endOfDay,
  ) async {
    try {
      return await (_db.select(_db.journals)..where(
            (t) =>
                t.createdAt.isBetween(Variable(startOfDay), Variable(endOfDay)),
          ))
          .get();
    } on SqliteException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> hasTodayCheckIn() async {
    try {
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);
      final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);

      final checkIns = await (_db.select(_db.journals)
            ..where((t) =>
                t.createdAt.isBetween(Variable(startOfDay), Variable(endOfDay)) &
                t.entryType.equals(0))) // 0 = EntryType.quickCheckIn
          .get();

      return checkIns.isNotEmpty;
    } on SqliteException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Journal>> getJournalsByTagId(int tagId) async {
    try {
      final query =
          _db.select(_db.journals).join([
              innerJoin(
                _db.journalTags,
                _db.journalTags.journalId.equalsExp(_db.journals.id),
              ),
            ])
            ..where(_db.journalTags.tagId.equals(tagId))
            ..orderBy([OrderingTerm.desc(_db.journals.createdAt)]);

      return await query.map((row) => row.readTable(_db.journals)).get();
    } on SqliteException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Journal?> addJournal(CreateJournalRequest request) async {
    try {
      return await _db.transaction(() async {
        // 1. Insert the journal
        final journalCompanion = JournalsCompanion(
          content: Value(request.content),
          note: Value(request.note),
          moodType: Value(request.moodType),
          entryType: Value(request.entryType),
          imageUri: Value(request.imageUri),
          createdAt: Value(request.createdAt),
          aiResponseEnabled: Value(request.aiResponseEnabled),
          latitude: Value(request.latitude),
          longitude: Value(request.longitude),
          address: Value(request.address),
          temperature: Value(request.temperature),
          weatherIcon: Value(request.weatherIcon),
          weatherDescription: Value(request.weatherDescription),
          tagNames: Value(request.tagNames),
          sleepQuality: Value(request.sleepQuality),
        );

        final newJournal = await _db
            .into(_db.journals)
            .insertReturning(journalCompanion);

        // 2. Handle tags
        if (request.tagNames != null && request.tagNames!.isNotEmpty) {
          final List<int> tagIds = [];

          for (final tagName in request.tagNames!) {
            // Find existing tag or create a new one
            var existingTag = await (_db.select(
              _db.tags,
            )..where((t) => t.name.equals(tagName))).getSingleOrNull();

            int tagId;
            if (existingTag != null) {
              tagId = existingTag.id;
            } else {
              tagId = await _db
                  .into(_db.tags)
                  .insert(TagsCompanion(name: Value(tagName)));
            }
            tagIds.add(tagId);
          }

          // 3. Link tags to the journal in the join table
          for (final tagId in tagIds) {
            await _db
                .into(_db.journalTags)
                .insert(
                  JournalTagsCompanion(
                    journalId: Value(newJournal.id),
                    tagId: Value(tagId),
                  ),
                  mode: InsertMode.insertOrIgnore, // Ignore if already linked
                );
          }
        }

        return newJournal;
      });
    } on SqliteException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<int> updateJournal(UpdateJournalRequest request) async {
    try {
      return await (_db.update(
        _db.journals,
      )..where((t) => t.id.equals(request.id))).write(
        JournalsCompanion(
          aiResponseEnabled: Value(request.aiResponseEnabled),
          moodType: Value(request.moodType),
          content: request.content == null
              ? const Value.absent()
              : Value(request.content),
          imageUri: request.imageUri == null
              ? const Value.absent()
              : Value(request.imageUri),
          latitude: request.latitude == null
              ? const Value.absent()
              : Value(request.latitude),
          longitude: request.longitude == null
              ? const Value.absent()
              : Value(request.longitude),
          address: request.address == null
              ? const Value.absent()
              : Value(request.address),
          tagNames: Value(request.tagNames),
        ),
      );
    } on SqliteException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<int> updateJournalAiResponse(
    UpdateJournalAiResponseRequest request,
  ) async {
    try {
      return await (_db.update(
        _db.journals,
      )..where((t) => t.id.equals(request.id))).write(
        JournalsCompanion(
          aiResponseEnabled: Value(request.aiResponseEnabled),
          aiResponse: request.aiResponse == null
              ? const Value.absent()
              : Value(request.aiResponse),
        ),
      );
    } on SqliteException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<int> deleteJournalById(int id) async {
    try {
      return await (_db.delete(
        _db.journals,
      )..where((t) => t.id.equals(id))).go();
    } on SqliteException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> getJournalTags(List<int> journalIds) async {
    try {
      final journalTags = await (_db.select(_db.journalTags).join([
        leftOuterJoin(_db.tags, _db.tags.id.equalsExp(_db.journalTags.tagId)),
      ])..where(_db.journalTags.journalId.isIn(journalIds))).get();
      return Result.ok(journalTags);
    } on SqliteException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> clearAllData() async {
    try {
      await _db.transaction(() async {
        await _db.delete(_db.journalTags).go();
        await _db.delete(_db.journals).go();
        await _db.delete(_db.tags).go();
      });
    } catch (e, s) {
      _log.severe('Error clearing all data', e, s);
      throw Exception(e);
    }
  }

  Future<void> insertJournalsAndTags(
    List<JournalsCompanion> journals,
    List<TagsCompanion> tags,
  ) async {
    try {
      await _db.batch((batch) {
        batch.insertAll(_db.journals, journals, mode: InsertMode.replace);
        batch.insertAll(_db.tags, tags, mode: InsertMode.replace);
        // Note: Journal-Tag relationships must be rebuilt separately
        // if they are not included in the journal/tag data itself.
      });
    } catch (e, s) {
      _log.severe('Error inserting journals and tags', e, s);
      throw Exception(e);
    }
  }

  Future<void> linkJournalsToTags(
    Map<int, List<String>> journalToTagsMap,
  ) async {
    try {
      await _db.batch((batch) async {
        for (final entry in journalToTagsMap.entries) {
          final journalId = entry.key;
          final tagNames = entry.value;

          if (tagNames.isEmpty) continue;

          final tags = await (_db.select(
            _db.tags,
          )..where((t) => t.name.isIn(tagNames))).get();
          final tagIds = tags.map((t) => t.id).toList();

          for (final tagId in tagIds) {
            batch.insert(
              _db.journalTags,
              JournalTagsCompanion(
                journalId: Value(journalId),
                tagId: Value(tagId),
              ),
              mode: InsertMode.insertOrIgnore,
            );
          }
        }
      });
    } catch (e, s) {
      _log.severe('Error linking journals to tags', e, s);
      throw Exception(e);
    }
  }
}
