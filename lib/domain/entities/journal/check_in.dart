import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/domain/entities/journal/emotion.dart';
import 'package:moodlog/domain/entities/journal/tag.dart';

class CheckIn {
  final int id;
  final DateTime createdAt;
  final MoodType moodType;
  final int? sleepQuality;
  final List<String>? emotionNames;
  final List<String>? tagNames;
  final String? memo;
  final double? latitude;
  final double? longitude;
  final String? address;
  final double? temperature;
  final String? weatherIcon;
  final String? weatherDescription;
  final List<Tag>? tags;
  final List<Emotion>? emotions;

  CheckIn({
    required this.id,
    required this.createdAt,
    required this.moodType,
    this.sleepQuality,
    this.emotionNames,
    this.tagNames,
    this.memo,
    this.latitude,
    this.longitude,
    this.address,
    this.temperature,
    this.weatherIcon,
    this.weatherDescription,
    this.tags,
    this.emotions,
  });

  CheckIn attachTags(List<Tag> tags) {
    return CheckIn(
      id: id,
      createdAt: createdAt,
      moodType: moodType,
      sleepQuality: sleepQuality,
      emotionNames: emotionNames,
      tagNames: tagNames,
      memo: memo,
      latitude: latitude,
      longitude: longitude,
      address: address,
      temperature: temperature,
      weatherIcon: weatherIcon,
      weatherDescription: weatherDescription,
      tags: tags,
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
      tagNames: tagNames,
      memo: memo,
      latitude: latitude,
      longitude: longitude,
      address: address,
      temperature: temperature,
      weatherIcon: weatherIcon,
      weatherDescription: weatherDescription,
      tags: tags,
      emotions: emotions,
    );
  }
}
