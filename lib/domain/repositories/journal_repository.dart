import '../../core/utils/result.dart';
import '../dto/create_journal_request.dart';
import '../entities/journal.dart';
import '../dto/update_journal_request.dart';

abstract class JournalRepository {
  Stream<List<Journal>> get journalStream;

  Future<Result<List<Journal>>> getAllJournals();

  Future<Result<List<Journal>>> getJournalsByMonth(DateTime date);

  Future<Result<List<Journal>>> getJournalsByDate(DateTime date);

  Future<Result<Journal>> getJournalById(int id);

  Future<Result<Map<String, dynamic>>> addJournal(CreateJournalRequest dto);

  Future<Result<int>> updateJournal(UpdateJournalRequest dto);

  Future<Result<void>> deleteJournalById(int id);

  void clearCache();
}
