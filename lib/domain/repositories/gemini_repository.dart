import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/utils/result.dart';

abstract class GeminiRepository {
  bool get isInitialized;

  Future<void> init(AiPersonality aiPersonality);

  void updatePersonality(AiPersonality personality);

  Future<Result<String>> generateResponse({
    required String prompt,
    required MoodType moodType,
    List<String>? imagePaths,
  });
}
