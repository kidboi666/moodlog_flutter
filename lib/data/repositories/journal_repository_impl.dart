import 'package:drift/drift.dart';
import 'package:moodlog/data/models/request/add_journal_request.dart';

import '../../domain/repositories/journal_repository.dart';
import '../data_source/database.dart';

class JournalRepositoryImpl implements JournalRepository {
  final MoodLogDatabase _db;

  JournalRepositoryImpl({required MoodLogDatabase? db}) : _db = db!;

  @override
  Future<List<Journal>> getJournals() async {
    return (_db.select(_db.journals)).get();
  }

  @override
  Stream<dynamic> getJournalById(int id) {
    return (_db.select(
      _db.journals,
    )..where((t) => t.id.equals(id))).watchSingle();
  }

  @override
  Future<void> addJournal(AddJournalRequest dto) async {
    await _db
        .into(_db.journals)
        .insert(
          JournalsCompanion(
            content: Value(dto.content),
            moodName: Value(dto.moodName),
            imageUri: Value(dto.imageUri),
            aiResponseEnabled: Value(dto.aiResponseEnabled),
          ),
        );
  }
}
