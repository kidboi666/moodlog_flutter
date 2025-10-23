import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/domain/entities/journal/activity.dart';
import 'package:moodlog/domain/entities/journal/emotion.dart';

class CheckIn {
  final int id;
  final DateTime createdAt;
  final MoodType moodType;
  final int? sleepQuality;
  final List<String>? emotionNames;
  final List<String>? activityNames;
  final String? memo;
  final double? latitude;
  final double? longitude;
  final String? address;
  final double? temperature;
  final String? weatherIcon;
  final String? weatherDescription;
  final List<Activity>? activities;
  final List<Emotion>? emotions;

  CheckIn({
    required this.id,
    required this.createdAt,
    required this.moodType,
    this.sleepQuality,
    this.emotionNames,
    this.activityNames,
    this.memo,
    this.latitude,
    this.longitude,
    this.address,
    this.temperature,
    this.weatherIcon,
    this.weatherDescription,
    this.activities,
    this.emotions,
  });

  CheckIn attachActivities(List<Activity> activities) {
    return CheckIn(
      id: id,
      createdAt: createdAt,
      moodType: moodType,
      sleepQuality: sleepQuality,
      emotionNames: emotionNames,
      activityNames: activityNames,
      memo: memo,
      latitude: latitude,
      longitude: longitude,
      address: address,
      temperature: temperature,
      weatherIcon: weatherIcon,
      weatherDescription: weatherDescription,
      activities: activities,
      emotions: emotions,
    );
  }

  CheckIn attachEmotions(List<Emotion> emotions) {
    return CheckIn(
      id: id,
      createdAt: createdAt,
      moodType: moodType,
      sleepQuality: sleepQuality,
      emotionNames: emotionNames,
      activityNames: activityNames,
      memo: memo,
      latitude: latitude,
      longitude: longitude,
      address: address,
      temperature: temperature,
      weatherIcon: weatherIcon,
      weatherDescription: weatherDescription,
      activities: activities,
      emotions: emotions,
    );
  }
}
