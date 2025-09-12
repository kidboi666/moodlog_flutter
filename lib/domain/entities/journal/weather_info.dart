import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_info.freezed.dart';

@freezed
abstract class WeatherInfo with _$WeatherInfo {
  const factory WeatherInfo({
    required double temperature,
    required String description,
    required String icon,
    required double humidity,
    required double pressure,
    required double windSpeed,
    required String location,
    required DateTime timestamp,
  }) = _WeatherInfo;
}

enum WeatherCondition {
  clear,
  cloudy,
  rainy,
  snowy,
  thunderstorm,
  fog,
  unknown;

  String get displayName {
    switch (this) {
      case WeatherCondition.clear:
        return '맑음';
      case WeatherCondition.cloudy:
        return '흐림';
      case WeatherCondition.rainy:
        return '비';
      case WeatherCondition.snowy:
        return '눈';
      case WeatherCondition.thunderstorm:
        return '뇌우';
      case WeatherCondition.fog:
        return '안개';
      case WeatherCondition.unknown:
        return '알 수 없음';
    }
  }

  String get icon {
    switch (this) {
      case WeatherCondition.clear:
        return '☀️';
      case WeatherCondition.cloudy:
        return '☁️';
      case WeatherCondition.rainy:
        return '🌧️';
      case WeatherCondition.snowy:
        return '❄️';
      case WeatherCondition.thunderstorm:
        return '⛈️';
      case WeatherCondition.fog:
        return '🌫️';
      case WeatherCondition.unknown:
        return '❓';
    }
  }
}
