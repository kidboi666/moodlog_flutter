import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../core/constants/common.dart';
import '../../core/constants/enum.dart';
import '../../domain/entities/app/app_info.dart';
import '../../domain/repositories/settings_repository.dart';
import '../data_source/local/shared_preferences_local_data_source.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  final SharedPreferencesLocalDataSource _prefs;

  SettingsRepositoryImpl({
    required SharedPreferencesLocalDataSource localDataSource,
  }) : _prefs = localDataSource;

  final Logger _log = Logger('SettingsRepositoryImpl');

  @override
  Future<ThemeMode> getThemeMode() async {
    final themeModeString = await _prefs.getString(PreferenceKeys.themeMode);
    _log.info('Loading themeMode: $themeModeString');
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
    return await _prefs.getBool(PreferenceKeys.hasNotificationEnabled);
  }

  @override
  Future<bool> getHasAutoSyncEnabled() async {
    return await _prefs.getBool(PreferenceKeys.hasAutoSyncEnabled);
  }

  @override
  Future<ColorTheme> getColorTheme() async {
    final colorThemeString = await _prefs.getString(PreferenceKeys.colorTheme);
    return ColorTheme.fromString(colorThemeString);
  }

  @override
  Future<FontFamily> getFontFamily() async {
    final fontFamilyString = await _prefs.getString(PreferenceKeys.fontFamily);
    _log.info('Loading fontFamily: $fontFamilyString');
    return FontFamily.fromString(fontFamilyString);
  }

  @override
  Future<SimpleTextAlign> getTextAlign() async {
    final textAlignString = await _prefs.getString(PreferenceKeys.textAlign);
    return SimpleTextAlign.fromString(textAlignString);
  }

  @override
  Future<List<String>?> getOnboardingLoginTypes() async {
    return await _prefs.getStringList(PreferenceKeys.onboardingCompleted);
  }

  @override
  Future<AppInfo> getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return AppInfo(
      appName: packageInfo.appName,
      packageName: packageInfo.packageName,
      version: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
    );
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
    _log.info('Saving themeMode: ${themeMode.value}');
    await _prefs.setString(PreferenceKeys.themeMode, themeMode.value);
  }

  @override
  Future<void> updateFontFamily(FontFamily fontFamily) async {
    _log.info('Saving fontFamily: ${fontFamily.value}');
    await _prefs.setString(PreferenceKeys.fontFamily, fontFamily.value);
  }

  @override
  Future<void> updateTextAlign(SimpleTextAlign textAlign) async {
    await _prefs.setString(PreferenceKeys.textAlign, textAlign.value);
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
  Future<void> updateOnboardedLoginTypes(LoginType loginType) async {
    List<String>? onboardedLoginTypes = await getOnboardingLoginTypes();

    if (onboardedLoginTypes != null) {
      onboardedLoginTypes.add(loginType.value);
    } else {
      onboardedLoginTypes = [loginType.value];
    }

    await _prefs.setStringList(
      PreferenceKeys.onboardingCompleted,
      onboardedLoginTypes,
    );
  }

  /// kDebugMode
  @override
  Future<DateTime?> getLastAiUsageDate() async {
    final dateString = await _prefs.getString(PreferenceKeys.lastAiUsageDate);
    if (dateString != null) {
      return DateTime.tryParse(dateString);
    }
    return null;
  }

  @override
  Future<void> updateLastAiUsageDate(DateTime date) async {
    await _prefs.setString(
      PreferenceKeys.lastAiUsageDate,
      date.toIso8601String(),
    );
  }

  @override
  Future<void> clearSharedPreferences() async {
    if (kDebugMode) {
      await _prefs.clear();
    }
  }
}
