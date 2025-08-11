import '../../core/utils/result.dart';
import '../entities/weather_info.dart';
import '../repositories/weather_repository.dart';

class WeatherUseCase {
  final WeatherRepository _weatherRepository;

  WeatherUseCase({required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository;

  Future<Result<WeatherInfo>> getCurrentWeather({
    required double latitude,
    required double longitude,
  }) async {
    return await _weatherRepository.getCurrentWeather(
      latitude: latitude,
      longitude: longitude,
    );
  }
}