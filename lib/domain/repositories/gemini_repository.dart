import 'package:moodlog/core/constants/enum.dart';

abstract class GeminiRepository {
  bool get isInitialized;

  Future<void> initialize({required AiPersonality aiPersonality});

  void updatePersonality(AiPersonality personality);

  Future<String> generateResponse(String prompt);
}
