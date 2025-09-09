
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mood_analytics.freezed.dart';

@freezed
abstract class MoodAnalytics with _$MoodAnalytics {
  const factory MoodAnalytics({
    required String moodType,
    required String entryType,
    @Default(false) bool hasImage,
    @Default(false) bool hasTag,
  }) = _MoodAnalytics;
}
