import '../../core/utils/result.dart';
import '../dto/create_journal_request.dart';
import '../dto/update_journal_request.dart';
import '../entities/journal/journal.dart';

abstract class JournalRepository {
  Stream<List<Journal>> get journalStream;

  Future<Result<List<Journal>>> getJournals();

  Future<Result<List<Journal>>> getJournalsByMonth(DateTime date);

  Future<Result<List<Journal>>> getJournalsByDate(DateTime date);

  Future<Result<Journal>> getJournalById(int id);

  Future<Result<Map<String, dynamic>>> createJournal(CreateJournalRequest dto);

  Future<Result<int>> updateJournal(UpdateJournalRequest dto);

  Future<Result<void>> deleteJournalById(int id);
}
