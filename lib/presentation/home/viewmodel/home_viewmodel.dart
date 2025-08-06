import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../common/constants/common.dart';
import '../../../common/constants/enum.dart';
import '../../../common/extensions/date_time.dart';
import '../../../common/mixins/async_state_mixin.dart';
import '../../../common/providers/user_provider.dart';
import '../../../common/utils/result.dart';
import '../../../domain/entities/journal.dart';
import '../../../domain/entities/location_info.dart';
import '../../../domain/entities/weather_info.dart';
import '../../../domain/repositories/journal_repository.dart';
import '../../../domain/use_cases/journal/delete_journal_use_case.dart';
import '../../../domain/use_cases/location/get_current_location_use_case.dart';
import '../../../domain/use_cases/weather/get_current_weather_use_case.dart';

class HomeViewModel extends ChangeNotifier with AsyncStateMixin {
  final JournalRepository _journalRepository;
  final UserProvider _userProvider;
  final DeleteJournalUseCase _deleteJournalUseCase;
  final GetCurrentLocationUseCase _getCurrentLocationUseCase;
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;

  HomeViewModel({
    required JournalRepository journalRepository,
    required UserProvider userProvider,
    required DeleteJournalUseCase deleteJournalUseCase,
    required GetCurrentLocationUseCase getCurrentLocationUseCase,
    required GetCurrentWeatherUseCase getCurrentWeatherUseCase,
  }) : _journalRepository = journalRepository,
       _userProvider = userProvider,
       _deleteJournalUseCase = deleteJournalUseCase,
       _getCurrentLocationUseCase = getCurrentLocationUseCase,
       _getCurrentWeatherUseCase = getCurrentWeatherUseCase {
    _calculateDateItems();
    _load();
    _loadMonthlyJournals();
    _loadYearlyJournals();
    _loadRecentJournalsAndRepresentativeMood();
    _initializeDelayedRender();
    _subscribeToJournalChanges();
    _loadCurrentLocationAndWeather();
  }

  final Logger _log = Logger('HomeViewModel');
  StreamSubscription? _journalSubscription;
  final DateTime _now = DateTime.now();
  List<Journal> _journal = [];
  DateTime _selectedDate = DateTime.now();
  List<DateTime>? _dateItems;
  bool _isFirstRender = true;
  final Map<DateTime, List<Journal>> _monthlyJournals = {};
  final Map<DateTime, List<Journal>> _yearlyJournals = {};
  LocationInfo? _locationInfo;
  bool _isLoadingLocation = false;
  WeatherInfo? _weatherInfo;
  bool _isLoadingWeather = false;
  MoodType? _representativeMood;
  List<Journal> _recentJournals = [];

  String? get profileImage => _userProvider.user?.photoURL;

  String? get nickname =>
      _userProvider.user?.displayName ??
      _userProvider.user?.email?.split('@').first;

  DateTime get selectedDate => _selectedDate;

  DateTime get now => _now;

  List<DateTime>? get dateItems => _dateItems;

  bool get isFirstRender => _isFirstRender;

  List<Journal> get journal => _journal;

  LocationInfo? get locationInfo => _locationInfo;

  bool get isLoadingLocation => _isLoadingLocation;

  WeatherInfo? get weatherInfo => _weatherInfo;

  bool get isLoadingWeather => _isLoadingWeather;

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

  MoodType? get representativeMood => _representativeMood;

  List<Journal> get recentJournals => _recentJournals;

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

  Future<void> getCurrentWeather() async {
    double latitude = 37.5665; // 서울 기본 위치
    double longitude = 126.9780;

    if (_locationInfo == null) {
      await _getCurrentLocation();
    }

    // 위치 정보가 있으면 사용, 없으면 서울 기본 위치 사용
    if (_locationInfo != null) {
      latitude = _locationInfo!.latitude;
      longitude = _locationInfo!.longitude;
      _log.info('Using actual location: $latitude, $longitude');
    } else {
      _log.info('Using default location (Seoul): $latitude, $longitude');
    }

    _isLoadingWeather = true;
    notifyListeners();

    final result = await _getCurrentWeatherUseCase.execute(
      latitude: latitude,
      longitude: longitude,
    );

    switch (result) {
      case Ok<WeatherInfo>():
        _log.fine('Weather retrieved successfully');
        _weatherInfo = result.value;
      case Failure<WeatherInfo>():
        _log.warning('Failed to get weather: ${result.error}');
    }

    _isLoadingWeather = false;
    notifyListeners();
  }

  Future<void> _getCurrentLocation() async {
    _isLoadingLocation = true;
    notifyListeners();

    final result = await _getCurrentLocationUseCase.execute();

    switch (result) {
      case Ok<LocationInfo>():
        _log.fine('Location retrieved successfully');
        _locationInfo = result.value;
      case Failure<LocationInfo>():
        _log.warning('Failed to get location: ${result.error}');
    }

    _isLoadingLocation = false;
    notifyListeners();
  }

  Future<void> _loadCurrentLocationAndWeather() async {
    await _getCurrentLocation();
    // 위치 정보가 있든 없든 날씨 정보를 로드 (기본 위치 사용)
    await getCurrentWeather();
  }

  void clearWeather() {
    _weatherInfo = null;
    notifyListeners();
    getCurrentWeather();
  }

  Future<void> _loadMonthlyJournals() async {
    final now = DateTime.now();

    final result = await _journalRepository.getJournalsByMonth(now);

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
      case Failure<List<Journal>>():
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
      final result = await _journalRepository.getJournalsByMonth(monthDate);

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
        case Failure<List<Journal>>():
          _log.warning(
            'Failed to load journals for month $month',
            result.error,
          );
      }
    }

    _log.fine('Loaded yearly journals: ${_yearlyJournals.length} days');
    notifyListeners();
  }

  Future<void> _loadRecentJournalsAndRepresentativeMood() async {
    final result = await _journalRepository.getAllJournals();
    
    switch (result) {
      case Ok<List<Journal>>():
        final allJournals = result.value;
        
        // 최근 30일 일기만 가져오기
        final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
        _recentJournals = allJournals
            .where((journal) => journal.createdAt.isAfter(thirtyDaysAgo))
            .toList()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
        
        // 대표 감정 계산
        _calculateRepresentativeMood();
        notifyListeners();
        
      case Failure<List<Journal>>():
        _log.warning('Failed to load recent journals for representative mood', result.error);
        _recentJournals = [];
        _representativeMood = null;
        notifyListeners();
    }
  }

  void _calculateRepresentativeMood() {
    if (_recentJournals.isEmpty) {
      _representativeMood = null;
      return;
    }

    // 최근 7일 일기에 더 높은 가중치 적용
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));
    final fourteenDaysAgo = now.subtract(const Duration(days: 14));

    double totalScore = 0;
    int totalWeight = 0;

    for (final journal in _recentJournals) {
      final daysDiff = now.difference(journal.createdAt).inDays;
      int weight = 1;
      
      // 가중치 적용 (최근일수록 높은 가중치)
      if (journal.createdAt.isAfter(sevenDaysAgo)) {
        weight = 3; // 최근 7일: 가중치 3
      } else if (journal.createdAt.isAfter(fourteenDaysAgo)) {
        weight = 2; // 7-14일: 가중치 2  
      }
      // 14-30일: 가중치 1 (기본값)

      totalScore += journal.moodType.score * weight;
      totalWeight += weight;
    }

    if (totalWeight == 0) {
      _representativeMood = null;
      return;
    }

    final averageScore = totalScore / totalWeight;
    
    // 평균 점수를 기반으로 대표 감정 결정
    if (averageScore >= 4.5) {
      _representativeMood = MoodType.veryHappy;
    } else if (averageScore >= 3.5) {
      _representativeMood = MoodType.happy;
    } else if (averageScore >= 2.5) {
      _representativeMood = MoodType.neutral;
    } else if (averageScore >= 1.5) {
      _representativeMood = MoodType.sad;
    } else {
      _representativeMood = MoodType.verySad;
    }
  }

  @override
  void dispose() {
    _journalSubscription?.cancel();
    super.dispose();
  }
}
