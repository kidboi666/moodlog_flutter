import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/journal/emotion.dart';
import 'package:moodlog/domain/repositories/emotion_repository.dart';

class EmotionUseCase {
  final EmotionRepository _repository;

  EmotionUseCase(this._repository);

  Future<Result<List<Emotion>>> getAllEmotions() async {
    return await _repository.getAllEmotions();
  }

  Future<Result<Emotion>> createEmotion(String name) async {
    final existingResult = await _repository.getEmotionByName(name);
    switch (existingResult) {
      case Ok<Emotion?>():
        if (existingResult.value != null) {
          return Result.ok(existingResult.value!);
        }
        return await _repository.createEmotion(name);
      case Error<Emotion?>():
        return Result.error(existingResult.error);
    }
  }

  Future<Result<void>> deleteEmotion(int id) async {
    return await _repository.deleteEmotion(id);
  }
}
