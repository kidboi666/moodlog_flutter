import '../entities/ai/ai_usage.dart';
import '../entities/app/app_info.dart';
import '../entities/app/settings.dart';

abstract class SettingsRepository {
  Future<Settings> loadSettings();

  Future<Settings> updateSettings(Settings newSettings);

  Future<AppInfo> getAppInfo();

  Future<AiUsage?> getAiUsage();

  Future<void> updateAiUsage(AiUsage usage);

  Future<void> clearSharedPreferences();

  Future<void> clearAllData();
}
