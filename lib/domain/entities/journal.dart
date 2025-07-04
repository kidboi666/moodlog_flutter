import '../../core/constants/enum.dart';

class Journal {
  final int id;
  final String? content;
  final MoodType moodType;
  final List<String>? imageUri;
  final DateTime createdAt;
  final bool aiResponseEnabled;
  final String? aiResponse;

  Journal({
    required this.id,
    this.content,
    required this.moodType,
    this.imageUri,
    required this.createdAt,
    required this.aiResponseEnabled,
    this.aiResponse,
  });
}
