import '../../core/utils/result.dart';
import '../entities/create_journal_dto.dart';
import '../entities/update_journal_dto.dart';
import '../repositories/journal_repository.dart';

class JournalUseCase {
  final JournalRepository _journalRepository;

  JournalUseCase({required JournalRepository journalRepository})
      : _journalRepository = journalRepository;

  Future<Result<Map<String, dynamic>>> addJournal(CreateJournalDto dto) async {
    return await _journalRepository.addJournal(dto);
  }

  Future<void> deleteJournal(int id) async {
    _journalRepository.deleteJournalById(id);
  }

  Future<Result<int>> updateJournal(UpdateJournalDto dto) async {
    return await _journalRepository.updateJournal(dto);
  }
}