import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';

import '../../../../domain/use_cases/weather_use_case.dart';
import '../../../../presentation/providers/user_provider.dart';
import '../../core/mixins/async_state_mixin.dart';
import '../../core/ui/widgets/banner_ad_widget.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/journal/location_info.dart';
import '../../domain/entities/journal/weather_info.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/use_cases/get_current_location_use_case.dart';

class BaseLayoutViewModel extends ChangeNotifier with AsyncStateMixin {
  final UserProvider _userProvider;
  final GetCurrentLocationUseCase _getCurrentLocationUseCase;
  final WeatherUseCase _weatherUseCase;
  final SettingsRepository _settingsRepository;
  final BannerAdWidget bannerAdWidget = BannerAdWidget();

  BaseLayoutViewModel({
    required UserProvider userProvider,
    required GetCurrentLocationUseCase getCurrentLocationUseCase,
    required WeatherUseCase weatherUseCase,
    required SettingsRepository settingsRepository,
  })  : _userProvider = userProvider,
        _getCurrentLocationUseCase = getCurrentLocationUseCase,
        _weatherUseCase = weatherUseCase,
        _settingsRepository = settingsRepository {
    _load();
    loadAppInfo();
  }

  final Logger _log = Logger('BaseLayoutViewModel');
  LocationInfo? _locationInfo;
  WeatherInfo? _weatherInfo;
  String _appVersion = '';
  String _appBuild = '';

  String? get profileImage => _userProvider.user?.profileImagePath;

  String? get nickname => _userProvider.user?.nickname;

  WeatherInfo? get weatherInfo => _weatherInfo;

  String get appVersion => _appVersion;

  String get appBuild => _appBuild;

  Future<void> _load() async {
    setLoading();
    await getCurrentLocation();
    await getCurrentWeather();
    setSuccess();
  }

  Future<void> loadAppInfo() async {
    final result = await executeAsync(() async {
      final appInfo = await _settingsRepository.getAppInfo();
      return appInfo;
    }, context: 'loadAppInfo');

    if (result != null) {
      _appVersion = result.version;
      _appBuild = result.buildNumber;
    }
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
}
