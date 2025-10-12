import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../core/constants/common.dart';
import '../../core/extensions/date_time.dart';
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

class HomeViewModel extends ChangeNotifier with AsyncStateMixin {
  final UserProvider _userProvider;
  final JournalUseCase _journalUseCase;
  final ObserveJournalListUseCase _observeJournalListUseCase;
  final GetCurrentLocationUseCase _getCurrentLocationUseCase;
  final WeatherUseCase _weatherUseCase;

  HomeViewModel({
    required UserProvider userProvider,
    required JournalUseCase journalUseCase,
    required ObserveJournalListUseCase observeJournalListUseCase,
    required GetCurrentLocationUseCase getCurrentLocationUseCase,
    required WeatherUseCase weatherUseCase,
  })  : _userProvider = userProvider,
        _journalUseCase = journalUseCase,
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
  bool _isSelectionMode = false;
  final Set<int> _selectedJournalIds = {};

  bool get isSelectionMode => _isSelectionMode;
  Set<int> get selectedJournalIds => Set.from(_selectedJournalIds);

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
    final selectedDateOnly = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
    );
    final todayOnly = DateTime(today.year, today.month, today.day);
    return selectedDateOnly.isAfter(todayOnly);
  }

  Map<DateTime, List<Journal>> get monthlyJournals => _monthlyJournals;

  Map<DateTime, List<Journal>> get yearlyJournals => _yearlyJournals;

  void _load() async {
    setLoading();
    _calculateDateItems();
    _subscribeToJournalChanges(); // 스트림 구독을 먼저 설정
    await _loadMonthlyJournals();
    await _loadYearlyJournals();
    await getCurrentLocation();
    await getCurrentWeather();
    _initializeDelayedRender();
    setSuccess();
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    // 스트림에서 받은 전체 데이터로 필터링만 다시 수행
    _journalUseCase.notifyJournalUpdate();
    notifyListeners();
  }

  void selectMonth(DateTime month) {
    _displayMonth = DateTime(month.year, month.month, 1);
    _calculateDateItemsForMonth(_displayMonth);

    // 해당 월의 1일을 선택
    _selectedDate = DateTime(month.year, month.month, 1);
    _journalUseCase.notifyJournalUpdate();

    notifyListeners();
  }

  Future<void> setIsFirstRender(bool value) async {
    _isFirstRender = value;
    notifyListeners();
  }

  Future<void> deleteJournal(int id) async {
    setLoading();
    await _journalUseCase.deleteJournal(id);
    setSuccess();
  }

  void _calculateDateItems() {
    _calculateDateItemsForMonth(_displayMonth);
  }

  void _calculateDateItemsForMonth(DateTime month) {
    final lastDateOfMonth = month.lastDateOfMonth;

    List<DateTime> dates = List.generate(
      lastDateOfMonth,
      (index) => DateTime(month.year, month.month, index + 1),
    );

    _dateItems = dates;
  }

  Future<void> _initializeDelayedRender() async {
    await Future.delayed(DelayMS.medium * 4);
    setIsFirstRender(false);
  }

  void _subscribeToJournalChanges() {
    _journalSubscription =
        _observeJournalListUseCase.call().listen((allJournals) {
      // 전체 일기 목록이 변경되었을 때, 현재 선택된 날짜의 일기만 필터링
      _filterJournalsForSelectedDate(allJournals);
    });

    // 구독 직후 데이터 로드를 트리거하여 초기 데이터를 가져옴
    _journalUseCase.notifyJournalUpdate();
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

  Future<void> _loadMonthlyJournals() async {
    final now = DateTime.now();

    final result = await _journalUseCase.getJournalsByMonth(now);

    switch (result) {
      case Ok<List<Journal>>():
        _log.fine('Loaded monthly journals: ${result.value.length}');
        _monthlyJournals.clear();

        // 날짜별로 일기들을 그룹화
        for (final journal in result.value) {
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
      case Error<List<Journal>>():
        _log.warning('Failed to load monthly journals', result.error);
        _monthlyJournals.clear();
        notifyListeners();
    }
  }

  Future<void> _loadYearlyJournals() async {
    final now = DateTime.now();

    // 올해 전체 데이터를 로드하기 위해 각 월별로 호출
    _yearlyJournals.clear();

    for (int month = 1; month <= 12; month++) {
      final monthDate = DateTime(now.year, month, 1);
      final result = await _journalUseCase.getJournalsByMonth(monthDate);

      switch (result) {
        case Ok<List<Journal>>():
          // 날짜별로 일기들을 그룹화하여 연간 맵에 추가
          for (final journal in result.value) {
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
        case Error<List<Journal>>():
          _log.warning(
            'Failed to load journals for month $month',
            result.error,
          );
      }
    }

    _log.fine('Loaded yearly journals: ${_yearlyJournals.length} days');
    notifyListeners();
  }

  Future<void> getCurrentWeather() async {
    double latitude = 37.5665; // 서울 기본 위치
    double longitude = 126.9780;

    if (_locationInfo == null) {
      await getCurrentLocation();
    }

    // 위치 정보가 있으면 사용, 없으면 서울 기본 위치 사용
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
      case Ok<WeatherInfo>():
        _log.fine('Weather retrieved successfully');
        _weatherInfo = result.value;
      case Error<WeatherInfo>():
        _log.warning('Failed to get weather: ${result.error}');
    }
  }

  Future<void> getCurrentLocation() async {
    final result = await _getCurrentLocationUseCase();

    switch (result) {
      case Ok<LocationInfo>():
        _log.fine('Location retrieved successfully');
        _locationInfo = result.value;
      case Error<LocationInfo>():
        _log.warning('Failed to get location: ${result.error}');
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

  void toggleSelectionMode() {
    _isSelectionMode = !_isSelectionMode;
    if (!_isSelectionMode) {
      _selectedJournalIds.clear();
    }
    notifyListeners();
  }

  void toggleJournalSelection(int id) {
    if (_selectedJournalIds.contains(id)) {
      _selectedJournalIds.remove(id);
    } else {
      _selectedJournalIds.add(id);
    }
    notifyListeners();
  }

  void clearSelection() {
    _isSelectionMode = false;
    _selectedJournalIds.clear();
    notifyListeners();
  }

  Future<void> deleteSelectedJournals() async {
    setLoading();
    for (final id in _selectedJournalIds) {
      await _journalUseCase.deleteJournal(id);
    }
    _selectedJournalIds.clear();
    _isSelectionMode = false;
    setSuccess();
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
