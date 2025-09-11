import '../entities/journal/journal.dart';
import '../repositories/journal_repository.dart';

class ObserveJournalListUseCase {
  final JournalRepository _journalRepository;
  ObserveJournalListUseCase({required JournalRepository journalRepository})
    : _journalRepository = journalRepository;

  Stream<List<Journal>> call() => _journalRepository.journalStream;
}
