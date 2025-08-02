import '../../common/constants/enum.dart';

class Journal {
  final int id;
  final String? content;
  final MoodType moodType;
  final List<String>? imageUri;
  final DateTime createdAt;
  final bool aiResponseEnabled;
  final String? aiResponse;
  final double? latitude;
  final double? longitude;
  final String? address;
  final double? temperature;
  final String? weatherIcon;
  final String? weatherDescription;

  Journal({
    required this.id,
    this.content,
    required this.moodType,
    this.imageUri,
    required this.createdAt,
    required this.aiResponseEnabled,
    this.aiResponse,
    this.latitude,
    this.longitude,
    this.address,
    this.temperature,
    this.weatherIcon,
    this.weatherDescription,
  });
}
