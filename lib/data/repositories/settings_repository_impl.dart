import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/data/data_source/local/database/database.dart';
import 'package:moodlog/data/data_source/local/shared_preferences_local_data_source.dart';
import 'package:moodlog/domain/entities/ai/ai_usage.dart';
import 'package:moodlog/domain/entities/app/app_info.dart';
import 'package:moodlog/domain/entities/app/settings.dart';
import 'package:moodlog/domain/repositories/settings_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SharedPreferencesLocalDataSource _localDataSource;
  final MoodLogDatabase _db;

  SettingsRepositoryImpl({
    required SharedPreferencesLocalDataSource localDataSource,
    required MoodLogDatabase db,
  }) : _localDataSource = localDataSource,
       _db = db;

  @override
  Future<Settings> loadSettings() async {
    final hasNotificationEnabled = await _localDataSource.getBool(
      'hasNotificationEnabled',
    );
    final hasAutoSyncEnabled = await _localDataSource.getBool(
      'hasAutoSyncEnabled',
    );
    final themeModeString = await _localDataSource.getString('themeMode');
    final colorThemeString = await _localDataSource.getString('colorTheme');
    final languageCodeString = await _localDataSource.getString('languageCode');
    final aiPersonalityString = await _localDataSource.getString(
      'aiPersonality',
    );
    final fontFamilyString = await _localDataSource.getString('fontFamily');
    final textAlignString = await _localDataSource.getString('textAlign');
    final isOnboardingComplete = await _localDataSource.getBool(
      'isOnboardingComplete',
    );
    final isAppLockEnabled = await _localDataSource.getBool('isAppLockEnabled');
    final lockTypeString = await _localDataSource.getString('lockType');

    return Settings(
      hasNotificationEnabled: hasNotificationEnabled,
      hasAutoSyncEnabled: hasAutoSyncEnabled,
      themeMode: ThemeMode.fromString(themeModeString),
      colorTheme: ColorTheme.fromString(colorThemeString),
      languageCode: LanguageCode.fromString(languageCodeString),
      aiPersonality: AiPersonality.fromString(aiPersonalityString),
      fontFamily: FontFamily.fromString(fontFamilyString),
      textAlign: SimpleTextAlign.fromString(textAlignString),
      isOnboardingComplete: isOnboardingComplete,
      isAppLockEnabled: isAppLockEnabled,
      lockType: LockType.fromString(lockTypeString),
    );
  }

  @override
  Future<Settings> updateSettings(Settings newSettings) async {
    await _localDataSource.setBool(
      'hasNotificationEnabled',
      newSettings.hasNotificationEnabled,
    );
    await _localDataSource.setBool(
      'hasAutoSyncEnabled',
      newSettings.hasAutoSyncEnabled,
    );
    await _localDataSource.setString('themeMode', newSettings.themeMode.name);
    await _localDataSource.setString('colorTheme', newSettings.colorTheme.name);
    await _localDataSource.setString(
      'languageCode',
      newSettings.languageCode.name,
    );
    await _localDataSource.setString(
      'aiPersonality',
      newSettings.aiPersonality.name,
    );
    await _localDataSource.setString('fontFamily', newSettings.fontFamily.name);
    await _localDataSource.setString('textAlign', newSettings.textAlign.name);
    await _localDataSource.setBool(
      'isOnboardingComplete',
      newSettings.isOnboardingComplete,
    );
    await _localDataSource.setBool(
      'isAppLockEnabled',
      newSettings.isAppLockEnabled,
    );
    await _localDataSource.setString('lockType', newSettings.lockType.value);
    return newSettings;
  }

  @override
  Future<AppInfo> getAppInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return AppInfo(
      appName: packageInfo.appName,
      packageName: packageInfo.packageName,
      version: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
    );
  }

  @override
  Future<AiUsage?> getAiUsage() async {
    final usageCount = await _localDataSource.getInt('aiUsageCount');
    final lastUsedString = await _localDataSource.getString('aiUsageLastUsed');
    if (lastUsedString == null) return null;

    return AiUsage(count: usageCount, date: DateTime.parse(lastUsedString));
  }

  @override
  Future<void> updateAiUsage(AiUsage usage) async {
    await _localDataSource.setInt('aiUsageCount', usage.count);
    await _localDataSource.setString(
      'aiUsageLastUsed',
      usage.date.toIso8601String(),
    );
  }

  @override
  Future<void> clearSharedPreferences() async {
    await _localDataSource.clear();
  }

  @override
  Future<void> clearAllData() async {
    await _db.clearAllTables();
    await _localDataSource.clear();
  }

  String _hashPin(String pin) {
    final bytes = utf8.encode(pin);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Future<void> savePin(String pin) async {
    final hashedPin = _hashPin(pin);
    await _localDataSource.setString('pin_hash', hashedPin);
  }

  @override
  Future<bool> verifyPin(String pin) async {
    final storedHash = await _localDataSource.getString('pin_hash');
    if (storedHash == null) return false;

    final hashedPin = _hashPin(pin);
    return hashedPin == storedHash;
  }

  @override
  Future<bool> hasPin() async {
    final storedHash = await _localDataSource.getString('pin_hash');
    return storedHash != null;
  }

  @override
  Future<void> deletePin() async {
    await _localDataSource.remove('pin_hash');
  }
}
