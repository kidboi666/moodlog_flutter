import '../../core/utils/result.dart';
import '../../data/models/request/add_journal_request.dart';
import '../entities/journal.dart';

abstract class JournalRepository {
  Future<Result<List<Journal>>> getJournals();

  Future<Result<Journal>> getJournalById(int id);

  Future<Result<void>> addJournal(AddJournalRequest dto);
}
