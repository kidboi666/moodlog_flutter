import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:moodlog/core/utils/flavor_config.dart';
import 'package:moodlog/domain/entities/app/settings.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../core/constants/common.dart';
import '../../domain/entities/app/app_info.dart';
import '../../domain/repositories/settings_repository.dart';
import '../data_source/local/shared_preferences_local_data_source.dart';
import '../models/app_state_shared_preferences_model.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  final SharedPreferencesLocalDataSource _prefs;

  SettingsRepositoryImpl({
    required SharedPreferencesLocalDataSource localDataSource,
  }) : _prefs = localDataSource;

  final Logger _log = Logger('SettingsRepositoryImpl');

  @override
  Future<Settings> loadSettings() async {
    final settings = await _prefs.getString(PreferenceKeys.appSettings);
    _log.info('Loaded settings: $settings');

    if (settings == null) {
      _log.info('No settings found, creating default settings');
      final defaultSettings = Settings();
      await updateSettings(defaultSettings);
      return defaultSettings;
    }

    final settingMap = jsonDecode(settings);
    final settingsModel = AppStateSharedPreferencesModel.fromJson(settingMap);
    return settingsModel.toDomain();
  }

  @override
  Future<Settings> updateSettings(Settings newSettings) async {
    final settingsModel = AppStateSharedPreferencesModel.fromDomain(
      newSettings,
    );
    final settings = settingsModel.toJson();
    await _prefs.setString(PreferenceKeys.appSettings, jsonEncode(settings));
    return newSettings;
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
    if (FlavorConfig.isDevelopment) {
      await _prefs.clear();
    }
  }

  @override
  Future<void> clearAllData() async {
    await _prefs.clear();
  }
}
