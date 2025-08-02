import '../../../common/utils/result.dart';
import '../../entities/weather_info.dart';
import '../../repositories/weather_repository.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository _weatherRepository;

  GetCurrentWeatherUseCase({required WeatherRepository weatherRepository})
    : _weatherRepository = weatherRepository;

  Future<Result<WeatherInfo>> execute({
    required double latitude,
    required double longitude,
  }) async {
    return await _weatherRepository.getCurrentWeather(
      latitude: latitude,
      longitude: longitude,
    );
  }
}
