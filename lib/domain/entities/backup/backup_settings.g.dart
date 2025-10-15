// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BackupSettings _$BackupSettingsFromJson(Map<String, dynamic> json) =>
    _BackupSettings(
      hasNotificationEnabled: json['hasNotificationEnabled'] as bool,
      hasAutoSyncEnabled: json['hasAutoSyncEnabled'] as bool,
      themeMode: json['themeMode'] as String,
      colorTheme: json['colorTheme'] as String,
      languageCode: json['languageCode'] as String,
      aiPersonality: json['aiPersonality'] as String,
      fontType: json['fontType'] as String,
      textAlign: json['textAlign'] as String,
      isOnboardingComplete: json['isOnboardingComplete'] as bool,
      isAppLockEnabled: json['isAppLockEnabled'] as bool,
      lockType: json['lockType'] as String,
      isProUser: json['isProUser'] as bool,
    );

Map<String, dynamic> _$BackupSettingsToJson(_BackupSettings instance) =>
    <String, dynamic>{
      'hasNotificationEnabled': instance.hasNotificationEnabled,
      'hasAutoSyncEnabled': instance.hasAutoSyncEnabled,
      'themeMode': instance.themeMode,
      'colorTheme': instance.colorTheme,
      'languageCode': instance.languageCode,
      'aiPersonality': instance.aiPersonality,
      'fontType': instance.fontType,
      'textAlign': instance.textAlign,
      'isOnboardingComplete': instance.isOnboardingComplete,
      'isAppLockEnabled': instance.isAppLockEnabled,
      'lockType': instance.lockType,
      'isProUser': instance.isProUser,
    };
