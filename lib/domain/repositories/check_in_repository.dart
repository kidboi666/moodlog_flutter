import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/journal/check_in.dart';
import 'package:moodlog/domain/entities/journal/emotion.dart';
import 'package:moodlog/domain/entities/journal/tag.dart';
import 'package:moodlog/domain/models/create_check_in_request.dart';
import 'package:moodlog/domain/models/update_check_in_request.dart';

abstract class CheckInRepository {
  Stream<List<CheckIn>> get checkInStream;

  Future<Result<int>> createCheckIn(CreateCheckInRequest request);

  Future<Result<int>> updateCheckIn(UpdateCheckInRequest request);

  Future<Result<void>> deleteCheckIn(int id);

  Future<Result<CheckIn?>> getCheckInById(int id);

  Stream<List<CheckIn>> watchCheckInsByDate(DateTime date);

  Stream<List<CheckIn>> watchAllCheckIns();

  Future<Result<bool>> hasTodayCheckIn();

  Future<Result<Map<MoodType, int>>> getMoodCountsByDateRange(
    DateTime start,
    DateTime end,
  );

  Future<Result<List<Tag>>> getTagsForCheckIn(int checkInId);

  Future<Result<List<Emotion>>> getEmotionsForCheckIn(int checkInId);

  Future<Result<void>> updateCheckInTags(int checkInId, List<int> tagIds);

  Future<Result<void>> updateCheckInEmotions(int checkInId, List<int> emotionIds);

  Future<void> notifyCheckInUpdate();
}
