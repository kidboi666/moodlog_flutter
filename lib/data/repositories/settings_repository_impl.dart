import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/common.dart';
import '../../core/constants/enum.dart';
import '../../domain/repositories/app_state_repository.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  SharedPreferences? _prefs;
  final Logger _log = Logger('SettingsRepositoryImpl');

  SettingsRepositoryImpl();

  Future<SharedPreferences> get prefs async {
    return _prefs ??= await SharedPreferences.getInstance();
  }

  @override
  Future<ThemeMode> getThemeMode() async {
    final p = await prefs;
    final themeModeString = p.getString(PreferenceKeys.themeMode);
    _log.info('Loading themeMode: $themeModeString');
    return ThemeMode.fromString(themeModeString);
  }

  @override
  Future<LanguageCode> getLanguageCode() async {
    final p = await prefs;
    final languageCodeString = p.getString(PreferenceKeys.languageCode);
    return LanguageCode.fromString(languageCodeString);
  }

  @override
  Future<AiPersonality> getAiPersonality() async {
    final p = await prefs;
    final aiPersonalityString = p.getString(PreferenceKeys.aiPersonality);
    return AiPersonality.fromString(aiPersonalityString);
  }

  @override
  Future<bool> getHasNotificationEnabled() async {
    final p = await prefs;
    return p.getBool(PreferenceKeys.hasNotificationEnabled) ?? false;
  }

  @override
  Future<bool> getHasAutoSyncEnabled() async {
    final p = await prefs;
    return p.getBool(PreferenceKeys.hasAutoSyncEnabled) ?? false;
  }

  @override
  Future<ColorTheme> getColorTheme() async {
    final p = await prefs;
    final colorThemeString = p.getString(PreferenceKeys.colorTheme);
    return ColorTheme.fromString(colorThemeString);
  }

  @override
  Future<FontFamily> getFontFamily() async {
    final p = await prefs;
    final fontFamilyString = p.getString(PreferenceKeys.fontFamily);
    _log.info('Loading fontFamily: $fontFamilyString');
    return FontFamily.fromString(fontFamilyString);
  }

  @override
  Future<SimpleTextAlign> getTextAlign() async {
    final p = await prefs;
    final textAlignString = p.getString(PreferenceKeys.textAlign);
    return SimpleTextAlign.fromString(textAlignString);
  }

  @override
  Future<List<String>?> getOnboardedLoginTypes() async {
    final p = await prefs;
    return p.getStringList(PreferenceKeys.onboardingCompleted);
  }

  @override
  Future<void> updateAiPersonality(AiPersonality aiPersonality) async {
    final p = await prefs;
    await p.setString(PreferenceKeys.aiPersonality, aiPersonality.value);
  }

  @override
  Future<void> updateLanguage(LanguageCode languageCode) async {
    final p = await prefs;
    await p.setString(PreferenceKeys.languageCode, languageCode.value);
  }

  @override
  Future<void> updateThemeMode(ThemeMode themeMode) async {
    final p = await prefs;
    _log.info('Saving themeMode: ${themeMode.value}');
    await p.setString(PreferenceKeys.themeMode, themeMode.value);
  }

  @override
  Future<void> updateFontFamily(FontFamily fontFamily) async {
    final p = await prefs;
    _log.info('Saving fontFamily: ${fontFamily.value}');
    await p.setString(PreferenceKeys.fontFamily, fontFamily.value);
  }

  @override
  Future<void> updateTextAlign(SimpleTextAlign textAlign) async {
    final p = await prefs;
    await p.setString(PreferenceKeys.textAlign, textAlign.value);
  }

  @override
  Future<void> updateColorTheme(ColorTheme colorTheme) async {
    final p = await prefs;
    await p.setString(PreferenceKeys.colorTheme, colorTheme.value);
  }

  @override
  Future<void> updateNotificationEnabled(bool hasNotificationEnabled) async {
    final p = await prefs;
    await p.setBool(
      PreferenceKeys.hasNotificationEnabled,
      hasNotificationEnabled,
    );
  }

  @override
  Future<void> updateAutoSyncEnabled(bool hasAutoSyncEnabled) async {
    final p = await prefs;
    await p.setBool(PreferenceKeys.hasAutoSyncEnabled, hasAutoSyncEnabled);
  }

  @override
  Future<void> updateOnboardedLoginTypes(LoginType loginType) async {
    List<String>? onboardedLoginTypes = await getOnboardedLoginTypes();

    if (onboardedLoginTypes != null) {
      onboardedLoginTypes.add(loginType.value);
    } else {
      onboardedLoginTypes = [loginType.value];
    }

    final p = await prefs;
    await p.setStringList(
      PreferenceKeys.onboardingCompleted,
      onboardedLoginTypes,
    );
  }

  /// kDebugMode
  @override
  Future<DateTime?> getLastAiUsageDate() async {
    final p = await prefs;
    final dateString = p.getString(PreferenceKeys.lastAiUsageDate);
    if (dateString != null) {
      return DateTime.tryParse(dateString);
    }
    return null;
  }

  @override
  Future<void> updateLastAiUsageDate(DateTime date) async {
    final p = await prefs;
    await p.setString(PreferenceKeys.lastAiUsageDate, date.toIso8601String());
  }

  @override
  Future<void> clearSharedPreferences() async {
    if (kDebugMode) {
      final p = await prefs;
      await p.clear();
    }
  }
}
