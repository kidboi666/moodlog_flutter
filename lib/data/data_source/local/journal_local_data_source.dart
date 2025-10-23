import 'package:drift/drift.dart';
import 'package:moodlog/data/data_source/local/database/database.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';
import 'package:moodlog/domain/models/create_journal_request.dart';
import 'package:moodlog/domain/models/update_journal_request.dart';

class JournalLocalDataSource {
  final MoodLogDatabase _db;

  JournalLocalDataSource({MoodLogDatabase? db}) : _db = db ?? MoodLogDatabase();

  Future<List<Journal>> getJournals() async {
    return await _db.select(_db.journals).get();
  }

  Future<Journal?> getJournalById(int journalId) async {
    return await (_db.select(
      _db.journals,
    )..where((t) => t.id.equals(journalId))).getSingleOrNull();
  }

  Future<List<Journal>> getJournalsByMonth(
    DateTime startOfMonth,
    DateTime endOfMonth,
  ) async {
    return await (_db.select(_db.journals)..where(
          (t) => t.createdAt.isBetween(
            Variable(startOfMonth),
            Variable(endOfMonth),
          ),
        ))
        .get();
  }

  Future<List<Journal>> getJournalsByDate(
    DateTime startOfDay,
    DateTime endOfDay,
  ) async {
    return await (_db.select(_db.journals)..where(
          (t) =>
              t.createdAt.isBetween(Variable(startOfDay), Variable(endOfDay)),
        ))
        .get();
  }

  Stream<List<Journal>> watchJournalsByDate(DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    return (_db.select(_db.journals)
          ..where((t) => t.createdAt.isBetweenValues(startOfDay, endOfDay))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();
  }

  Future<Journal?> addJournal(CreateJournalRequest request) async {
    return await _db.transaction(() async {
      final journalCompanion = JournalsCompanion(
        content: Value(request.content),
        imageUri: Value(request.imageUri),
        createdAt: Value(request.createdAt),
        latitude: Value(request.latitude),
        longitude: Value(request.longitude),
        address: Value(request.address),
        temperature: Value(request.temperature),
        weatherIcon: Value(request.weatherIcon),
        weatherDescription: Value(request.weatherDescription),
      );

      final newJournal = await _db
          .into(_db.journals)
          .insertReturning(journalCompanion);

      return newJournal;
    });
  }

  Future<int> updateJournal(UpdateJournalRequest request) async {
    return await (_db.update(
      _db.journals,
    )..where((t) => t.id.equals(request.id))).write(
      JournalsCompanion(
        content: Value(request.content),
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
        temperature: request.temperature == null
            ? const Value.absent()
            : Value(request.temperature),
        weatherIcon: request.weatherIcon == null
            ? const Value.absent()
            : Value(request.weatherIcon),
        weatherDescription: request.weatherDescription == null
            ? const Value.absent()
            : Value(request.weatherDescription),
      ),
    );
  }

  Future<int> deleteJournalById(int id) async {
    return await (_db.delete(_db.journals)..where((t) => t.id.equals(id))).go();
  }

  Future<void> clearAllData() async {
    await _db.transaction(() async {
      await _db.delete(_db.journals).go();
    });
  }

  Future<void> insertJournals(List<JournalsCompanion> journals) async {
    await _db.batch((batch) {
      batch.insertAll(_db.journals, journals, mode: InsertMode.replace);
    });
  }
}
