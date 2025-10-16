import 'package:moodlog/domain/entities/journal/emotion.dart';

abstract class EmotionRepository {
  Future<List<Emotion>> getAllEmotions();
  Future<Emotion> createEmotion(String name);
  Future<void> deleteEmotion(int id);
  Future<Emotion?> getEmotionByName(String name);
}
