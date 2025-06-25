import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/core/utils/result.dart';

import '../../../domain/entities/journal.dart';
import '../../../domain/repositories/journal_repository.dart';

class JournalViewModel extends ChangeNotifier {
  final JournalRepository _journalRepository;

  JournalViewModel({required JournalRepository journalRepository})
    : _journalRepository = journalRepository;

  final Logger _logger = Logger('JournalViewModel');
  Journal? _journal;

  Journal? get journal => _journal;

  Future<Result<void>> load(int id) async {
    final journal = await _journalRepository.getJournalById(id);
    switch (journal) {
      case Ok<Journal>():
        _logger.fine('Loaded Journal');
        _journal = journal.value;
        notifyListeners();
        return Result.ok(null);
      case Error<Journal>():
        _logger.warning('Failed to load Journal', journal.error);
        return Result.error(journal.error);
    }
  }
}
