import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/common.dart';
import '../../core/constants/enum.dart';
import '../../core/extensions/enum.dart';
import '../../domain/entities/app_state.dart';
import '../../domain/repositories/app_state_repository.dart';

class AppStateRepositoryImpl extends AppStateRepository {
  final SharedPreferencesAsync _prefs;

  AppStateRepositoryImpl({SharedPreferencesAsync? prefs})
    : _prefs = prefs ?? SharedPreferencesAsync();

  AppState _appState = const AppState();

  @override
  AppState get appState => _appState;

  @override
  Future<void> load() async {
    final themeModeString = await _prefs.getString(PreferenceKeys.themeMode);
    final themeMode = ThemeModeExtension.fromString(themeModeString);
    final languageCodeString = await _prefs.getString(
      PreferenceKeys.languageCode,
    );
    final languageCode = LanguageCodeExtension.fromString(languageCodeString);
    final aiPersonalityString = await _prefs.getString(
      PreferenceKeys.aiPersonality,
    );
    final aiPersonality = AiPersonalityExtension.fromString(
      aiPersonalityString,
    );
    final hasNotificationEnabled =
        await _prefs.getBool(PreferenceKeys.hasNotificationEnabled) ?? false;
    final hasAutoSyncEnabled =
        await _prefs.getBool(PreferenceKeys.hasAutoSyncEnabled) ?? false;
    final colorThemeString = await _prefs.getString(PreferenceKeys.colorTheme);
    final colorTheme = ColorTheme.fromString(colorThemeString);

    _appState = AppState(
      themeMode: themeMode,
      languageCode: languageCode,
      aiPersonality: aiPersonality,
      hasNotificationEnabled: hasNotificationEnabled,
      hasAutoSyncEnabled: hasAutoSyncEnabled,
      colorTheme: colorTheme,
    );
    notifyListeners();
  }

  @override
  Future<void> init({required AiPersonality aiPersonality}) async {
    await _prefs.setString(PreferenceKeys.aiPersonality, aiPersonality.name);
  }

  @override
  Future<void> updateLanguage(LanguageCode languageCode) async {
    await _updatePreference(
      PreferenceKeys.languageCode,
      languageCode.toString(),
      (state) => state.copyWith(languageCode: languageCode),
    );
  }

  @override
  Future<void> updateThemeMode(ThemeMode themeMode) async {
    await _updatePreference(
      PreferenceKeys.themeMode,
      themeMode.toString(),
      (state) => state.copyWith(themeMode: themeMode),
    );
  }

  @override
  Future<void> updateFontFamily(FontFamily fontFamily) async {
    await _updatePreference(
      PreferenceKeys.fontFamily,
      fontFamily.toString(),
      (state) => state.copyWith(fontFamily: fontFamily),
    );
  }

  @override
  Future<void> updateColorTheme(ColorTheme colorTheme) async {
    await _updatePreference(
      PreferenceKeys.colorTheme,
      colorTheme.toString(),
      (state) => state.copyWith(colorTheme: colorTheme),
    );
  }

  @override
  Future<void> updateNotificationEnabled(bool hasNotificationEnabled) async {
    await _updatePreference(
      PreferenceKeys.hasNotificationEnabled,
      hasNotificationEnabled,
      (state) => state.copyWith(hasNotificationEnabled: hasNotificationEnabled),
    );
  }

  @override
  Future<void> updateAutoSyncEnabled(bool hasAutoSyncEnabled) async {
    await _updatePreference(
      PreferenceKeys.hasAutoSyncEnabled,
      hasAutoSyncEnabled,
      (state) => state.copyWith(hasAutoSyncEnabled: hasAutoSyncEnabled),
    );
  }

  /// kDebugMode
  @override
  Future<void> clearSharedPreferences() async {
    if (kDebugMode) {
      await _prefs.clear();
      load();
    }
  }

  void _updateState(AppState newState) {
    _appState = newState;
    notifyListeners();
  }

  Future<void> _updatePreference<T>(
    String key,
    T value,
    AppState Function(AppState) updateState,
  ) async {
    if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    }
    _updateState(updateState(_appState));
  }
}
