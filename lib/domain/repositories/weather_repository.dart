import '../../core/utils/result.dart';
import '../entities/weather_info.dart';

abstract class WeatherRepository {
  /// 현재 날씨 정보를 가져옵니다.
  Future<Result<WeatherInfo>> getCurrentWeather({
    required double latitude,
    required double longitude,
  });

  /// 날씨 아이콘 코드를 WeatherCondition으로 변환합니다.
  WeatherCondition getWeatherCondition(String iconCode);

  /// 날씨 아이콘 URL을 생성합니다.
  String getWeatherIconUrl(String iconCode);
}