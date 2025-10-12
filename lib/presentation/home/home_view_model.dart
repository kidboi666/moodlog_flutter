import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/core/extensions/date_time.dart';

import '../../core/constants/common.dart';
import '../../core/mixins/async_state_mixin.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/journal/journal.dart';
import '../../domain/entities/journal/location_info.dart';
import '../../domain/entities/journal/weather_info.dart';
import '../../domain/use_cases/get_current_location_use_case.dart';
import '../../domain/use_cases/journal_use_case.dart';
import '../../domain/use_cases/observe_journal_list_use_case.dart';
import '../../domain/use_cases/weather_use_case.dart';
import '../providers/user_provider.dart';
import '../viewmodels/journal_selection_mixin.dart';

class HomeViewModel extends ChangeNotifier
    with AsyncStateMixin, JournalSelectionMixin {
  final UserProvider _userProvider;
  @override
  final JournalUseCase journalUseCase;
  final ObserveJournalListUseCase _observeJournalListUseCase;
  final GetCurrentLocationUseCase _getCurrentLocationUseCase;
  final WeatherUseCase _weatherUseCase;

  HomeViewModel({
    required UserProvider userProvider,
    required this.journalUseCase,
    required ObserveJournalListUseCase observeJournalListUseCase,
    required GetCurrentLocationUseCase getCurrentLocationUseCase,
    required WeatherUseCase weatherUseCase,
  }) : _userProvider = userProvider,
       _observeJournalListUseCase = observeJournalListUseCase,
       _getCurrentLocationUseCase = getCurrentLocationUseCase,
       _weatherUseCase = weatherUseCase {
    _load();
    _userProvider.addListener(_onUserChanged);
  }

  final Logger _log = Logger('HomeViewModel');
  StreamSubscription? _journalSubscription;
  List<Journal> _journal = [];
  DateTime _selectedDate = DateTime.now();
  DateTime _displayMonth = DateTime.now();
  List<DateTime>? _dateItems;
  bool _isFirstRender = true;
  final Map<DateTime, List<Journal>> _monthlyJournals = {};
  final Map<DateTime, List<Journal>> _yearlyJournals = {};
  LocationInfo? _locationInfo;
  WeatherInfo? _weatherInfo;

  String? get profileImage => _userProvider.user?.profileImagePath;
  String? get nickname => _userProvider.user?.nickname;
  DateTime get selectedDate => _selectedDate;
  DateTime get displayMonth => _displayMonth;
  List<DateTime>? get dateItems => _dateItems;
  bool get isFirstRender => _isFirstRender;
  List<Journal> get journal => _journal;
  LocationInfo? get locationInfo => _locationInfo;
  WeatherInfo? get weatherInfo => _weatherInfo;

  bool get isSelectedDateInFuture {
    final today = DateTime.now();
    return _selectedDate.isAfter(today);
  }

  Map<DateTime, List<Journal>> get monthlyJournals => _monthlyJournals;
  Map<DateTime, List<Journal>> get yearlyJournals => _yearlyJournals;

  void _load() async {
    setLoading();
    _calculateDateItems();
    _subscribeToJournalChanges();
    await _loadMonthlyJournals();
    await _loadYearlyJournals();
    await getCurrentLocation();
    await getCurrentWeather();
    _initializeDelayedRender();
    setSuccess();
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    journalUseCase.notifyJournalUpdate();
    notifyListeners();
  }

  void selectMonth(DateTime month) {
    _displayMonth = DateTime(month.year, month.month, 1);
    _calculateDateItemsForMonth(_displayMonth);
    _selectedDate = DateTime(month.year, month.month, 1);
    journalUseCase.notifyJournalUpdate();
    notifyListeners();
  }

  Future<void> setIsFirstRender(bool value) async {
    _isFirstRender = value;
    notifyListeners();
  }

  Future<void> deleteJournal(int id) async {
    setLoading();
    await journalUseCase.deleteJournalById(id);
    setSuccess();
  }

  void _calculateDateItems() {
    _calculateDateItemsForMonth(_displayMonth);
  }

  void _calculateDateItemsForMonth(DateTime month) {
    final lastDateOfMonth = month.lastDateOfMonth;
    _dateItems = List.generate(
      lastDateOfMonth,
      (index) => DateTime(month.year, month.month, index + 1),
    );
  }

  Future<void> _initializeDelayedRender() async {
    await Future.delayed(DelayMS.medium * 4);
    setIsFirstRender(false);
  }

  void _subscribeToJournalChanges() {
    _journalSubscription = _observeJournalListUseCase.call().listen((
      allJournals,
    ) {
      _filterJournalsForSelectedDate(allJournals);
    });
    journalUseCase.notifyJournalUpdate();
  }

  void _filterJournalsForSelectedDate(List<Journal> allJournals) {
    _journal = allJournals.where((journal) {
      return journal.createdAt.isSameDay(_selectedDate);
    }).toList();
    notifyListeners();
  }

  Future<void> _loadMonthlyJournals() async {
    final now = DateTime.now();
    final result = await journalUseCase.getJournalsByMonth(now);
    switch (result) {
      case Ok(value: final journals):
        _log.fine('Loaded monthly journals: ${journals.length}');
        _monthlyJournals.clear();
        for (final journal in journals) {
          final dateKey = DateTime(
            journal.createdAt.year,
            journal.createdAt.month,
            journal.createdAt.day,
          );
          if (_monthlyJournals.containsKey(dateKey)) {
            _monthlyJournals[dateKey]!.add(journal);
          } else {
            _monthlyJournals[dateKey] = [journal];
          }
        }
        notifyListeners();
      case Error(error: final e):
        _log.warning('Failed to load monthly journals', e);
        _monthlyJournals.clear();
        notifyListeners();
    }
  }

  Future<void> _loadYearlyJournals() async {
    final now = DateTime.now();
    _yearlyJournals.clear();
    for (int month = 1; month <= 12; month++) {
      final monthDate = DateTime(now.year, month, 1);
      final result = await journalUseCase.getJournalsByMonth(monthDate);
      switch (result) {
        case Ok(value: final journals):
          for (final journal in journals) {
            final dateKey = DateTime(
              journal.createdAt.year,
              journal.createdAt.month,
              journal.createdAt.day,
            );
            if (_yearlyJournals.containsKey(dateKey)) {
              _yearlyJournals[dateKey]!.add(journal);
            } else {
              _yearlyJournals[dateKey] = [journal];
            }
          }
        case Error(error: final e):
          _log.warning('Failed to load journals for month $month', e);
      }
    }
    _log.fine('Loaded yearly journals: ${_yearlyJournals.length} days');
    notifyListeners();
  }

  Future<void> getCurrentWeather() async {
    double latitude = 37.5665;
    double longitude = 126.9780;
    if (_locationInfo == null) {
      await getCurrentLocation();
    }
    if (_locationInfo != null) {
      latitude = _locationInfo!.latitude;
      longitude = _locationInfo!.longitude;
      _log.info('Using actual location: $latitude, $longitude');
    } else {
      _log.info('Using default location (Seoul): $latitude, $longitude');
    }
    final result = await _weatherUseCase.getCurrentWeather(
      latitude: latitude,
      longitude: longitude,
    );
    switch (result) {
      case Ok(value: final weatherInfo):
        _log.fine('Weather retrieved successfully');
        _weatherInfo = weatherInfo;
      case Error(error: final e):
        _log.warning('Failed to get weather: $e');
    }
  }

  Future<void> getCurrentLocation() async {
    final result = await _getCurrentLocationUseCase();
    switch (result) {
      case Ok(value: final locationInfo):
        _log.fine('Location retrieved successfully');
        _locationInfo = locationInfo;
      case Error(error: final e):
        _log.warning('Failed to get location: $e');
    }
  }

  WeatherCondition getWeatherCondition(String? iconCode) {
    if (iconCode == null) {
      return WeatherCondition.unknown;
    }
    return _weatherUseCase.getWeatherCondition(iconCode);
  }

  void clearWeather() {
    _load();
  }

  void _onUserChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    _userProvider.removeListener(_onUserChanged);
    _journalSubscription?.cancel();
    super.dispose();
  }
}
