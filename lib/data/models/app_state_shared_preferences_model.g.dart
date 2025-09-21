// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state_shared_preferences_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppStateSharedPreferencesModel _$AppStateSharedPreferencesModelFromJson(
  Map<String, dynamic> json,
) => _AppStateSharedPreferencesModel(
  hasNotificationEnabled: json['hasNotificationEnabled'] as bool,
  hasAutoSyncEnabled: json['hasAutoSyncEnabled'] as bool,
  themeMode: json['themeMode'] as String,
  colorTheme: json['colorTheme'] as String,
  languageCode: json['languageCode'] as String,
  aiPersonality: json['aiPersonality'] as String,
  fontFamily: json['fontFamily'] as String,
  textAlign: json['textAlign'] as String,
  isOnboardingComplete: json['isOnboardingComplete'] as bool,
  isSocialOnboardingComplete: json['isSocialOnboardingComplete'] as bool,
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
