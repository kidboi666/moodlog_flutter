import 'package:flutter_test/flutter_test.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/domain/entities/app_state.dart';

void main() {
  group('AppState', () {
    test('fromJson creates a valid AppState instance', () {
      final json = {
        'hasNotificationEnabled': false,
        'hasAutoSyncEnabled': false,
        'themeMode': 'system',
        'colorTheme': 'teal',
        'languageCode': 'ko',
        'aiPersonality': 'balanced',
      };

      final appState = AppState.fromJson(json);

      expect(appState.hasNotificationEnabled, false);
      expect(appState.hasAutoSyncEnabled, false);
      expect(appState.themeMode, ThemeMode.system);
      expect(appState.colorTheme, ColorTheme.red);
      expect(appState.languageCode, LanguageCode.ko);
      expect(appState.aiPersonality, AiPersonality.balanced);
    });

    test('toJson returns valid JSON', () {
      final appState = AppState(
        hasNotificationEnabled: false,
        hasAutoSyncEnabled: false,
        themeMode: ThemeMode.system,
        colorTheme: ColorTheme.red,
        languageCode: LanguageCode.ko,
        aiPersonality: AiPersonality.balanced,
      );

      final json = appState.toJson();

      expect(json['hasNotificationEnabled'], false);
      expect(json['hasAutoSyncEnabled'], false);
      expect(json['themeMode'], 'system');
      expect(json['colorTheme'], 'teal');
      expect(json['languageCode'], 'ko');
      expect(json['aiPersonality'], 'balanced');
    });

    test('fromJson creates a valid AppState with default values', () {
      final json = AppState();
      final appState = AppState.fromJson(json.toJson());
      expect(appState.hasNotificationEnabled, false);
      expect(appState.hasAutoSyncEnabled, false);
      expect(appState.themeMode, ThemeMode.system);
      expect(appState.colorTheme, ColorTheme.red);
      expect(appState.languageCode, LanguageCode.ko);
      expect(appState.aiPersonality, AiPersonality.balanced);
    });
  });
}
