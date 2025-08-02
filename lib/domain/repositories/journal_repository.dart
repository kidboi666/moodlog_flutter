import '../../common/utils/result.dart';
import '../../data/models/request/add_journal_request.dart';
import '../../data/models/request/update_journal_request.dart';
import '../entities/journal.dart';

abstract class JournalRepository {
  Stream<List<Journal>> get journalStream;

  Future<Result<List<Journal>>> getAllJournals();

  Future<Result<List<Journal>>> getJournalsByMonth(DateTime date);

  Future<Result<List<Journal>>> getJournalsByDate(DateTime date);

  Future<Result<Journal>> getJournalById(int id);

  Future<Result<Map<String, dynamic>>> addJournal(AddJournalRequest dto);

  Future<Result<int>> updateJournal(UpdateJournalRequest dto);

  Future<Result<void>> deleteJournalById(int id);

  void clearCache();
}
