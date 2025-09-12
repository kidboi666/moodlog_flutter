import 'package:freezed_annotation/freezed_annotation.dart';

part 'mood_analytics.freezed.dart';

@freezed
abstract class MoodAnalytics with _$MoodAnalytics {
  const MoodAnalytics._();

  const factory MoodAnalytics({
    required String moodType,
    required String entryType,
    @Default(false) bool hasImage,
    @Default(false) bool hasTag,
  }) = _MoodAnalytics;

  Map<String, Object> toAnalyticsParameters() {
    return {
      'mood_type': moodType,
      'entry_type': entryType,
      'has_image': hasImage ? 1 : 0,
      'has_tag': hasTag ? 1 : 0,
    };
  }
}
