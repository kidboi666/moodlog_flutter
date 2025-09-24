import '../entities/app/app_info.dart';
import '../entities/app/settings.dart';

abstract class SettingsRepository {
  Future<Settings> loadSettings();

  Future<Settings> updateSettings(Settings newSettings);

  Future<AppInfo> getAppInfo();

  Future<DateTime?> getLastAiUsageDate();

  Future<void> updateLastAiUsageDate(DateTime date);

  Future<void> clearSharedPreferences();

  Future<void> clearAllData();
}
