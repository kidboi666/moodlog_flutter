import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/journal/emotion.dart';

abstract class EmotionRepository {
  Future<Result<List<Emotion>>> getAllEmotions();
  Future<Result<Emotion>> createEmotion(String name);
  Future<Result<void>> deleteEmotion(int id);
  Future<Result<Emotion?>> getEmotionByName(String name);
}
