import 'dart:async';

import 'package:logging/logging.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/data/data_source/local/check_in_local_data_source.dart';
import 'package:moodlog/data/data_source/local/emotion_local_data_source.dart';
import 'package:moodlog/data/data_source/local/tag_local_data_source.dart';
import 'package:moodlog/domain/entities/journal/check_in.dart';
import 'package:moodlog/domain/entities/journal/emotion.dart';
import 'package:moodlog/domain/entities/journal/tag.dart';
import 'package:moodlog/domain/models/create_check_in_request.dart';
import 'package:moodlog/domain/models/update_check_in_request.dart';
import 'package:moodlog/domain/repositories/check_in_repository.dart';

class CheckInRepositoryImpl implements CheckInRepository {
  final CheckInLocalDataSource _checkInLocalDataSource;
  final TagLocalDataSource _tagLocalDataSource;
  final EmotionLocalDataSource _emotionLocalDataSource;
  final Logger _log = Logger('CheckInRepositoryImpl');

  CheckInRepositoryImpl({
    required CheckInLocalDataSource checkInLocalDataSource,
    required TagLocalDataSource tagLocalDataSource,
    required EmotionLocalDataSource emotionLocalDataSource,
  })  : _checkInLocalDataSource = checkInLocalDataSource,
        _tagLocalDataSource = tagLocalDataSource,
        _emotionLocalDataSource = emotionLocalDataSource;

  final _checkInStreamController = StreamController<List<CheckIn>>.broadcast();

  @override
  Stream<List<CheckIn>> get checkInStream => _checkInStreamController.stream;

  @override
  Future<Result<int>> createCheckIn(CreateCheckInRequest request) async {
    try {
      final checkInId = await _checkInLocalDataSource.createCheckIn(request);

      if (request.tagNames != null && request.tagNames!.isNotEmpty) {
        final tagIds = await _tagLocalDataSource.getOrCreateTags(
          request.tagNames!,
        );
        await _checkInLocalDataSource.updateCheckInTags(checkInId, tagIds);
      }

      if (request.emotionNames != null && request.emotionNames!.isNotEmpty) {
        final emotionIds = await _emotionLocalDataSource.getOrCreateEmotions(
          request.emotionNames!,
        );
        await _checkInLocalDataSource.updateCheckInEmotions(
          checkInId,
          emotionIds,
        );
      }

      notifyCheckInUpdate();
      return Result.ok(checkInId);
    } catch (e, s) {
      _log.severe('Failed to create check-in', e, s);
      return Result.error(Exception('Failed to create check-in: $e'));
    }
  }

  @override
  Future<Result<int>> updateCheckIn(UpdateCheckInRequest request) async {
    try {
      final updatedRows = await _checkInLocalDataSource.updateCheckIn(request);
      if (updatedRows == 0) {
        return Result.error(Exception('Failed to update check-in'));
      }

      if (request.tagNames != null) {
        final tagIds = await _tagLocalDataSource.getOrCreateTags(
          request.tagNames!,
        );
        await _checkInLocalDataSource.updateCheckInTags(request.id, tagIds);
      }

      if (request.emotionNames != null) {
        final emotionIds = await _emotionLocalDataSource.getOrCreateEmotions(
          request.emotionNames!,
        );
        await _checkInLocalDataSource.updateCheckInEmotions(
          request.id,
          emotionIds,
        );
      }

      notifyCheckInUpdate();
      return Result.ok(updatedRows);
    } catch (e, s) {
      _log.severe('Failed to update check-in', e, s);
      return Result.error(Exception('Failed to update check-in: $e'));
    }
  }

  @override
  Future<Result<void>> deleteCheckIn(int id) async {
    try {
      await _checkInLocalDataSource.deleteCheckIn(id);
      notifyCheckInUpdate();
      return Result.ok(null);
    } catch (e, s) {
      _log.severe('Failed to delete check-in', e, s);
      return Result.error(Exception('Failed to delete check-in: $e'));
    }
  }

  @override
  Future<Result<CheckIn?>> getCheckInById(int id) async {
    try {
      final checkIn = await _checkInLocalDataSource.getCheckInById(id);
      return Result.ok(checkIn);
    } catch (e, s) {
      _log.severe('Failed to get check-in by id', e, s);
      return Result.error(Exception('Failed to get check-in: $e'));
    }
  }

  @override
  Stream<List<CheckIn>> watchCheckInsByDate(DateTime date) {
    return _checkInLocalDataSource.watchCheckInsByDate(date);
  }

  @override
  Stream<List<CheckIn>> watchAllCheckIns() {
    return _checkInLocalDataSource.watchAllCheckIns();
  }

  @override
  Future<Result<bool>> hasTodayCheckIn() async {
    try {
      final hasCheckIn = await _checkInLocalDataSource.hasTodayCheckIn();
      return Result.ok(hasCheckIn);
    } catch (e, s) {
      _log.severe('Failed to check today\'s check-in', e, s);
      return Result.error(Exception('Failed to check today\'s check-in: $e'));
    }
  }

  @override
  Future<Result<Map<MoodType, int>>> getMoodCountsByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    try {
      final moodCounts = await _checkInLocalDataSource.getMoodCountsByDateRange(
        start,
        end,
      );
      return Result.ok(moodCounts);
    } catch (e, s) {
      _log.severe('Failed to get mood counts', e, s);
      return Result.error(Exception('Failed to get mood counts: $e'));
    }
  }

  @override
  Future<Result<List<Tag>>> getTagsForCheckIn(int checkInId) async {
    try {
      final tags = await _checkInLocalDataSource.getTagsForCheckIn(checkInId);
      return Result.ok(tags);
    } catch (e, s) {
      _log.severe('Failed to get tags for check-in', e, s);
      return Result.error(Exception('Failed to get tags: $e'));
    }
  }

  @override
  Future<Result<List<Emotion>>> getEmotionsForCheckIn(int checkInId) async {
    try {
      final emotions = await _checkInLocalDataSource.getEmotionsForCheckIn(
        checkInId,
      );
      return Result.ok(emotions);
    } catch (e, s) {
      _log.severe('Failed to get emotions for check-in', e, s);
      return Result.error(Exception('Failed to get emotions: $e'));
    }
  }

  @override
  Future<Result<void>> updateCheckInTags(int checkInId, List<int> tagIds) async {
    try {
      await _checkInLocalDataSource.updateCheckInTags(checkInId, tagIds);
      notifyCheckInUpdate();
      return Result.ok(null);
    } catch (e, s) {
      _log.severe('Failed to update check-in tags', e, s);
      return Result.error(Exception('Failed to update tags: $e'));
    }
  }

  @override
  Future<Result<void>> updateCheckInEmotions(
    int checkInId,
    List<int> emotionIds,
  ) async {
    try {
      await _checkInLocalDataSource.updateCheckInEmotions(
        checkInId,
        emotionIds,
      );
      notifyCheckInUpdate();
      return Result.ok(null);
    } catch (e, s) {
      _log.severe('Failed to update check-in emotions', e, s);
      return Result.error(Exception('Failed to update emotions: $e'));
    }
  }

  @override
  Future<void> notifyCheckInUpdate() async {
    if (!_checkInStreamController.isClosed) {
      final checkIns = _checkInLocalDataSource.watchAllCheckIns();
      checkIns.listen((data) {
        _checkInStreamController.add(data);
      });
    }
  }

  void dispose() {
    _checkInStreamController.close();
  }
}
