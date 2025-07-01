import 'package:drift/drift.dart';

import '../../core/utils/result.dart';
import '../../domain/entities/journal.dart';
import '../../domain/repositories/journal_repository.dart';
import '../data_source/database.dart';
import '../models/request/add_journal_request.dart';

class JournalRepositoryImpl implements JournalRepository {
  final MoodLogDatabase _db;

  JournalRepositoryImpl({required MoodLogDatabase? db}) : _db = db!;

  @override
  Future<Result<List<Journal>>> getJournalsByMonth(DateTime date) async {
    final startOfMonth = DateTime(date.year, date.month, 1);
    final endOfMonth = DateTime(date.year, date.month + 1, 0);

    final journals =
        await (_db.select(_db.journals)..where(
              (t) => t.createdAt.isBetween(
                Variable(startOfMonth),
                Variable(endOfMonth),
              ),
            ))
            .get();

    if (journals.isEmpty) {
      return Result.error(Exception('journals not found for the month'));
    }
    return Result.ok(journals);
  }

  @override
  Future<Result<List<Journal>>> getJournalsByDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
    final journals =
        await (_db.select(_db.journals)..where(
              (t) => t.createdAt.isBetween(
                Variable(startOfDay),
                Variable(endOfDay),
              ),
            ))
            .get();
    if (journals.isEmpty) {
      return Result.error(Exception('journals not found for the day'));
    }
    return Result.ok(journals);
  }

  @override
  Future<Result<Journal>> getJournalById(int id) async {
    final journal = await (_db.select(
      _db.journals,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    if (journal == null) {
      return Result.error(Exception('journal not found'));
    }
    return Result.ok(journal);
  }

  @override
  Future<Result<int>> addJournal(AddJournalRequest dto) async {
    final journal = await _db
        .into(_db.journals)
        .insertReturningOrNull(
          JournalsCompanion(
            content: Value(dto.content),
            moodType: Value(dto.moodType),
            imageUri: Value(dto.imageUri),
            createdAt: Value(dto.createdAt),
          ),
        );
    if (journal == null) {
      return Result.error(Exception('Failed to add journal'));
    }
    return Result.ok(journal.id);
  }

  @override
  Future<Result<void>> deleteJournalById(int id) async {
    final deletedRows = await (_db.delete(
      _db.journals,
    )..where((t) => t.id.equals(id))).go();

    if (deletedRows == 0) {
      return Result.error(Exception('Failed to delete journal'));
    }
    return Result.ok(null);
  }
}
