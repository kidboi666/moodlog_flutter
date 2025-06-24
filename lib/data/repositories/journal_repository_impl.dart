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
  Future<Result<List<Journal>>> getJournals() async {
    final journals = await (_db.select(_db.journals)).get();
    if (journals.isEmpty) {
      return Result.error(Exception('journals not found'));
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
  Future<Result<Journal>> addJournal(AddJournalRequest dto) async {
    final journal = await _db
        .into(_db.journals)
        .insertReturningOrNull(
          JournalsCompanion(
            content: Value(dto.content),
            moodName: Value(dto.moodName),
            imageUri: Value(dto.imageUri),
          ),
        );
    if (journal == null) {
      return Result.error(Exception('journal not found'));
    }
    return Result.ok(journal);
  }
}
