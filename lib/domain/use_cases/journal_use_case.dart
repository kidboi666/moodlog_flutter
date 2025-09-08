import '../../core/utils/result.dart';
import '../entities/create_journal_dto.dart';
import '../entities/journal.dart';
import '../entities/update_journal_dto.dart';
import '../repositories/journal_repository.dart';

class JournalUseCase {
  final JournalRepository _journalRepository;

  JournalUseCase({required JournalRepository journalRepository})
    : _journalRepository = journalRepository;

  Future<Result<Map<String, dynamic>>> addJournal(CreateJournalDto dto) async {
    return await _journalRepository.addJournal(dto);
  }

  Future<Result<List<Journal>>> getJournals() async {
    return await _journalRepository.getAllJournals();
  }

  Future<Result<Journal>> getJournalById(int id) async {
    return await _journalRepository.getJournalById(id);
  }

  Future<void> deleteJournal(int id) async {
    _journalRepository.deleteJournalById(id);
  }

  Future<Result<int>> updateJournal(UpdateJournalDto dto) async {
    return await _journalRepository.updateJournal(dto);
  }
}
