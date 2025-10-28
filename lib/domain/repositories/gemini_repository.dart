import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/journal/check_in.dart';

abstract class GeminiRepository {
  Future<Result<Map<String, String>>> generateMoodSummary({
    required List<CheckIn> checkIns,
    required MoodSummaryPeriod period,
    required DateTime startDate,
    required DateTime endDate,
  });
}
