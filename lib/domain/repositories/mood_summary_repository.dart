import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/mood_summary/mood_summary.dart';

abstract class MoodSummaryRepository {
  Future<Result<MoodSummary?>> getLatestSummary(MoodSummaryPeriod period);

  Future<Result<List<MoodSummary>>> getSummariesByPeriod(
    MoodSummaryPeriod period, {
    int limit = 10,
  });

  Future<Result<int>> saveSummary(MoodSummary summary);

  Future<Result<void>> deleteSummary(int id);

  Future<Result<MoodSummary?>> getSummaryByDateRange(
    DateTime start,
    DateTime end,
  );

  Future<Result<List<MoodSummary>>> getAllSummaries();
}
