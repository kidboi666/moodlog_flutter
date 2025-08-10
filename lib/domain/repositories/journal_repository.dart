import '../../core/utils/result.dart';
import '../entities/create_journal_dto.dart';
import '../entities/journal.dart';
import '../entities/update_journal_dto.dart';

abstract class JournalRepository {
  Stream<List<Journal>> get journalStream;

  Future<Result<List<Journal>>> getAllJournals();

  Future<Result<List<Journal>>> getJournalsByMonth(DateTime date);

  Future<Result<List<Journal>>> getJournalsByDate(DateTime date);

  Future<Result<Journal>> getJournalById(int id);

  Future<Result<Map<String, dynamic>>> addJournal(CreateJournalDto dto);

  Future<Result<int>> updateJournal(UpdateJournalDto dto);

  Future<Result<void>> deleteJournalById(int id);

  void clearCache();
}
