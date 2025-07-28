import 'package:moodlog/data/models/request/update_journal_request.dart';

import '../../../core/utils/result.dart';
import '../../repositories/journal_repository.dart';

class UpdateJournalUseCase {
  final JournalRepository _journalRepository;

  UpdateJournalUseCase({required JournalRepository journalRepository})
    : _journalRepository = journalRepository;

  Future<Result<int>> execute(UpdateJournalRequest dto) async {
    return await _journalRepository.updateJournal(dto);
  }
}
