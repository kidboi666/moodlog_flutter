import 'package:firebase_analytics/firebase_analytics.dart';

import '../../domain/repositories/analytics_repository.dart';

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  static final AnalyticsRepositoryImpl _instance =
      AnalyticsRepositoryImpl._internal();

  factory AnalyticsRepositoryImpl() => _instance;

  AnalyticsRepositoryImpl._internal();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  FirebaseAnalyticsObserver get observer =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  @override
  Future<void> initialize() async {
    await _analytics.setAnalyticsCollectionEnabled(true);
  }

  @override
  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    await _analytics.logEvent(name: name, parameters: parameters);
  }

  @override
  Future<void> setUserProperty({
    required String name,
    required String value,
  }) async {
    await _analytics.setUserProperty(name: name, value: value);
  }

  @override
  Future<void> setUserId(String? userId) async {
    await _analytics.setUserId(id: userId);
  }

  @override
  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    await _analytics.logScreenView(
      screenName: screenName,
      screenClass: screenClass,
    );
  }

  @override
  Future<void> logMoodEntry({
    required String moodType,
    required String entryType,
    bool hasImage = false,
    bool hasTag = false,
  }) async {
    await logEvent(
      name: 'mood_entry_created',
      parameters: {
        'mood_type': moodType,
        'entry_type': entryType,
        'has_image': hasImage,
        'has_tag': hasTag,
      },
    );
  }

  @override
  Future<void> logMoodView({required String viewType, String? period}) async {
    await logEvent(
      name: 'mood_view',
      parameters: {'view_type': viewType, 'period': period ?? ''},
    );
  }

  @override
  Future<void> logSettingsChange({
    required String settingType,
    required String value,
  }) async {
    await logEvent(
      name: 'settings_changed',
      parameters: {'setting_type': settingType, 'value': value},
    );
  }

  @override
  Future<void> logFeatureUsage({
    required String featureName,
    Map<String, Object>? context,
  }) async {
    await logEvent(
      name: 'feature_used',
      parameters: {'feature_name': featureName, ...?context},
    );
  }

  @override
  Future<void> logUserEngagement({
    required String engagementType,
    int? duration,
  }) async {
    await logEvent(
      name: 'user_engagement',
      parameters: {
        'engagement_type': engagementType,
        if (duration != null) 'duration_seconds': duration,
      },
    );
  }
}
