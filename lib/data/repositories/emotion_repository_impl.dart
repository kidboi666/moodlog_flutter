import 'package:moodlog/data/data_source/local/emotion_local_data_source.dart';
import 'package:moodlog/domain/entities/journal/emotion.dart';
import 'package:moodlog/domain/repositories/emotion_repository.dart';

class EmotionRepositoryImpl implements EmotionRepository {
  final EmotionLocalDataSource _localDataSource;

  EmotionRepositoryImpl(this._localDataSource);

  @override
  Future<List<Emotion>> getAllEmotions() async {
    return await _localDataSource.getAllEmotions();
  }

  @override
  Future<Emotion> createEmotion(String name) async {
    return await _localDataSource.createEmotion(name);
  }

  @override
  Future<void> deleteEmotion(int id) async {
    return await _localDataSource.deleteEmotion(id);
  }

  @override
  Future<Emotion?> getEmotionByName(String name) async {
    return await _localDataSource.getEmotionByName(name);
  }
}
