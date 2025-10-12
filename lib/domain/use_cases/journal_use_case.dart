import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';
import 'package:moodlog/domain/models/create_journal_request.dart';
import 'package:moodlog/domain/models/update_journal_ai_response_request.dart';
import 'package:moodlog/domain/models/update_journal_request.dart';
import 'package:moodlog/domain/repositories/journal_repository.dart';

class JournalUseCase {
  final JournalRepository _journalRepository;

  JournalUseCase({required JournalRepository journalRepository})
    : _journalRepository = journalRepository;

  Future<Result<Map<String, dynamic>>> addJournal(
    CreateJournalRequest dto,
  ) async {
    return await _journalRepository.createJournal(dto);
  }

  Future<Result<List<Journal>>> getJournals() async {
    return await _journalRepository.getJournals();
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

  Future<Result<int>> updateJournalAiResponse(
    UpdateJournalAiResponseRequest dto,
  ) async {
    return await _journalRepository.updateJournalAiResponse(dto);
  }

  Future<Result<List<Journal>>> getJournalsByDate(DateTime date) async {
    return await _journalRepository.getJournalsByDate(date);
  }

  Future<Result<List<Journal>>> getJournalsByTagId(int tagId) async {
    return await _journalRepository.getJournalsByTagId(tagId);
  }

  Future<Result<void>> deleteJournalById(int id) async {
    return await _journalRepository.deleteJournalById(id);
  }

  Future<void> notifyJournalUpdate() async {
    await _journalRepository.notifyJournalUpdate();
  }
}
