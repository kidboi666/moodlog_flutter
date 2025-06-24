import 'package:flutter/material.dart';

import '../../../core/extensions/date_time.dart';
import '../../../core/utils/result.dart';
import '../../../domain/entities/journal.dart';
import '../../../domain/repositories/journal_repository.dart';

enum DateItem { date, day }

class HomeViewModel extends ChangeNotifier {
  final JournalRepository _journalRepository;

  HomeViewModel({required JournalRepository journalRepository})
    : _journalRepository = journalRepository;
  List<Journal> _journal = [];

  DateTime selectedDate = DateTime.now();

  List<Journal> get journal => _journal;

  final List<Map<DateItem, String>> dateItems = List.generate(
    DateTime.now().lastDateOfMonth,
    (index) {
      return {
        DateItem.date: '${index + 1}',
        DateItem.day: '월화수목금토일'[index % 7],
      };
    },
  );

  void onSelectedDateChange(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  Future<Result<void>> load() async {
    try {
      final result = await _journalRepository.getJournals();
      switch (result) {
        case Ok<List<Journal>>():
          _journal = result.value;
        case Error<List<Journal>>():
          _journal = [];
          print(result.error);
      }
    } finally {
      notifyListeners();
    }
    return Result.ok(null);
  }
}
