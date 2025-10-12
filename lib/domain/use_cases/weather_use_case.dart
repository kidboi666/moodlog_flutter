import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/journal/weather_info.dart';
import 'package:moodlog/domain/repositories/weather_repository.dart';

class WeatherUseCase {
  final WeatherRepository _repository;

  WeatherUseCase({required WeatherRepository repository})
    : _repository = repository;

  Future<Result<WeatherInfo>> getCurrentWeather({
    required double latitude,
    required double longitude,
  }) {
    return _repository.getCurrentWeather(
      latitude: latitude,
      longitude: longitude,
    );
  }

  WeatherCondition getWeatherCondition(String iconCode) {
    return _repository.getWeatherCondition(iconCode);
  }

  String getWeatherIconUrl(String iconCode) {
    return _repository.getWeatherIconUrl(iconCode);
  }
}
