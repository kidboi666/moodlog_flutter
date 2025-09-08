import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';

import '../../../../domain/entities/location_info.dart';
import '../../../../domain/entities/weather_info.dart';
import '../../../../domain/use_cases/location_use_case.dart';
import '../../../../domain/use_cases/weather_use_case.dart';
import '../../../../presentation/providers/user_provider.dart';
import '../../core/utils/result.dart';

class BaseLayoutViewModel extends ChangeNotifier {
  final UserProvider _userProvider;
  final LocationUseCase _locationUseCase;
  final WeatherUseCase _weatherUseCase;

  BaseLayoutViewModel({
    required UserProvider userProvider,
    required LocationUseCase locationUseCase,
    required WeatherUseCase weatherUseCase,
  }) : _userProvider = userProvider,
       _locationUseCase = locationUseCase,
       _weatherUseCase = weatherUseCase {
    _load();
  }

  final Logger _log = Logger('BaseLayoutViewModel');
  LocationInfo? _locationInfo;
  WeatherInfo? _weatherInfo;
  bool _isLoadingLocation = false;
  bool _isLoadingWeather = false;

  String? get profileImage => _userProvider.user?.photoURL;
  String? get nickname =>
      _userProvider.user?.displayName ??
      _userProvider.user?.email?.split('@').first;
  WeatherInfo? get weatherInfo => _weatherInfo;
  bool get isLoadingLocation => _isLoadingLocation;
  bool get isLoadingWeather => _isLoadingWeather;

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

    final result = await _weatherUseCase.getCurrentWeather(
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

    final result = await _locationUseCase.getCurrentLocation();

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

  Future<void> _load() async {
    await _getCurrentLocation();
    // 위치 정보가 있든 없든 날씨 정보를 로드 (기본 위치 사용)
    await getCurrentWeather();
  }

  WeatherCondition getWeatherCondition(String iconCode) {
    return _weatherUseCase.getWeatherCondition(iconCode);
  }

  void clearWeather() {
    _weatherInfo = null;
    notifyListeners();
    getCurrentWeather();
  }
}
