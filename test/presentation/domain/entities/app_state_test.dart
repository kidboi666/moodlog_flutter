import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/domain/entities/app_state.dart';

void main() {
  group('AppState', () {
    test('fromJson creates a valid AppState instance', () {
      final json = {
        'isFirstLaunch': true,
        'hasNotificationEnabled': false,
        'hasAutoSyncEnabled': false,
        'themeMode': 'system',
        'colorTheme': 'teal',
        'languageCode': 'ko',
        'lastActiveDate': DateTime.now().toIso8601String(),
        'firstLaunchedDate': DateTime.now().toIso8601String(),
        'aiPersonality': 'balanced',
        'nickname': 'John Doe',
      };

      final appState = AppState.fromJson(json);

      expect(appState.isFirstLaunch, true);
      expect(appState.hasNotificationEnabled, false);
      expect(appState.hasAutoSyncEnabled, false);
      expect(appState.themeMode, ThemeMode.system);
      expect(appState.colorTheme, ColorTheme.teal);
      expect(appState.languageCode, LanguageCode.ko);
      expect(appState.lastActiveDate, isNotNull);
      expect(appState.firstLaunchedDate, isNotNull);
      expect(appState.aiPersonality, AiPersonality.balanced);
      expect(appState.nickname, 'John Doe');
    });

    test('toJson returns valid JSON', () {
      final appState = AppState(
        isFirstLaunch: true,
        hasNotificationEnabled: false,
        hasAutoSyncEnabled: false,
        themeMode: ThemeMode.system,
        colorTheme: ColorTheme.teal,
        languageCode: LanguageCode.ko,
        lastActiveDate: DateTime.now(),
        firstLaunchedDate: DateTime.now(),
        aiPersonality: AiPersonality.balanced,
      );

      final json = appState.toJson();

      expect(json['isFirstLaunch'], true);
      expect(json['hasNotificationEnabled'], false);
      expect(json['hasAutoSyncEnabled'], false);
      expect(json['themeMode'], 'system');
      expect(json['colorTheme'], 'teal');
      expect(json['languageCode'], 'ko');
      expect(json['lastActiveDate'], isNotNull);
      expect(json['firstLaunchedDate'], isNotNull);
      expect(json['aiPersonality'], 'balanced');
      expect(json['nickname'], '');
    });

    test('fromJson creates a valid AppState with default values', () {
      final json = AppState();
      final appState = AppState.fromJson(json.toJson());
      expect(appState.isFirstLaunch, true);
      expect(appState.hasNotificationEnabled, false);
      expect(appState.hasAutoSyncEnabled, false);
      expect(appState.themeMode, ThemeMode.system);
      expect(appState.colorTheme, ColorTheme.teal);
      expect(appState.languageCode, LanguageCode.ko);
      expect(appState.lastActiveDate, isNull);
      expect(appState.firstLaunchedDate, isNull);
      expect(appState.aiPersonality, AiPersonality.balanced);
      expect(appState.nickname, '');
    });
  });
}
