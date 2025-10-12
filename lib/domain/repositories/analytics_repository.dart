import 'package:moodlog/domain/entities/analytics/analytics_event.dart';
import 'package:moodlog/domain/entities/analytics/analytics_observer.dart';
import 'package:moodlog/domain/entities/analytics/mood_analytics.dart';
import 'package:moodlog/domain/entities/analytics/screen_view.dart';

abstract class AnalyticsRepository {
  AnalyticsObserver get observer;

  Future<void> initialize();

  Future<void> logEvent(AnalyticsEvent event);

  Future<void> setUserProperty({required String name, required String value});

  Future<void> setUserId(String? userId);

  Future<void> logScreenView(ScreenView screenView);

  Future<void> logMoodEntry(MoodAnalytics moodAnalytics);

  Future<void> logMoodView({required String viewType, String? period});

  Future<void> logSettingsChange({
    required String settingType,
    required String value,
  });

  Future<void> logFeatureUsage({
    required String featureName,
    Map<String, Object>? context,
  });

  Future<void> logUserEngagement({
    required String engagementType,
    int? duration,
  });
}
