import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/widgets.dart';

import '../../domain/entities/analytics/analytics_event.dart';
import '../../domain/entities/analytics/analytics_observer.dart';
import '../../domain/entities/analytics/mood_analytics.dart';
import '../../domain/entities/analytics/screen_view.dart';
import '../../domain/repositories/analytics_repository.dart';

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  final FirebaseAnalytics _analytics;

  AnalyticsRepositoryImpl({FirebaseAnalytics? analytics})
    : _analytics = analytics ?? FirebaseAnalytics.instance;

  NavigatorObserver get navigatorObserver =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  @override
  AnalyticsObserver get observer {
    final firebaseObserver = FirebaseAnalyticsObserver(analytics: _analytics);
    return AnalyticsObserver(name: firebaseObserver.toString(), properties: {});
  }

  @override
  Future<void> initialize() async {
    await _analytics.setAnalyticsCollectionEnabled(true);
  }

  @override
  Future<void> logEvent(AnalyticsEvent event) async {
    await _analytics.logEvent(name: event.name, parameters: event.parameters);
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
  Future<void> logScreenView(ScreenView screenView) async {
    await _analytics.logScreenView(
      screenName: screenView.screenName,
      screenClass: screenView.screenClass,
    );
  }

  @override
  Future<void> logMoodEntry(MoodAnalytics moodAnalytics) async {
    final fromDomainMoodAnalytics = moodAnalytics.toAnalyticsParameters();
    final event = AnalyticsEvent(
      name: 'mood_entry_created',
      parameters: fromDomainMoodAnalytics,
    );
    await logEvent(event);
  }

  @override
  Future<void> logMoodView({required String viewType, String? period}) async {
    final event = AnalyticsEvent(
      name: 'mood_view',
      parameters: {'view_type': viewType, 'period': period ?? ''},
    );
    await logEvent(event);
  }

  @override
  Future<void> logSettingsChange({
    required String settingType,
    required String value,
  }) async {
    final event = AnalyticsEvent(
      name: 'settings_changed',
      parameters: {'setting_type': settingType, 'value': value},
    );
    await logEvent(event);
  }

  @override
  Future<void> logFeatureUsage({
    required String featureName,
    Map<String, Object>? context,
  }) async {
    final event = AnalyticsEvent(
      name: 'feature_used',
      parameters: {'feature_name': featureName, ...?context},
    );
    await logEvent(event);
  }

  @override
  Future<void> logUserEngagement({
    required String engagementType,
    int? duration,
  }) async {
    final event = AnalyticsEvent(
      name: 'user_engagement',
      parameters: {
        'engagement_type': engagementType,
        if (duration != null) 'duration_seconds': duration,
      },
    );
    await logEvent(event);
  }
}
