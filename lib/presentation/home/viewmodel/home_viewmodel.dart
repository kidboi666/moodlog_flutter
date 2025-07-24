import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

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

  HomeViewModel({
    required JournalRepository journalRepository,
    required UserProvider userProvider,
  }) : _journalRepository = journalRepository,
       _userProvider = userProvider {
    _calculateDateItems();
    _load();
    Future.delayed(DelayMs.medium * 4, () {
      setIsFirstRender(false);
    });
  }

  final Logger _log = Logger('HomeViewModel');
  StreamSubscription? _journalSubscription;
  final DateTime _now = DateTime.now();
  List<Journal> _journal = [];
  DateTime _selectedDate = DateTime.now();
  List<DateTime>? _dateItems;
  bool _isFirstRender = true;

  String? get profileImage => _userProvider.user?.photoURL;

  String? get nickname => _userProvider.user?.displayName;

  DateTime get selectedDate => _selectedDate;

  DateTime get now => _now;

  List<DateTime>? get dateItems => _dateItems;

  bool get isFirstRender => _isFirstRender;

  List<Journal> get journal => _journal;

  void selectDate(DateTime date) {
    _selectedDate = date;
    _log.info('isFirstRender $isFirstRender');
    notifyListeners();
    _load();
  }

  Future<void> setIsFirstRender(bool value) async {
    _isFirstRender = value;
    notifyListeners();
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
      case Error<List<Journal>>():
        _log.warning('Failed to load journals', result.error);
        _journal = [];
        setError(result.error);
    }
  }
}
