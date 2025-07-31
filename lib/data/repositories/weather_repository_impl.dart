import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

import '../../core/utils/result.dart';
import '../../domain/entities/weather_info.dart';
import '../../domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  static const String _baseUrl = 'https://weather.googleapis.com/v1';
  static const String _apiKey = 'AIzaSyCyU0_xtUCwWi4SDlCvjcILAHIexlAWVKE'; // Google API 키
  final Logger _log = Logger('WeatherRepositoryImpl');

  @override
  Future<Result<WeatherInfo>> getCurrentWeather({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final url = Uri.parse(
        '$_baseUrl/current?location=$latitude,$longitude&key=$_apiKey&languageCode=ko',
      );

      _log.info('Fetching weather data from: $url');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final weatherInfo = _parseGoogleWeatherData(data);
        _log.fine('Weather data fetched successfully');
        return Result.ok(weatherInfo);
      } else {
        final error = 'Google Weather API Error: ${response.statusCode}';
        _log.warning(error);
        return Result.failure(Exception(error));
      }
    } catch (e) {
      _log.severe('Failed to fetch weather data: $e');
      return Result.failure(Exception('날씨 정보를 가져올 수 없습니다: $e'));
    }
  }

  /// Google Weather API 응답을 WeatherInfo 객체로 변환합니다.
  WeatherInfo _parseGoogleWeatherData(Map<String, dynamic> data) {
    final values = data['values'];
    final location = data['location'] ?? {};
    
    return WeatherInfo(
      temperature: (values['temperature'] as num).toDouble(),
      description: _getWeatherDescription(values['weatherCode'] as int),
      icon: _getWeatherIcon(values['weatherCode'] as int),
      humidity: (values['humidity'] as num).toDouble(),
      pressure: (values['pressureSeaLevel'] as num?)?.toDouble() ?? 0.0,
      windSpeed: (values['windSpeed'] as num?)?.toDouble() ?? 0.0,
      location: location['name'] as String? ?? '현재 위치',
      timestamp: DateTime.now(),
    );
  }

  /// Google Weather API의 weatherCode를 한국어 설명으로 변환합니다.
  String _getWeatherDescription(int weatherCode) {
    switch (weatherCode) {
      case 1000:
        return '맑음';
      case 1100:
        return '대체로 맑음';
      case 1001:
        return '흐림';
      case 1101:
        return '구름 많음';
      case 1102:
        return '부분적으로 흐림';
      case 2000:
        return '안개';
      case 2100:
        return '가벼운 안개';
      case 4000:
        return '이슬비';
      case 4001:
        return '비';
      case 4200:
        return '가벼운 비';
      case 4201:
        return '강한 비';
      case 5000:
        return '눈';
      case 5001:
        return '가벼운 눈';
      case 5100:
        return '진눈깨비';
      case 5101:
        return '가벼운 진눈깨비';
      case 6000:
        return '우박';
      case 6001:
        return '가벼운 우박';
      case 6200:
        return '진눈깨비와 우박';
      case 6201:
        return '가벼운 진눈깨비와 우박';
      case 7000:
        return '얼음비';
      case 7101:
        return '가벼운 얼음비';
      case 7102:
        return '강한 얼음비';
      case 8000:
        return '뇌우';
      default:
        return '알 수 없음';
    }
  }

  /// Google Weather API의 weatherCode를 아이콘 코드로 변환합니다.
  String _getWeatherIcon(int weatherCode) {
    switch (weatherCode) {
      case 1000:
        return '01d'; // clear sky
      case 1100:
        return '02d'; // few clouds
      case 1001:
      case 1101:
      case 1102:
        return '03d'; // scattered clouds
      case 2000:
      case 2100:
        return '50d'; // mist
      case 4000:
      case 4001:
      case 4200:
      case 4201:
        return '10d'; // rain
      case 5000:
      case 5001:
      case 5100:
      case 5101:
        return '13d'; // snow
      case 6000:
      case 6001:
      case 6200:
      case 6201:
      case 7000:
      case 7101:
      case 7102:
        return '09d'; // shower rain
      case 8000:
        return '11d'; // thunderstorm
      default:
        return '01d'; // default clear
    }
  }

  @override
  WeatherCondition getWeatherCondition(String iconCode) {
    switch (iconCode.substring(0, 2)) {
      case '01': // clear sky
        return WeatherCondition.clear;
      case '02': // few clouds
      case '03': // scattered clouds
      case '04': // broken clouds
        return WeatherCondition.cloudy;
      case '09': // shower rain
      case '10': // rain
        return WeatherCondition.rainy;
      case '11': // thunderstorm
        return WeatherCondition.thunderstorm;
      case '13': // snow
        return WeatherCondition.snowy;
      case '50': // mist/fog
        return WeatherCondition.fog;
      default:
        return WeatherCondition.unknown;
    }
  }

  @override
  String getWeatherIconUrl(String iconCode) {
    return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
  }
}