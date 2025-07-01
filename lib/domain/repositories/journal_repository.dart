import '../../core/utils/result.dart';
import '../../data/models/request/add_journal_request.dart';
import '../entities/journal.dart';

abstract class JournalRepository {
  Future<Result<List<Journal>>> getJournalsByMonth(DateTime date);

  Future<Result<List<Journal>>> getJournalsByDate(DateTime date);

  Future<Result<Journal>> getJournalById(int id);

  Future<Result<int>> addJournal(AddJournalRequest dto);

  Future<Result<void>> deleteJournalById(int id);
}
