import '../../core/utils/result.dart';
import '../dto/create_journal_request.dart';
import '../dto/update_journal_request.dart';
import '../entities/journal/journal.dart';
import '../repositories/journal_repository.dart';

class JournalUseCase {
  final JournalRepository _journalRepository;

  JournalUseCase({required JournalRepository journalRepository})
    : _journalRepository = journalRepository;

  Future<Result<Map<String, dynamic>>> addJournal(
    CreateJournalRequest dto,
  ) async {
    return await _journalRepository.addJournal(dto);
  }

  Future<Result<List<Journal>>> getJournals() async {
    return await _journalRepository.getAllJournals();
  }

  Future<Result<Journal>> getJournalById(int id) async {
    return await _journalRepository.getJournalById(id);
  }

  Future<Result<List<Journal>>> getJournalsByMonth(
    DateTime selectedMonth,
  ) async {
    return await _journalRepository.getJournalsByMonth(selectedMonth);
  }

  Future<Result<void>> deleteJournal(int id) async {
    return await _journalRepository.deleteJournalById(id);
  }

  Future<Result<int>> updateJournal(UpdateJournalRequest dto) async {
    return await _journalRepository.updateJournal(dto);
  }
}
