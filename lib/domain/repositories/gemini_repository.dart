import '../../core/constants/enum.dart';
import '../../core/utils/result.dart';

abstract class GeminiRepository {
  bool get isInitialized;

  Future<void> init(AiPersonality aiPersonality);

  void updatePersonality(AiPersonality personality);

  Future<Result<String>> generateResponse({
    required String prompt,
    required MoodType moodType,
  });
}
