import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/common.dart';
import '../../core/constants/enum.dart';
import '../../domain/repositories/app_state_repository.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  final SharedPreferencesAsync _prefs;

  SettingsRepositoryImpl({SharedPreferencesAsync? prefs})
    : _prefs = prefs ?? SharedPreferencesAsync();

  @override
  Future<ThemeMode> getThemeMode() async {
    final themeModeString = await _prefs.getString(PreferenceKeys.themeMode);
    return ThemeMode.fromString(themeModeString);
  }

  @override
  Future<LanguageCode> getLanguageCode() async {
    final languageCodeString = await _prefs.getString(
      PreferenceKeys.languageCode,
    );
    return LanguageCode.fromString(languageCodeString);
  }

  @override
  Future<AiPersonality> getAiPersonality() async {
    final aiPersonalityString = await _prefs.getString(
      PreferenceKeys.aiPersonality,
    );
    return AiPersonality.fromString(aiPersonalityString);
  }

  @override
  Future<bool> getHasNotificationEnabled() async {
    return await _prefs.getBool(PreferenceKeys.hasNotificationEnabled) ?? false;
  }

  @override
  Future<bool> getHasAutoSyncEnabled() async {
    return await _prefs.getBool(PreferenceKeys.hasAutoSyncEnabled) ?? false;
  }

  @override
  Future<ColorTheme> getColorTheme() async {
    final colorThemeString = await _prefs.getString(PreferenceKeys.colorTheme);
    return ColorTheme.fromString(colorThemeString);
  }

  @override
  Future<FontFamily> getFontFamily() async {
    final fontFamilyString = await _prefs.getString(PreferenceKeys.fontFamily);
    return FontFamily.fromString(fontFamilyString);
  }

  @override
  Future<bool> getOnboardingCompleted() async {
    return await _prefs.getBool(PreferenceKeys.onboardingCompleted) ?? false;
  }

  @override
  Future<void> updateAiPersonality(AiPersonality aiPersonality) async {
    await _prefs.setString(PreferenceKeys.aiPersonality, aiPersonality.value);
  }

  @override
  Future<void> updateLanguage(LanguageCode languageCode) async {
    await _prefs.setString(PreferenceKeys.languageCode, languageCode.value);
  }

  @override
  Future<void> updateThemeMode(ThemeMode themeMode) async {
    await _prefs.setString(PreferenceKeys.themeMode, themeMode.value);
  }

  @override
  Future<void> updateFontFamily(FontFamily fontFamily) async {
    await _prefs.setString(PreferenceKeys.fontFamily, fontFamily.value);
  }

  @override
  Future<void> updateColorTheme(ColorTheme colorTheme) async {
    await _prefs.setString(PreferenceKeys.colorTheme, colorTheme.value);
  }

  @override
  Future<void> updateNotificationEnabled(bool hasNotificationEnabled) async {
    await _prefs.setBool(
      PreferenceKeys.hasNotificationEnabled,
      hasNotificationEnabled,
    );
  }

  @override
  Future<void> updateAutoSyncEnabled(bool hasAutoSyncEnabled) async {
    await _prefs.setBool(PreferenceKeys.hasAutoSyncEnabled, hasAutoSyncEnabled);
  }

  @override
  Future<void> updateOnboardingCompleted(bool onboardingCompleted) async {
    await _prefs.setBool(
      PreferenceKeys.onboardingCompleted,
      onboardingCompleted,
    );
  }

  /// kDebugMode
  @override
  Future<void> clearSharedPreferences() async {
    if (kDebugMode) {
      await _prefs.clear();
    }
  }
}
