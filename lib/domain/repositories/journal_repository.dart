import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';
import 'package:moodlog/domain/models/create_journal_request.dart';
import 'package:moodlog/domain/models/update_journal_ai_response_request.dart';
import 'package:moodlog/domain/models/update_journal_request.dart';

abstract class JournalRepository {
  Stream<List<Journal>> get journalStream;

  Future<Result<List<Journal>>> getJournals();

  Future<Result<List<Journal>>> getJournalsByMonth(DateTime date);

  Future<Result<List<Journal>>> getJournalsByDate(DateTime date);

  Future<Result<List<Journal>>> getJournalsByTagId(int tagId);

  Future<Result<Journal>> getJournalById(int id);

  Future<Result<Map<String, dynamic>>> createJournal(CreateJournalRequest dto);

  Future<Result<int>> updateJournal(UpdateJournalRequest dto);

  Future<Result<int>> updateJournalAiResponse(
    UpdateJournalAiResponseRequest dto,
  );

  Future<Result<void>> deleteJournalById(int id);

  Future<void> notifyJournalUpdate();
}
