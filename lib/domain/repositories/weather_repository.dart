import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/journal/weather_info.dart';

abstract class WeatherRepository {
  Future<Result<WeatherInfo>> getCurrentWeather({
    required double latitude,
    required double longitude,
  });

  WeatherCondition getWeatherCondition(String iconCode);

  String getWeatherIconUrl(String iconCode);
}
