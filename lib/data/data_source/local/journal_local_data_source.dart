import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import '../../../core/utils/result.dart';
import '../../../domain/dto/update_journal_request.dart';
import '../../../domain/entities/journal/journal.dart';
import '../../models/request/add_journal_request.dart';
import 'database/database.dart';

class JournalLocalDataSource {
  final MoodLogDatabase _db;

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
    } on SqliteException catch (e) {
      throw Exception(e);
    } catch (e) {
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

  Future<Journal?> addJournal(AddJournalRequest request) async {
    try {
      return await _db
          .into(_db.journals)
          .insertReturningOrNull(
            JournalsCompanion(
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
            ),
          );
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
          content: request.content == null
              ? Value.absent()
              : Value(request.content),
          imageUri: request.imageUri == null
              ? Value.absent()
              : Value(request.imageUri),
          aiResponse: request.aiResponse == null
              ? Value.absent()
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
