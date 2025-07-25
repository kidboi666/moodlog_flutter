import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/core/mixins/async_state_mixin.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/use_cases/journal/delete_journal_use_case.dart';

import '../../../domain/entities/journal.dart';
import '../../../domain/repositories/journal_repository.dart';

class EntriesViewModel extends ChangeNotifier with AsyncStateMixin {
  final JournalRepository _journalRepository;
  final DeleteJournalUseCase _deleteJournalUseCase;

  EntriesViewModel({
    required JournalRepository journalRepository,
    required DeleteJournalUseCase deleteJournalUseCase,
  }) : _journalRepository = journalRepository,
       _deleteJournalUseCase = deleteJournalUseCase {
    _loadMonthEntries();
  }

  final Logger _log = Logger('EntriesViewModel');
  DateTime selectedDate = DateTime.now();
  DateTime _selectedMonth = DateTime.now();
  List<Journal> _entries = [];

  List<Journal> get entries => _entries;

  DateTime get selectedMonth => _selectedMonth;

  void setPreviousMonth() {
    _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1, 1);
    notifyListeners();
    _loadMonthEntries();
  }

  void setNextMonth() {
    _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1, 1);
    notifyListeners();
    _loadMonthEntries();
  }

  Future<void> deleteJournal(int id) async {
    setLoading();
    await _deleteJournalUseCase.deleteJournal(id);
  }

  Future<void> _loadMonthEntries() async {
    setLoading();

    final result = await _journalRepository.getJournalsByMonth(_selectedMonth);
    switch (result) {
      case Ok<List<Journal>>():
        _entries = result.value;
        _log.fine('Loaded journals');
      case Failure<List<Journal>>():
        _entries = [];
        setError(result.error);
        _log.warning('Failed to load journals', result.error);
    }
    setSuccess();
  }
}
