import 'package:firebase_analytics/firebase_analytics.dart';

abstract class AnalyticsRepository {
  FirebaseAnalyticsObserver get observer;

  Future<void> initialize();

  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  });

  Future<void> setUserProperty({required String name, required String value});

  Future<void> setUserId(String? userId);

  Future<void> logScreenView({required String screenName, String? screenClass});

  Future<void> logMoodEntry({
    required String moodType,
    required String entryType,
    bool hasImage = false,
    bool hasTag = false,
  });

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
