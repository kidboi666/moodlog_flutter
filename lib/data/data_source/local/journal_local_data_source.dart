import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:logging/logging.dart';

import '../../../core/utils/result.dart';
import '../../../domain/entities/journal/journal.dart';
import '../../../domain/models/create_journal_request.dart';
import '../../../domain/models/update_journal_ai_response_request.dart';
import '../../../domain/models/update_journal_request.dart';
import 'database/database.dart';

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

  Future<Journal?> addJournal(CreateJournalRequest request) async {
    try {
      return await _db.transaction(() async {
        // 1. Insert the journal
        final journalCompanion = JournalsCompanion(
          content: Value(request.content),
          moodType: Value(request.moodType),
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
}
