import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

import '../../core/utils/result.dart';
import '../../domain/entities/journal/weather_info.dart';
import '../../domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  // 실제 OpenWeatherMap API 키를 사용하려면:
  // 1. https://openweathermap.org/api 에서 무료 API 키 발급
  // 2. 아래 'demo_key'를 발급받은 API 키로 교체
  // 현재는 Mock 데이터가 반환됩니다.
  static const String _apiKey = '210b2d0ea5645db646e999c2e039b211';
  final Logger _log = Logger('WeatherRepositoryImpl');

  @override
  Future<Result<WeatherInfo>> getCurrentWeather({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final url = Uri.parse(
        '$_baseUrl/weather?lat=$latitude&lon=$longitude&appid=$_apiKey&units=metric&lang=kr',
      );

      _log.info('Fetching weather data from: $url');

      final response = await http.get(url);
      _log.info('Response status: ${response.statusCode}');
      debugPrint('Response status: ${response.statusCode}');
      _log.info('Response body: ${response.body}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final weatherInfo = _parseOpenWeatherData(data);
        _log.fine('Weather data fetched successfully');
        return Result.ok(weatherInfo);
      } else if (response.statusCode == 401) {
        _log.warning('API key invalid, returning mock data');
        return Result.ok(_getMockWeatherData(latitude, longitude));
      } else {
        final error = 'OpenWeatherMap API Error: ${response.statusCode}';
        _log.warning(error);
        return Result.failure(Exception(error));
      }
    } catch (e) {
      _log.severe('Failed to fetch weather data: $e');
      // 네트워크 오류 등의 경우 Mock 데이터 반환
      _log.info('Returning mock weather data due to error');
      return Result.ok(_getMockWeatherData(latitude, longitude));
    }
  }

  /// OpenWeatherMap API 응답을 WeatherInfo 객체로 변환합니다.
  WeatherInfo _parseOpenWeatherData(Map<String, dynamic> data) {
    final main = data['main'];
    final weather = (data['weather'] as List).first;
    final wind = data['wind'] ?? {};
    final location = data['name'] as String? ?? '현재 위치';

    return WeatherInfo(
      temperature: (main['temp'] as num).toDouble(),
      description: weather['description'] as String,
      icon: weather['icon'] as String,
      humidity: (main['humidity'] as num).toDouble(),
      pressure: (main['pressure'] as num?)?.toDouble() ?? 0.0,
      windSpeed: (wind['speed'] as num?)?.toDouble() ?? 0.0,
      location: location,
      timestamp: DateTime.now(),
    );
  }

  /// 테스트용 Mock 날씨 데이터를 생성합니다.
  WeatherInfo _getMockWeatherData(double latitude, double longitude) {
    // 간단한 위치 기반 Mock 데이터
    final temp = 20 + (latitude / 10).round(); // 위도에 따른 온도 변화
    final descriptions = ['맑음', '흐림', '비', '눈', '구름 많음'];
    final icons = ['01d', '03d', '10d', '13d', '04d'];
    final index = (latitude + longitude).abs().round() % descriptions.length;

    return WeatherInfo(
      temperature: temp.toDouble(),
      description: descriptions[index],
      icon: icons[index],
      humidity: 65.0,
      pressure: 1013.25,
      windSpeed: 3.5,
      location: '현재 위치',
      timestamp: DateTime.now(),
    );
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
