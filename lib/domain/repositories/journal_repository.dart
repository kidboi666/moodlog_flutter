import '../../data/models/request/add_journal_request.dart';

abstract class JournalRepository {
  Future<List<dynamic>> getJournals();

  Stream<dynamic> getJournalById(int id);

  Future<void> addJournal(AddJournalRequest dto);
}
