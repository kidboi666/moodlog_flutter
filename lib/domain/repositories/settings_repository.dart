import 'package:moodlog/domain/entities/ai/ai_usage.dart';
import 'package:moodlog/domain/entities/app/app_info.dart';
import 'package:moodlog/domain/entities/app/settings.dart';

abstract class SettingsRepository {
  Future<Settings> loadSettings();

  Future<Settings> updateSettings(Settings newSettings);

  Future<AppInfo> getAppInfo();

  Future<AiUsage?> getAiUsage();

  Future<void> updateAiUsage(AiUsage usage);

  Future<void> clearSharedPreferences();

  Future<void> clearAllData();

  Future<void> savePin(String pin);

  Future<bool> verifyPin(String pin);

  Future<bool> hasPin();

  Future<void> deletePin();
}
