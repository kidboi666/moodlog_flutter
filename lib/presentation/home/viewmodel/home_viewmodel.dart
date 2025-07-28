import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/domain/use_cases/journal/delete_journal_use_case.dart';

import '../../../core/constants/common.dart';
import '../../../core/extensions/date_time.dart';
import '../../../core/mixins/async_state_mixin.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/utils/result.dart';
import '../../../domain/entities/journal.dart';
import '../../../domain/repositories/journal_repository.dart';

class HomeViewModel extends ChangeNotifier with AsyncStateMixin {
  final JournalRepository _journalRepository;
  final UserProvider _userProvider;
  final DeleteJournalUseCase _deleteJournalUseCase;

  HomeViewModel({
    required JournalRepository journalRepository,
    required UserProvider userProvider,
    required DeleteJournalUseCase deleteJournalUseCase,
  }) : _journalRepository = journalRepository,
       _userProvider = userProvider,
       _deleteJournalUseCase = deleteJournalUseCase {
    _calculateDateItems();
    _load();
    _initializeDelayedRender();
    _subscribeToJournalChanges();
  }

  final Logger _log = Logger('HomeViewModel');
  StreamSubscription? _journalSubscription;
  final DateTime _now = DateTime.now();
  List<Journal> _journal = [];
  DateTime _selectedDate = DateTime.now();
  List<DateTime>? _dateItems;
  bool _isFirstRender = true;

  String? get profileImage => _userProvider.user?.photoURL;

  String? get nickname =>
      _userProvider.user?.displayName ??
      _userProvider.user?.email?.split('@').first;

  DateTime get selectedDate => _selectedDate;

  DateTime get now => _now;

  List<DateTime>? get dateItems => _dateItems;

  bool get isFirstRender => _isFirstRender;

  List<Journal> get journal => _journal;

  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
    _load();
  }

  Future<void> setIsFirstRender(bool value) async {
    _isFirstRender = value;
    notifyListeners();
  }

  Future<void> deleteJournal(int id) async {
    setLoading();
    await _deleteJournalUseCase.deleteJournal(id);
    setSuccess();
  }

  void _calculateDateItems() {
    final currentDate = DateTime.now();
    final lastDateOfMonth = currentDate.lastDateOfMonth;

    List<DateTime> dates = List.generate(
      lastDateOfMonth,
      (index) => DateTime(currentDate.year, currentDate.month, index + 1),
    );

    _dateItems = dates;
  }

  Future<void> _load() async {
    setLoading();
    final result = await _journalRepository.getJournalsByDate(_selectedDate);
    switch (result) {
      case Ok<List<Journal>>():
        _log.fine('Loaded journals');
        _journal = result.value;
        setSuccess();
      case Failure<List<Journal>>():
        _log.warning('Failed to load journals', result.error);
        _journal = [];
        setError(result.error);
    }
  }

  Future<void> _initializeDelayedRender() async {
    await Future.delayed(DelayMs.medium * 4);
    setIsFirstRender(false);
  }

  void _subscribeToJournalChanges() {
    _journalSubscription = _journalRepository.journalStream.listen((journals) {
      // 전체 일기 목록이 변경되었을 때, 현재 선택된 날짜의 일기만 필터링
      _filterJournalsForSelectedDate(journals);
    });
  }

  void _filterJournalsForSelectedDate(List<Journal> allJournals) {
    final startOfDay = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
    );
    final endOfDay = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      23,
      59,
      59,
      999,
    );

    _journal = allJournals.where((journal) {
      return journal.createdAt.isAfter(startOfDay) &&
          journal.createdAt.isBefore(endOfDay);
    }).toList();

    notifyListeners();
  }

  @override
  void dispose() {
    _journalSubscription?.cancel();
    super.dispose();
  }
}
