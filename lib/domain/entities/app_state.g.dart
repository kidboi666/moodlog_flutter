// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppState _$AppStateFromJson(Map<String, dynamic> json) => _AppState(
  isFirstLaunch: json['isFirstLaunch'] as bool? ?? true,
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
);

Map<String, dynamic> _$AppStateToJson(_AppState instance) => <String, dynamic>{
  'isFirstLaunch': instance.isFirstLaunch,
  'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
  'languageCode': _$LanguageCodeEnumMap[instance.languageCode]!,
  'lastActiveDate': instance.lastActiveDate?.toIso8601String(),
  'firstLaunchedDate': instance.firstLaunchedDate?.toIso8601String(),
};

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.dark: 'dark',
  ThemeMode.light: 'light',
};

const _$LanguageCodeEnumMap = {LanguageCode.ko: 'ko', LanguageCode.en: 'en'};
