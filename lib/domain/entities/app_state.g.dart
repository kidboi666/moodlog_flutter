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
  colorTheme:
      $enumDecodeNullable(_$ColorThemeEnumMap, json['colorTheme']) ??
      ColorTheme.teal,
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
  fontFamily:
      $enumDecodeNullable(_$FontFamilyEnumMap, json['fontFamily']) ??
      FontFamily.pretendard,
);

Map<String, dynamic> _$AppStateToJson(_AppState instance) => <String, dynamic>{
  'isFirstLaunch': instance.isFirstLaunch,
  'hasNotificationEnabled': instance.hasNotificationEnabled,
  'hasAutoSyncEnabled': instance.hasAutoSyncEnabled,
  'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
  'colorTheme': _$ColorThemeEnumMap[instance.colorTheme]!,
  'languageCode': _$LanguageCodeEnumMap[instance.languageCode]!,
  'lastActiveDate': instance.lastActiveDate?.toIso8601String(),
  'firstLaunchedDate': instance.firstLaunchedDate?.toIso8601String(),
  'aiPersonality': _$AiPersonalityEnumMap[instance.aiPersonality]!,
  'nickname': instance.nickname,
  'fontFamily': _$FontFamilyEnumMap[instance.fontFamily]!,
};

const _$ThemeModeEnumMap = {
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
  ThemeMode.system: 'system',
};

const _$ColorThemeEnumMap = {
  ColorTheme.teal: 'teal',
  ColorTheme.blue: 'blue',
  ColorTheme.purple: 'purple',
  ColorTheme.green: 'green',
  ColorTheme.orange: 'orange',
  ColorTheme.pink: 'pink',
};

const _$LanguageCodeEnumMap = {LanguageCode.ko: 'ko', LanguageCode.en: 'en'};

const _$AiPersonalityEnumMap = {
  AiPersonality.rational: 'rational',
  AiPersonality.balanced: 'balanced',
  AiPersonality.compassionate: 'compassionate',
};

const _$FontFamilyEnumMap = {
  FontFamily.pretendard: 'pretendard',
  FontFamily.leeSeoyun: 'leeSeoyun',
};
