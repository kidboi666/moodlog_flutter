// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
  hasNotificationEnabled: json['hasNotificationEnabled'] as bool? ?? false,
  hasAutoSyncEnabled: json['hasAutoSyncEnabled'] as bool? ?? false,
  themeMode:
      $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']) ??
      ThemeMode.system,
  colorTheme:
      $enumDecodeNullable(_$ColorThemeEnumMap, json['colorTheme']) ??
      ColorTheme.blue,
  languageCode:
      $enumDecodeNullable(_$LanguageCodeEnumMap, json['languageCode']) ??
      LanguageCode.ko,
  aiPersonality:
      $enumDecodeNullable(_$AiPersonalityEnumMap, json['aiPersonality']) ??
      AiPersonality.balanced,
  fontFamily:
      $enumDecodeNullable(_$FontFamilyEnumMap, json['fontFamily']) ??
      FontFamily.restart,
  textAlign:
      $enumDecodeNullable(_$SimpleTextAlignEnumMap, json['textAlign']) ??
      SimpleTextAlign.left,
  onboardedLoginTypes: (json['onboardedLoginTypes'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$SettingsToJson(_Settings instance) => <String, dynamic>{
  'hasNotificationEnabled': instance.hasNotificationEnabled,
  'hasAutoSyncEnabled': instance.hasAutoSyncEnabled,
  'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
  'colorTheme': _$ColorThemeEnumMap[instance.colorTheme]!,
  'languageCode': _$LanguageCodeEnumMap[instance.languageCode]!,
  'aiPersonality': _$AiPersonalityEnumMap[instance.aiPersonality]!,
  'fontFamily': _$FontFamilyEnumMap[instance.fontFamily]!,
  'textAlign': _$SimpleTextAlignEnumMap[instance.textAlign]!,
  'onboardedLoginTypes': instance.onboardedLoginTypes,
};

const _$ThemeModeEnumMap = {
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
  ThemeMode.system: 'system',
};

const _$ColorThemeEnumMap = {
  ColorTheme.red: 'red',
  ColorTheme.pink: 'pink',
  ColorTheme.purple: 'purple',
  ColorTheme.deepPurple: 'deepPurple',
  ColorTheme.indigo: 'indigo',
  ColorTheme.blue: 'blue',
  ColorTheme.lightBlue: 'lightBlue',
  ColorTheme.cyan: 'cyan',
  ColorTheme.teal: 'teal',
  ColorTheme.green: 'green',
  ColorTheme.lightGreen: 'lightGreen',
  ColorTheme.lime: 'lime',
  ColorTheme.yellow: 'yellow',
  ColorTheme.amber: 'amber',
  ColorTheme.orange: 'orange',
  ColorTheme.deepOrange: 'deepOrange',
  ColorTheme.brown: 'brown',
  ColorTheme.grey: 'grey',
  ColorTheme.blueGrey: 'blueGrey',
};

const _$LanguageCodeEnumMap = {
  LanguageCode.ko: 'ko',
  LanguageCode.en: 'en',
  LanguageCode.ja: 'ja',
};

const _$AiPersonalityEnumMap = {
  AiPersonality.rational: 'rational',
  AiPersonality.balanced: 'balanced',
  AiPersonality.compassionate: 'compassionate',
};

const _$FontFamilyEnumMap = {
  FontFamily.pretendard: 'pretendard',
  FontFamily.leeSeoyun: 'leeSeoyun',
  FontFamily.orbitOfTheMoon: 'orbitOfTheMoon',
  FontFamily.restart: 'restart',
  FontFamily.overcome: 'overcome',
  FontFamily.system: 'system',
};

const _$SimpleTextAlignEnumMap = {
  SimpleTextAlign.left: 'left',
  SimpleTextAlign.center: 'center',
  SimpleTextAlign.right: 'right',
};
