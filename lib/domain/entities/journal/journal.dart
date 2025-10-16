import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/domain/entities/journal/emotion.dart';
import 'package:moodlog/domain/entities/journal/tag.dart';

class Journal {
  final int id;
  final MoodType moodType;
  final EntryType entryType;
  final DateTime createdAt;
  final bool aiResponseEnabled;
  final String? content;
  final String? note;
  final List<String>? imageUri;
  final String? aiResponse;
  final double? latitude;
  final double? longitude;
  final String? address;
  final double? temperature;
  final String? weatherIcon;
  final String? weatherDescription;
  final List<String>? tagNames;
  final List<Tag>? tags;
  final List<Emotion>? emotions;

  Journal({
    required this.id,
    required this.moodType,
    required this.entryType,
    required this.createdAt,
    required this.aiResponseEnabled,
    this.content,
    this.note,
    this.imageUri,
    this.aiResponse,
    this.latitude,
    this.longitude,
    this.address,
    this.temperature,
    this.tagNames,
    this.weatherIcon,
    this.weatherDescription,
    this.tags,
    this.emotions,
  });

  Journal attachTags(List<Tag> tags) {
    return Journal(
      id: id,
      content: content,
      note: note,
      moodType: moodType,
      entryType: entryType,
      imageUri: imageUri,
      aiResponseEnabled: aiResponseEnabled,
      aiResponse: aiResponse,
      createdAt: createdAt,
      latitude: latitude,
      longitude: longitude,
      address: address,
      temperature: temperature,
      tags: tags,
      weatherIcon: weatherIcon,
      weatherDescription: weatherDescription,
      tagNames: tagNames,
      emotions: emotions,
    );
  }

  Journal attachEmotions(List<Emotion> emotions) {
    return Journal(
      id: id,
      content: content,
      note: note,
      moodType: moodType,
      entryType: entryType,
      imageUri: imageUri,
      aiResponseEnabled: aiResponseEnabled,
      aiResponse: aiResponse,
      createdAt: createdAt,
      latitude: latitude,
      longitude: longitude,
      address: address,
      temperature: temperature,
      tags: tags,
      weatherIcon: weatherIcon,
      weatherDescription: weatherDescription,
      tagNames: tagNames,
      emotions: emotions,
    );
  }
}
