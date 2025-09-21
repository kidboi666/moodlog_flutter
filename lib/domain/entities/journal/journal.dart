import '../../../core/constants/enum.dart';
import 'tag.dart';

class Journal {
  final int id;
  final MoodType moodType;
  final DateTime createdAt;
  final bool aiResponseEnabled;
  final String? content;
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

  Journal({
    required this.id,
    required this.moodType,
    required this.createdAt,
    required this.aiResponseEnabled,
    this.content,
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
  });

  Journal attachTags(List<Tag> tags) {
    return Journal(
      id: id,
      content: content,
      moodType: moodType,
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
    );
  }
}
