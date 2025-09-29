// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state_shared_preferences_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppStateSharedPreferencesModel _$AppStateSharedPreferencesModelFromJson(
  Map<String, dynamic> json,
) => _AppStateSharedPreferencesModel(
  hasNotificationEnabled: json['hasNotificationEnabled'] as bool? ?? false,
  hasAutoSyncEnabled: json['hasAutoSyncEnabled'] as bool? ?? false,
  themeMode: json['themeMode'] as String? ?? 'ThemeMode.system',
  colorTheme: json['colorTheme'] as String? ?? 'ColorTheme.blue',
  languageCode: json['languageCode'] as String? ?? 'LanguageCode.ko',
  aiPersonality: json['aiPersonality'] as String? ?? 'AiPersonality.balanced',
  fontFamily: json['fontFamily'] as String? ?? 'FontFamily.restart',
  textAlign: json['textAlign'] as String? ?? 'SimpleTextAlign.left',
  isOnboardingComplete: json['isOnboardingComplete'] as bool? ?? false,
  isSocialOnboardingComplete:
      json['isSocialOnboardingComplete'] as bool? ?? false,
);

Map<String, dynamic> _$AppStateSharedPreferencesModelToJson(
  _AppStateSharedPreferencesModel instance,
) => <String, dynamic>{
  'hasNotificationEnabled': instance.hasNotificationEnabled,
  'hasAutoSyncEnabled': instance.hasAutoSyncEnabled,
  'themeMode': instance.themeMode,
  'colorTheme': instance.colorTheme,
  'languageCode': instance.languageCode,
  'aiPersonality': instance.aiPersonality,
  'fontFamily': instance.fontFamily,
  'textAlign': instance.textAlign,
  'isOnboardingComplete': instance.isOnboardingComplete,
  'isSocialOnboardingComplete': instance.isSocialOnboardingComplete,
};
