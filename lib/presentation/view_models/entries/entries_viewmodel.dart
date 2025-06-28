import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/core/utils/result.dart';

import '../../../domain/entities/journal.dart';
import '../../../domain/repositories/journal_repository.dart';

class EntriesViewModel extends ChangeNotifier {
  final JournalRepository _journalRepository;

  EntriesViewModel({required JournalRepository journalRepository})
    : _journalRepository = journalRepository {
    _load();
  }

  final Logger _log = Logger('EntriesViewModel');
  DateTime selectedDate = DateTime.now();
  List<Journal> _entries = [];
  bool _isLoading = false;

  List<Journal> get entries => _entries;

  bool get isLoading => _isLoading;

  Future<void> _load() async {
    _isLoading = true;
    notifyListeners();

    final result = await _journalRepository.getJournalsByMonth(selectedDate);
    switch (result) {
      case Ok<List<Journal>>():
        _entries = result.value;
        _log.fine('Loaded journals');
      case Error<List<Journal>>():
        _entries = [];
        _log.warning('Failed to load journals', result.error);
    }
    _isLoading = false;
    notifyListeners();
  }
}
