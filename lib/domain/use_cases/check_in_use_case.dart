import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/journal/check_in.dart';
import 'package:moodlog/domain/entities/journal/emotion.dart';
import 'package:moodlog/domain/entities/journal/tag.dart';
import 'package:moodlog/domain/models/create_check_in_request.dart';
import 'package:moodlog/domain/models/update_check_in_request.dart';
import 'package:moodlog/domain/repositories/check_in_repository.dart';

class CheckInUseCase {
  final CheckInRepository _checkInRepository;

  CheckInUseCase({required CheckInRepository checkInRepository})
      : _checkInRepository = checkInRepository;

  Future<Result<int>> createCheckIn(CreateCheckInRequest request) async {
    return await _checkInRepository.createCheckIn(request);
  }

  Future<Result<int>> updateCheckIn(UpdateCheckInRequest request) async {
    return await _checkInRepository.updateCheckIn(request);
  }

  Future<Result<void>> deleteCheckIn(int id) async {
    return await _checkInRepository.deleteCheckIn(id);
  }

  Future<Result<CheckIn?>> getCheckInById(int id) async {
    return await _checkInRepository.getCheckInById(id);
  }

  Stream<List<CheckIn>> watchCheckInsByDate(DateTime date) {
    return _checkInRepository.watchCheckInsByDate(date);
  }

  Stream<List<CheckIn>> watchAllCheckIns() {
    return _checkInRepository.watchAllCheckIns();
  }

  Future<Result<bool>> hasTodayCheckIn() async {
    return await _checkInRepository.hasTodayCheckIn();
  }

  Future<Result<Map<MoodType, int>>> getMoodCountsByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    return await _checkInRepository.getMoodCountsByDateRange(start, end);
  }

  Future<Result<List<Tag>>> getTagsForCheckIn(int checkInId) async {
    return await _checkInRepository.getTagsForCheckIn(checkInId);
  }

  Future<Result<List<Emotion>>> getEmotionsForCheckIn(int checkInId) async {
    return await _checkInRepository.getEmotionsForCheckIn(checkInId);
  }

  Future<Result<void>> updateCheckInTags(int checkInId, List<int> tagIds) async {
    return await _checkInRepository.updateCheckInTags(checkInId, tagIds);
  }

  Future<Result<void>> updateCheckInEmotions(
    int checkInId,
    List<int> emotionIds,
  ) async {
    return await _checkInRepository.updateCheckInEmotions(
      checkInId,
      emotionIds,
    );
  }

  Future<void> notifyCheckInUpdate() async {
    await _checkInRepository.notifyCheckInUpdate();
  }
}
