import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../core/extensions/date_time.dart';
import '../../../core/utils/result.dart';
import '../../../domain/entities/journal.dart';
import '../../../domain/repositories/journal_repository.dart';

enum DateItem { date, day }

class HomeViewModel extends ChangeNotifier {
  final JournalRepository _journalRepository;

  HomeViewModel({required JournalRepository journalRepository})
    : _journalRepository = journalRepository {
    _load();
  }

  final Logger _log = Logger('HomeViewModel');
  List<Journal> _journal = [];
  DateTime selectedDate = DateTime.now();
  final List<Map<DateItem, String>> dateItems = List.generate(
    DateTime.now().lastDateOfMonth,
    (index) {
      return {
        DateItem.date: '${index + 1}',
        DateItem.day: '월화수목금토일'[index % 7],
      };
    },
  );

  List<Journal> get journal => _journal;

  void onSelectedDateChange(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  Future<Result<void>> _load() async {
    final result = await _journalRepository.getJournals();
    switch (result) {
      case Ok<List<Journal>>():
        _journal = result.value;
        _log.fine('Loaded User');
      case Error<List<Journal>>():
        _journal = [];
        _log.warning('Failed to load journals', result.error);
    }
    notifyListeners();
    return Result.ok(null);
  }
}
