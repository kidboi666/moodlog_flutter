import '../../../core/constants/enum.dart';
import 'tag.dart';

class Journal {
  final int id;
  final MoodType moodType;
  final DateTime createdAt;
  final bool aiResponseEnabled;
  final String? content;
  final List<String>? imageUri;
  final List<String>? tagNames;
  final String? aiResponse;
  final double? latitude;
  final double? longitude;
  final String? address;
  final double? temperature;
  final String? weatherIcon;
  final String? weatherDescription;
  final List<Tag>? tags;

  Journal({
    required this.id,
    required this.moodType,
    required this.createdAt,
    required this.aiResponseEnabled,
    this.content,
    this.imageUri,
    this.tagNames,
    this.aiResponse,
    this.latitude,
    this.longitude,
    this.address,
    this.temperature,
    this.weatherIcon,
    this.weatherDescription,
    this.tags,
  });
}
