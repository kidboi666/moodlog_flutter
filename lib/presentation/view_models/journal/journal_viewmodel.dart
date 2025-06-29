import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../core/utils/result.dart';
import '../../../domain/entities/journal.dart';
import '../../../domain/repositories/journal_repository.dart';

class JournalViewModel extends ChangeNotifier {
  final JournalRepository _journalRepository;
  final String source;
  final int id;

  JournalViewModel({
    required JournalRepository journalRepository,
    required this.source,
    required this.id,
  }) : _journalRepository = journalRepository {
    _load();
  }

  final Logger _log = Logger('JournalViewModel');
  Journal? _journal;

  Journal? get journal => _journal;

  Future<Result<void>> _load() async {
    final journal = await _journalRepository.getJournalById(id);
    switch (journal) {
      case Ok<Journal>():
        _log.fine('Loaded Journal');
        _journal = journal.value;
        notifyListeners();
        return Result.ok(null);
      case Error<Journal>():
        _log.warning('Failed to load Journal', journal.error);
        notifyListeners();
        return Result.error(journal.error);
    }
  }
}
