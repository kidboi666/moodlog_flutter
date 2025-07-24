import '../../repositories/journal_repository.dart';

class DeleteJournalUseCase {
  final JournalRepository _journalRepository;

  DeleteJournalUseCase({required JournalRepository journalRepository})
    : _journalRepository = journalRepository;

  Future<void> deleteJournal(int id) async {
    _journalRepository.deleteJournalById(id);
  }
}
