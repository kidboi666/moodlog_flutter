import 'package:moodlog/data/models/request/add_journal_request.dart';

import '../../../common/utils/result.dart';
import '../../repositories/journal_repository.dart';

class AddJournalUseCase {
  final JournalRepository _journalRepository;

  AddJournalUseCase({required JournalRepository journalRepository})
    : _journalRepository = journalRepository;

  Future<Result<Map<String, dynamic>>> execute(AddJournalRequest dto) async {
    return await _journalRepository.addJournal(dto);
  }
}
