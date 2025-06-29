// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppState _$AppStateFromJson(Map<String, dynamic> json) => _AppState(
  isFirstLaunch: json['isFirstLaunch'] as bool? ?? true,
  hasNotificationEnabled: json['hasNotificationEnabled'] as bool? ?? false,
  hasAutoSyncEnabled: json['hasAutoSyncEnabled'] as bool? ?? false,
  themeMode:
      $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']) ??
      ThemeMode.system,
  languageCode:
      $enumDecodeNullable(_$LanguageCodeEnumMap, json['languageCode']) ??
      LanguageCode.ko,
  lastActiveDate: json['lastActiveDate'] == null
      ? null
      : DateTime.parse(json['lastActiveDate'] as String),
  firstLaunchedDate: json['firstLaunchedDate'] == null
      ? null
      : DateTime.parse(json['firstLaunchedDate'] as String),
  aiPersonality:
      $enumDecodeNullable(_$AiPersonalityEnumMap, json['aiPersonality']) ??
      AiPersonality.balanced,
  nickname: json['nickname'] as String? ?? '',
);

Map<String, dynamic> _$AppStateToJson(_AppState instance) => <String, dynamic>{
  'isFirstLaunch': instance.isFirstLaunch,
  'hasNotificationEnabled': instance.hasNotificationEnabled,
  'hasAutoSyncEnabled': instance.hasAutoSyncEnabled,
  'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
  'languageCode': _$LanguageCodeEnumMap[instance.languageCode]!,
  'lastActiveDate': instance.lastActiveDate?.toIso8601String(),
  'firstLaunchedDate': instance.firstLaunchedDate?.toIso8601String(),
  'aiPersonality': _$AiPersonalityEnumMap[instance.aiPersonality]!,
  'nickname': instance.nickname,
};

const _$ThemeModeEnumMap = {
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
  ThemeMode.system: 'system',
};

const _$LanguageCodeEnumMap = {LanguageCode.ko: 'ko', LanguageCode.en: 'en'};

const _$AiPersonalityEnumMap = {
  AiPersonality.rational: 'rational',
  AiPersonality.balanced: 'balanced',
  AiPersonality.compassionate: 'compassionate',
};
