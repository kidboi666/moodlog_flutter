import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moodlog/core/constants/enum.dart';

part 'mood_summary.freezed.dart';
part 'mood_summary.g.dart';

@freezed
abstract class MoodSummary with _$MoodSummary {
  const factory MoodSummary({
    required int id,
    required MoodSummaryPeriod period,
    required DateTime startDate,
    required DateTime endDate,
    required DateTime generatedAt,
    required String emotionalFlow,
    required String dominantMoods,
    required String activityPatterns,
    required String personalAdvice,
    required String keyPoints,
    required Map<String, dynamic> metadata,
  }) = _MoodSummary;

  factory MoodSummary.fromJson(Map<String, dynamic> json) =>
      _$MoodSummaryFromJson(json);
}
