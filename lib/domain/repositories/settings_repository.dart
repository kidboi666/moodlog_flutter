import '../entities/app/app_info.dart';
import '../entities/app/settings.dart';

abstract class SettingsRepository {
  Future<Settings> loadSettings();

  Future<void> updateSettings(Settings newSettings);

  Future<AppInfo> getAppInfo();

  Future<DateTime?> getLastAiUsageDate();

  Future<void> updateLastAiUsageDate(DateTime date);

  Future<void> clearSharedPreferences();
}
