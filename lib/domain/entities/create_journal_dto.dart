import '../../common/constants/enum.dart';

class CreateJournalDto {
  final String? content;
  final MoodType moodType;
  final List<String>? imageUri;
  final bool aiResponseEnabled;
  final String? aiResponse;
  final DateTime createdAt;
  final double? latitude;
  final double? longitude;
  final String? address;
  final double? temperature;
  final String? weatherIcon;
  final String? weatherDescription;

  const CreateJournalDto({
    this.content,
    required this.moodType,
    this.imageUri,
    required this.aiResponseEnabled,
    this.aiResponse,
    required this.createdAt,
    this.latitude,
    this.longitude,
    this.address,
    this.temperature,
    this.weatherIcon,
    this.weatherDescription,
  });
}