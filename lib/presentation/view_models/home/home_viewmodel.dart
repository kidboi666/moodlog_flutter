import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/core/extensions/date_time.dart';

import '../../../core/utils/result.dart';
import '../../../domain/entities/journal.dart';
import '../../../domain/repositories/app_state_repository.dart';
import '../../../domain/repositories/journal_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final JournalRepository _journalRepository;
  final AppStateRepository _appStateRepository;

  HomeViewModel({
    required JournalRepository journalRepository,
    required AppStateRepository appStateRepository,
  }) : _journalRepository = journalRepository,
       _appStateRepository = appStateRepository {
    _calculateDateItems();
    _load();
    _loadNickname();
  }

  final Logger _log = Logger('HomeViewModel');
  final DateTime _now = DateTime.now();
  List<Journal> _journal = [];
  DateTime _selectedDate = DateTime.now();
  List<DateTime>? _dateItems;
  bool _isLoading = false;
  String? _nickname;
  bool _firstMount = true;

  DateTime get selectedDate => _selectedDate;

  DateTime get now => _now;

  List<DateTime>? get dateItems => _dateItems;

  String? get nickname => _nickname;

  bool get firstMount => _firstMount;

  List<Journal> get journal => _journal;

  bool get isLoading => _isLoading;

  void _calculateDateItems() {
    final currentDate = DateTime.now();
    final lastDateOfMonth = currentDate.lastDateOfMonth;

    List<DateTime> dates = List.generate(
      lastDateOfMonth,
      (index) => DateTime(currentDate.year, currentDate.month, index + 1),
    );

    _dateItems = dates;
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
    _load();
  }

  Future<void> _load() async {
    _isLoading = true;
    notifyListeners();

    final result = await _journalRepository.getJournalsByDate(_selectedDate);
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

  Future<void> setFirstMount() async {
    _firstMount = false;
    notifyListeners();
  }

  void _loadNickname() {
    final result = _appStateRepository.appState;
    _nickname = result.nickname;
    notifyListeners();
  }
}
