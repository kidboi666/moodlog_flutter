// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Settings {

 bool get hasNotificationEnabled; bool get hasAutoSyncEnabled; ThemeMode get themeMode; ColorTheme get colorTheme; LanguageCode get languageCode; AiPersonality get aiPersonality; FontFamily get fontFamily; List<String>? get onboardedLoginTypes;
/// Create a copy of Settings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsCopyWith<Settings> get copyWith => _$SettingsCopyWithImpl<Settings>(this as Settings, _$identity);

  /// Serializes this Settings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Settings&&(identical(other.hasNotificationEnabled, hasNotificationEnabled) || other.hasNotificationEnabled == hasNotificationEnabled)&&(identical(other.hasAutoSyncEnabled, hasAutoSyncEnabled) || other.hasAutoSyncEnabled == hasAutoSyncEnabled)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.colorTheme, colorTheme) || other.colorTheme == colorTheme)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.aiPersonality, aiPersonality) || other.aiPersonality == aiPersonality)&&(identical(other.fontFamily, fontFamily) || other.fontFamily == fontFamily)&&const DeepCollectionEquality().equals(other.onboardedLoginTypes, onboardedLoginTypes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasNotificationEnabled,hasAutoSyncEnabled,themeMode,colorTheme,languageCode,aiPersonality,fontFamily,const DeepCollectionEquality().hash(onboardedLoginTypes));

@override
String toString() {
  return 'Settings(hasNotificationEnabled: $hasNotificationEnabled, hasAutoSyncEnabled: $hasAutoSyncEnabled, themeMode: $themeMode, colorTheme: $colorTheme, languageCode: $languageCode, aiPersonality: $aiPersonality, fontFamily: $fontFamily, onboardedLoginTypes: $onboardedLoginTypes)';
}


}

/// @nodoc
abstract mixin class $SettingsCopyWith<$Res>  {
  factory $SettingsCopyWith(Settings value, $Res Function(Settings) _then) = _$SettingsCopyWithImpl;
@useResult
$Res call({
 bool hasNotificationEnabled, bool hasAutoSyncEnabled, ThemeMode themeMode, ColorTheme colorTheme, LanguageCode languageCode, AiPersonality aiPersonality, FontFamily fontFamily, List<String>? onboardedLoginTypes
});




}
/// @nodoc
class _$SettingsCopyWithImpl<$Res>
    implements $SettingsCopyWith<$Res> {
  _$SettingsCopyWithImpl(this._self, this._then);

  final Settings _self;
  final $Res Function(Settings) _then;

/// Create a copy of Settings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hasNotificationEnabled = null,Object? hasAutoSyncEnabled = null,Object? themeMode = null,Object? colorTheme = null,Object? languageCode = null,Object? aiPersonality = null,Object? fontFamily = null,Object? onboardedLoginTypes = freezed,}) {
  return _then(_self.copyWith(
hasNotificationEnabled: null == hasNotificationEnabled ? _self.hasNotificationEnabled : hasNotificationEnabled // ignore: cast_nullable_to_non_nullable
as bool,hasAutoSyncEnabled: null == hasAutoSyncEnabled ? _self.hasAutoSyncEnabled : hasAutoSyncEnabled // ignore: cast_nullable_to_non_nullable
as bool,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,colorTheme: null == colorTheme ? _self.colorTheme : colorTheme // ignore: cast_nullable_to_non_nullable
as ColorTheme,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as LanguageCode,aiPersonality: null == aiPersonality ? _self.aiPersonality : aiPersonality // ignore: cast_nullable_to_non_nullable
as AiPersonality,fontFamily: null == fontFamily ? _self.fontFamily : fontFamily // ignore: cast_nullable_to_non_nullable
as FontFamily,onboardedLoginTypes: freezed == onboardedLoginTypes ? _self.onboardedLoginTypes : onboardedLoginTypes // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Settings extends Settings {
  const _Settings({this.hasNotificationEnabled = false, this.hasAutoSyncEnabled = false, this.themeMode = ThemeMode.system, this.colorTheme = ColorTheme.blue, this.languageCode = LanguageCode.ko, this.aiPersonality = AiPersonality.balanced, this.fontFamily = FontFamily.pretendard, final  List<String>? onboardedLoginTypes}): _onboardedLoginTypes = onboardedLoginTypes,super._();
  factory _Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);

@override@JsonKey() final  bool hasNotificationEnabled;
@override@JsonKey() final  bool hasAutoSyncEnabled;
@override@JsonKey() final  ThemeMode themeMode;
@override@JsonKey() final  ColorTheme colorTheme;
@override@JsonKey() final  LanguageCode languageCode;
@override@JsonKey() final  AiPersonality aiPersonality;
@override@JsonKey() final  FontFamily fontFamily;
 final  List<String>? _onboardedLoginTypes;
@override List<String>? get onboardedLoginTypes {
  final value = _onboardedLoginTypes;
  if (value == null) return null;
  if (_onboardedLoginTypes is EqualUnmodifiableListView) return _onboardedLoginTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of Settings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsCopyWith<_Settings> get copyWith => __$SettingsCopyWithImpl<_Settings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Settings&&(identical(other.hasNotificationEnabled, hasNotificationEnabled) || other.hasNotificationEnabled == hasNotificationEnabled)&&(identical(other.hasAutoSyncEnabled, hasAutoSyncEnabled) || other.hasAutoSyncEnabled == hasAutoSyncEnabled)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.colorTheme, colorTheme) || other.colorTheme == colorTheme)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.aiPersonality, aiPersonality) || other.aiPersonality == aiPersonality)&&(identical(other.fontFamily, fontFamily) || other.fontFamily == fontFamily)&&const DeepCollectionEquality().equals(other._onboardedLoginTypes, _onboardedLoginTypes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasNotificationEnabled,hasAutoSyncEnabled,themeMode,colorTheme,languageCode,aiPersonality,fontFamily,const DeepCollectionEquality().hash(_onboardedLoginTypes));

@override
String toString() {
  return 'Settings(hasNotificationEnabled: $hasNotificationEnabled, hasAutoSyncEnabled: $hasAutoSyncEnabled, themeMode: $themeMode, colorTheme: $colorTheme, languageCode: $languageCode, aiPersonality: $aiPersonality, fontFamily: $fontFamily, onboardedLoginTypes: $onboardedLoginTypes)';
}


}

/// @nodoc
abstract mixin class _$SettingsCopyWith<$Res> implements $SettingsCopyWith<$Res> {
  factory _$SettingsCopyWith(_Settings value, $Res Function(_Settings) _then) = __$SettingsCopyWithImpl;
@override @useResult
$Res call({
 bool hasNotificationEnabled, bool hasAutoSyncEnabled, ThemeMode themeMode, ColorTheme colorTheme, LanguageCode languageCode, AiPersonality aiPersonality, FontFamily fontFamily, List<String>? onboardedLoginTypes
});




}
/// @nodoc
class __$SettingsCopyWithImpl<$Res>
    implements _$SettingsCopyWith<$Res> {
  __$SettingsCopyWithImpl(this._self, this._then);

  final _Settings _self;
  final $Res Function(_Settings) _then;

/// Create a copy of Settings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hasNotificationEnabled = null,Object? hasAutoSyncEnabled = null,Object? themeMode = null,Object? colorTheme = null,Object? languageCode = null,Object? aiPersonality = null,Object? fontFamily = null,Object? onboardedLoginTypes = freezed,}) {
  return _then(_Settings(
hasNotificationEnabled: null == hasNotificationEnabled ? _self.hasNotificationEnabled : hasNotificationEnabled // ignore: cast_nullable_to_non_nullable
as bool,hasAutoSyncEnabled: null == hasAutoSyncEnabled ? _self.hasAutoSyncEnabled : hasAutoSyncEnabled // ignore: cast_nullable_to_non_nullable
as bool,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,colorTheme: null == colorTheme ? _self.colorTheme : colorTheme // ignore: cast_nullable_to_non_nullable
as ColorTheme,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as LanguageCode,aiPersonality: null == aiPersonality ? _self.aiPersonality : aiPersonality // ignore: cast_nullable_to_non_nullable
as AiPersonality,fontFamily: null == fontFamily ? _self.fontFamily : fontFamily // ignore: cast_nullable_to_non_nullable
as FontFamily,onboardedLoginTypes: freezed == onboardedLoginTypes ? _self._onboardedLoginTypes : onboardedLoginTypes // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
