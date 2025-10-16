import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';
import 'package:moodlog/domain/models/create_journal_request.dart';
import 'package:moodlog/domain/models/update_journal_request.dart';
import 'package:moodlog/domain/repositories/journal_repository.dart';

class JournalUseCase {
  final JournalRepository _journalRepository;

  JournalUseCase({required JournalRepository journalRepository})
      : _journalRepository = journalRepository;

  Future<Result<int>> createJournal(CreateJournalRequest request) async {
    return await _journalRepository.createJournal(request);
  }

  Future<Result<List<Journal>>> getJournals() async {
    return await _journalRepository.getJournals();
  }

  Future<Result<Journal?>> getJournalById(int id) async {
    return await _journalRepository.getJournalById(id);
  }

  Future<Result<List<Journal>>> getJournalsByMonth(
    DateTime selectedMonth,
  ) async {
    return await _journalRepository.getJournalsByMonth(selectedMonth);
  }

  Future<Result<List<Journal>>> getJournalsByDate(DateTime date) async {
    return await _journalRepository.getJournalsByDate(date);
  }

  Future<Result<int>> updateJournal(UpdateJournalRequest request) async {
    return await _journalRepository.updateJournal(request);
  }

  Future<Result<void>> deleteJournalById(int id) async {
    return await _journalRepository.deleteJournalById(id);
  }

  Future<void> notifyJournalUpdate() async {
    await _journalRepository.notifyJournalUpdate();
  }
}
