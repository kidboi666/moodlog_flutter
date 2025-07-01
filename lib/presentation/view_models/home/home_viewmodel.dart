import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/domain/repositories/app_state_repository.dart';

import '../../../core/extensions/date_time.dart';
import '../../../core/utils/result.dart';
import '../../../domain/entities/journal.dart';
import '../../../domain/repositories/journal_repository.dart';

enum DateItem { date, day }

class HomeViewModel extends ChangeNotifier {
  final JournalRepository _journalRepository;
  final AppStateRepository _appStateRepository;

  HomeViewModel({
    required JournalRepository journalRepository,
    required AppStateRepository appStateRepository,
  }) : _journalRepository = journalRepository,
       _appStateRepository = appStateRepository {
    _load();
    _loadNickname();
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
  bool _isLoading = false;
  String? _nickname;

  String? get nickname => _nickname;

  List<Journal> get journal => _journal;

  bool get isLoading => _isLoading;

  void onSelectedDateChange(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  Future<void> _load() async {
    _isLoading = true;
    notifyListeners();

    final result = await _journalRepository.getJournals();
    switch (result) {
      case Ok<List<Journal>>():
        _journal = result.value;
        _log.fine('Loaded journals');
      case Error<List<Journal>>():
        _journal = [];
        _log.warning('Failed to load journals', result.error);
    }
    _isLoading = false;
    notifyListeners();
  }

  void _loadNickname() {
    final result = _appStateRepository.appState;
    _nickname = result.nickname;
  }
}
