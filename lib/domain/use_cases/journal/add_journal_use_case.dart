import '../../../core/utils/result.dart';
import '../../entities/create_journal_dto.dart';
import '../../repositories/journal_repository.dart';

class AddJournalUseCase {
  final JournalRepository _journalRepository;

  AddJournalUseCase({required JournalRepository journalRepository})
    : _journalRepository = journalRepository;

  Future<Result<Map<String, dynamic>>> execute(CreateJournalDto dto) async {
    return await _journalRepository.addJournal(dto);
  }
}
