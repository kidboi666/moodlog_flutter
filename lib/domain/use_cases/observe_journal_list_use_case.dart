import 'package:moodlog/domain/entities/journal/journal.dart';
import 'package:moodlog/domain/repositories/journal_repository.dart';

class ObserveJournalListUseCase {
  final JournalRepository _journalRepository;

  ObserveJournalListUseCase({required JournalRepository journalRepository})
    : _journalRepository = journalRepository;

  Stream<List<Journal>> call() => _journalRepository.journalStream;
}
