import 'package:moodlog/domain/entities/journal/emotion.dart';
import 'package:moodlog/domain/repositories/emotion_repository.dart';

class EmotionUseCase {
  final EmotionRepository _repository;

  EmotionUseCase(this._repository);

  Future<List<Emotion>> getAllEmotions() async {
    return await _repository.getAllEmotions();
  }

  Future<Emotion> createEmotion(String name) async {
    final existing = await _repository.getEmotionByName(name);
    if (existing != null) {
      return existing;
    }
    return await _repository.createEmotion(name);
  }

  Future<void> deleteEmotion(int id) async {
    return await _repository.deleteEmotion(id);
  }
}
