import '../../../core/utils/result.dart';
import '../../entities/update_journal_dto.dart';
import '../../repositories/journal_repository.dart';

class UpdateJournalUseCase {
  final JournalRepository _journalRepository;

  UpdateJournalUseCase({required JournalRepository journalRepository})
    : _journalRepository = journalRepository;

  Future<Result<int>> execute(UpdateJournalDto dto) async {
    return await _journalRepository.updateJournal(dto);
  }
}
