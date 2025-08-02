import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../core/constants/common.dart';
import '../../../core/extensions/date_time.dart';
import '../../../core/mixins/async_state_mixin.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/utils/result.dart';
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
  LocationInfo? _locationInfo;
  bool _isLoadingLocation = false;
  WeatherInfo? _weatherInfo;
  bool _isLoadingWeather = false;

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

  @override
  void dispose() {
    _journalSubscription?.cancel();
    super.dispose();
  }
}
