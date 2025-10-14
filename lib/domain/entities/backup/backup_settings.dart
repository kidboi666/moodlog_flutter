import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/domain/entities/app/settings.dart';

part 'backup_settings.freezed.dart';
part 'backup_settings.g.dart';

@freezed
abstract class BackupSettings with _$BackupSettings {
  const factory BackupSettings({
    required bool hasNotificationEnabled,
    required bool hasAutoSyncEnabled,
    required String themeMode,
    required String colorTheme,
    required String languageCode,
    required String aiPersonality,
    required String fontFamily,
    required String textAlign,
    required bool isOnboardingComplete,
    required bool isAppLockEnabled,
    required String lockType,
    required bool isProUser,
  }) = _BackupSettings;

  factory BackupSettings.fromJson(Map<String, dynamic> json) =>
      _$BackupSettingsFromJson(json);

  factory BackupSettings.fromSettings(Settings settings) {
    return BackupSettings(
      hasNotificationEnabled: settings.hasNotificationEnabled,
      hasAutoSyncEnabled: settings.hasAutoSyncEnabled,
      themeMode: settings.themeMode.name,
      colorTheme: settings.colorTheme.name,
      languageCode: settings.languageCode.name,
      aiPersonality: settings.aiPersonality.name,
      fontFamily: settings.fontFamily.name,
      textAlign: settings.textAlign.name,
      isOnboardingComplete: settings.isOnboardingComplete,
      isAppLockEnabled: settings.isAppLockEnabled,
      lockType: settings.lockType.name,
      isProUser: settings.isProUser,
    );
  }
}

extension BackupSettingsX on BackupSettings {
  Settings toSettings() {
    return Settings(
      hasNotificationEnabled: hasNotificationEnabled,
      hasAutoSyncEnabled: hasAutoSyncEnabled,
      themeMode: ThemeMode.values.byName(themeMode),
      colorTheme: ColorTheme.values.byName(colorTheme),
      languageCode: LanguageCode.values.byName(languageCode),
      aiPersonality: AiPersonality.values.byName(aiPersonality),
      fontFamily: FontFamily.values.byName(fontFamily),
      textAlign: SimpleTextAlign.values.byName(textAlign),
      isOnboardingComplete: isOnboardingComplete,
      isAppLockEnabled: isAppLockEnabled,
      lockType: LockType.values.byName(lockType),
      isProUser: isProUser,
    );
  }
}
