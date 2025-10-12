import 'package:moodlog/core/constants/enum.dart' show AiPersonality, MoodType;
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/repositories/gemini_repository.dart';

class GeminiUseCase {
  final GeminiRepository _geminiRepository;

  GeminiUseCase({required GeminiRepository geminiRepository})
    : _geminiRepository = geminiRepository;

  Future<void> initialize(AiPersonality aiPersonality) {
    return _geminiRepository.init(aiPersonality);
  }

  Future<Result<String>> generateResponse({
    required String prompt,
    required MoodType moodType,
  }) {
    return _geminiRepository.generateResponse(
      prompt: prompt,
      moodType: moodType,
    );
  }
}
