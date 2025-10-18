import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';

import 'package:moodlog/core/extensions/date_time.dart';
import 'package:moodlog/core/mixins/async_state_mixin.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/journal/check_in.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';
import 'package:moodlog/domain/entities/journal/location_info.dart';
import 'package:moodlog/domain/entities/journal/weather_info.dart';
import 'package:moodlog/domain/entities/timeline_entry.dart';
import 'package:moodlog/domain/use_cases/check_in_use_case.dart';
import 'package:moodlog/domain/use_cases/get_current_location_use_case.dart';
import 'package:moodlog/domain/use_cases/journal_use_case.dart';
import 'package:moodlog/domain/use_cases/observe_journal_list_use_case.dart';
import 'package:moodlog/domain/use_cases/weather_use_case.dart';
import 'package:moodlog/presentation/mixins/journal_selection_mixin.dart';
import 'package:moodlog/presentation/providers/user_provider.dart';

class HomeViewModel extends ChangeNotifier
    with AsyncStateMixin, JournalSelectionMixin {
  final UserProvider _userProvider;
  @override
  final JournalUseCase journalUseCase;
  final CheckInUseCase _checkInUseCase;
  final ObserveJournalListUseCase _observeJournalListUseCase;
  final GetCurrentLocationUseCase _getCurrentLocationUseCase;
  final WeatherUseCase _weatherUseCase;

  HomeViewModel({
    required UserProvider userProvider,
    required this.journalUseCase,
    required CheckInUseCase checkInUseCase,
    required ObserveJournalListUseCase observeJournalListUseCase,
    required GetCurrentLocationUseCase getCurrentLocationUseCase,
    required WeatherUseCase weatherUseCase,
  }) : _userProvider = userProvider,
       _checkInUseCase = checkInUseCase,
       _observeJournalListUseCase = observeJournalListUseCase,
       _getCurrentLocationUseCase = getCurrentLocationUseCase,
       _weatherUseCase = weatherUseCase {
    _load();
    _userProvider.addListener(_onUserChanged);
  }

  StreamSubscription? _journalSubscription;
  StreamSubscription? _checkInSubscription;
  List<Journal> _journal = [];
  List<CheckIn> _checkIns = [];
  List<TimelineEntry> _timelineEntries = [];
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

  List<TimelineEntry> get timelineEntries => _timelineEntries;

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
    _subscribeToCheckInChanges();
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
    _checkInUseCase.notifyCheckInUpdate();
    notifyListeners();
  }

  void selectMonth(DateTime month) {
    _displayMonth = DateTime(month.year, month.month, 1);
    _calculateDateItemsForMonth(_displayMonth);
    _selectedDate = DateTime(month.year, month.month, 1);
    journalUseCase.notifyJournalUpdate();
    _checkInUseCase.notifyCheckInUpdate();
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

  void _subscribeToCheckInChanges() {
    _checkInSubscription = _checkInUseCase.watchAllCheckIns().listen((
      allCheckIns,
    ) {
      _filterCheckInsForSelectedDate(allCheckIns);
    });
    _checkInUseCase.notifyCheckInUpdate();
  }

  void _filterJournalsForSelectedDate(List<Journal> allJournals) {
    _journal = allJournals.where((journal) {
      return journal.createdAt.isSameDay(_selectedDate);
    }).toList();
    _combineTimeline();
  }

  void _filterCheckInsForSelectedDate(List<CheckIn> allCheckIns) {
    debugPrint('All CheckIns: ${allCheckIns.length}');
    _checkIns = allCheckIns.where((checkIn) {
      return checkIn.createdAt.isSameDay(_selectedDate);
    }).toList();
    debugPrint('Filtered CheckIns for $_selectedDate: ${_checkIns.length}');
    _combineTimeline();
  }

  void _combineTimeline() {
    final entries = <TimelineEntry>[
      ..._checkIns.map((checkIn) => TimelineEntry.fromCheckIn(checkIn)),
      ..._journal.map((journal) => TimelineEntry.fromJournal(journal)),
    ];

    entries.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    _timelineEntries = entries;
    debugPrint('Combined timeline: ${_timelineEntries.length} entries (CheckIns: ${_checkIns.length}, Journals: ${_journal.length})');
    notifyListeners();
  }

  Future<void> _loadMonthlyJournals() async {
    final now = DateTime.now();
    final result = await journalUseCase.getJournalsByMonth(now);
    switch (result) {
      case Ok(value: final journals):
        debugPrint('Loaded monthly journals: ${journals.length}');
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
        debugPrint('Failed to load monthly journals $e');
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
          debugPrint('Failed to load journals for month $month, $e');
      }
    }
    debugPrint('Loaded yearly journals: ${_yearlyJournals.length} days');
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
      debugPrint('Using actual location: $latitude, $longitude');
    } else {
      debugPrint('Using default location (Seoul): $latitude, $longitude');
    }
    final result = await _weatherUseCase.getCurrentWeather(
      latitude: latitude,
      longitude: longitude,
    );
    switch (result) {
      case Ok(value: final weatherInfo):
        debugPrint('Weather retrieved successfully');
        _weatherInfo = weatherInfo;
      case Error(error: final e):
        debugPrint('Failed to get weather: $e');
    }
  }

  Future<void> getCurrentLocation() async {
    final result = await _getCurrentLocationUseCase();
    switch (result) {
      case Ok(value: final locationInfo):
        debugPrint('Location retrieved successfully');
        _locationInfo = locationInfo;
      case Error(error: final e):
        debugPrint('Failed to get location: $e');
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

  Future<void> refresh() async {
    await _loadMonthlyJournals();
    await _loadYearlyJournals();
    await getCurrentLocation();
    await getCurrentWeather();
    journalUseCase.notifyJournalUpdate();
    _checkInUseCase.notifyCheckInUpdate();
  }

  void _onUserChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    _userProvider.removeListener(_onUserChanged);
    _journalSubscription?.cancel();
    _checkInSubscription?.cancel();
    super.dispose();
  }
}
