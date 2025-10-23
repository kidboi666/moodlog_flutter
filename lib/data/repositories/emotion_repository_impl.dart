import 'package:drift/native.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/data/data_source/local/emotion_local_data_source.dart';
import 'package:moodlog/domain/entities/journal/emotion.dart';
import 'package:moodlog/domain/repositories/emotion_repository.dart';

class EmotionRepositoryImpl implements EmotionRepository {
  final EmotionLocalDataSource _localDataSource;
  final Logger _log = Logger('EmotionRepositoryImpl');

  EmotionRepositoryImpl(this._localDataSource);

  @override
  Future<Result<List<Emotion>>> getAllEmotions() async {
    try {
      final emotions = await _localDataSource.getAllEmotions();
      return Result.ok(emotions);
    } catch (e, s) {
      _log.severe('Failed to get all emotions', e, s);
      return Result.error(Exception('Failed to get emotions: $e'));
    }
  }

  @override
  Future<Result<Emotion>> createEmotion(String name) async {
    try {
      final emotion = await _localDataSource.createEmotion(name);
      return Result.ok(emotion);
    } on SqliteException catch (e) {
      if (e.extendedResultCode == 2067) {
        return Result.error(Exception('이미 존재하는 감정 이름입니다'));
      }
      _log.severe('Failed to create emotion', e);
      return Result.error(Exception('Failed to create emotion: $e'));
    } catch (e, s) {
      _log.severe('Failed to create emotion', e, s);
      return Result.error(Exception('Failed to create emotion: $e'));
    }
  }

  @override
  Future<Result<void>> deleteEmotion(int id) async {
    try {
      await _localDataSource.deleteEmotion(id);
      return Result.ok(null);
    } on SqliteException catch (e) {
      if (e.extendedResultCode == 787) {
        return Result.error(Exception('사용 중인 감정은 삭제할 수 없습니다'));
      }
      _log.severe('Failed to delete emotion', e);
      return Result.error(Exception('Failed to delete emotion: $e'));
    } catch (e, s) {
      _log.severe('Failed to delete emotion', e, s);
      return Result.error(Exception('Failed to delete emotion: $e'));
    }
  }

  @override
  Future<Result<Emotion?>> getEmotionByName(String name) async {
    try {
      final emotion = await _localDataSource.getEmotionByName(name);
      return Result.ok(emotion);
    } catch (e, s) {
      _log.severe('Failed to get emotion by name', e, s);
      return Result.error(Exception('Failed to get emotion: $e'));
    }
  }
}
