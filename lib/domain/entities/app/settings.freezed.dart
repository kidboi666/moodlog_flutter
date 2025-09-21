// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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

 bool get hasNotificationEnabled; bool get hasAutoSyncEnabled; ThemeMode get themeMode; ColorTheme get colorTheme; LanguageCode get languageCode; AiPersonality get aiPersonality; FontFamily get fontFamily; SimpleTextAlign get textAlign; bool get isOnboardingComplete;
/// Create a copy of Settings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsCopyWith<Settings> get copyWith => _$SettingsCopyWithImpl<Settings>(this as Settings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Settings&&(identical(other.hasNotificationEnabled, hasNotificationEnabled) || other.hasNotificationEnabled == hasNotificationEnabled)&&(identical(other.hasAutoSyncEnabled, hasAutoSyncEnabled) || other.hasAutoSyncEnabled == hasAutoSyncEnabled)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.colorTheme, colorTheme) || other.colorTheme == colorTheme)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.aiPersonality, aiPersonality) || other.aiPersonality == aiPersonality)&&(identical(other.fontFamily, fontFamily) || other.fontFamily == fontFamily)&&(identical(other.textAlign, textAlign) || other.textAlign == textAlign)&&(identical(other.isOnboardingComplete, isOnboardingComplete) || other.isOnboardingComplete == isOnboardingComplete));
}


@override
int get hashCode => Object.hash(runtimeType,hasNotificationEnabled,hasAutoSyncEnabled,themeMode,colorTheme,languageCode,aiPersonality,fontFamily,textAlign,isOnboardingComplete);

@override
String toString() {
  return 'Settings(hasNotificationEnabled: $hasNotificationEnabled, hasAutoSyncEnabled: $hasAutoSyncEnabled, themeMode: $themeMode, colorTheme: $colorTheme, languageCode: $languageCode, aiPersonality: $aiPersonality, fontFamily: $fontFamily, textAlign: $textAlign, isOnboardingComplete: $isOnboardingComplete)';
}


}

/// @nodoc
abstract mixin class $SettingsCopyWith<$Res>  {
  factory $SettingsCopyWith(Settings value, $Res Function(Settings) _then) = _$SettingsCopyWithImpl;
@useResult
$Res call({
 bool hasNotificationEnabled, bool hasAutoSyncEnabled, ThemeMode themeMode, ColorTheme colorTheme, LanguageCode languageCode, AiPersonality aiPersonality, FontFamily fontFamily, SimpleTextAlign textAlign, bool isOnboardingComplete
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
@pragma('vm:prefer-inline') @override $Res call({Object? hasNotificationEnabled = null,Object? hasAutoSyncEnabled = null,Object? themeMode = null,Object? colorTheme = null,Object? languageCode = null,Object? aiPersonality = null,Object? fontFamily = null,Object? textAlign = null,Object? isOnboardingComplete = null,}) {
  return _then(_self.copyWith(
hasNotificationEnabled: null == hasNotificationEnabled ? _self.hasNotificationEnabled : hasNotificationEnabled // ignore: cast_nullable_to_non_nullable
as bool,hasAutoSyncEnabled: null == hasAutoSyncEnabled ? _self.hasAutoSyncEnabled : hasAutoSyncEnabled // ignore: cast_nullable_to_non_nullable
as bool,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,colorTheme: null == colorTheme ? _self.colorTheme : colorTheme // ignore: cast_nullable_to_non_nullable
as ColorTheme,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as LanguageCode,aiPersonality: null == aiPersonality ? _self.aiPersonality : aiPersonality // ignore: cast_nullable_to_non_nullable
as AiPersonality,fontFamily: null == fontFamily ? _self.fontFamily : fontFamily // ignore: cast_nullable_to_non_nullable
as FontFamily,textAlign: null == textAlign ? _self.textAlign : textAlign // ignore: cast_nullable_to_non_nullable
as SimpleTextAlign,isOnboardingComplete: null == isOnboardingComplete ? _self.isOnboardingComplete : isOnboardingComplete // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Settings].
extension SettingsPatterns on Settings {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Settings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Settings() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Settings value)  $default,){
final _that = this;
switch (_that) {
case _Settings():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Settings value)?  $default,){
final _that = this;
switch (_that) {
case _Settings() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool hasNotificationEnabled,  bool hasAutoSyncEnabled,  ThemeMode themeMode,  ColorTheme colorTheme,  LanguageCode languageCode,  AiPersonality aiPersonality,  FontFamily fontFamily,  SimpleTextAlign textAlign,  bool isOnboardingComplete)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Settings() when $default != null:
return $default(_that.hasNotificationEnabled,_that.hasAutoSyncEnabled,_that.themeMode,_that.colorTheme,_that.languageCode,_that.aiPersonality,_that.fontFamily,_that.textAlign,_that.isOnboardingComplete);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool hasNotificationEnabled,  bool hasAutoSyncEnabled,  ThemeMode themeMode,  ColorTheme colorTheme,  LanguageCode languageCode,  AiPersonality aiPersonality,  FontFamily fontFamily,  SimpleTextAlign textAlign,  bool isOnboardingComplete)  $default,) {final _that = this;
switch (_that) {
case _Settings():
return $default(_that.hasNotificationEnabled,_that.hasAutoSyncEnabled,_that.themeMode,_that.colorTheme,_that.languageCode,_that.aiPersonality,_that.fontFamily,_that.textAlign,_that.isOnboardingComplete);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool hasNotificationEnabled,  bool hasAutoSyncEnabled,  ThemeMode themeMode,  ColorTheme colorTheme,  LanguageCode languageCode,  AiPersonality aiPersonality,  FontFamily fontFamily,  SimpleTextAlign textAlign,  bool isOnboardingComplete)?  $default,) {final _that = this;
switch (_that) {
case _Settings() when $default != null:
return $default(_that.hasNotificationEnabled,_that.hasAutoSyncEnabled,_that.themeMode,_that.colorTheme,_that.languageCode,_that.aiPersonality,_that.fontFamily,_that.textAlign,_that.isOnboardingComplete);case _:
  return null;

}
}

}

/// @nodoc


class _Settings extends Settings {
  const _Settings({this.hasNotificationEnabled = false, this.hasAutoSyncEnabled = false, this.themeMode = ThemeMode.system, this.colorTheme = ColorTheme.blue, this.languageCode = LanguageCode.ko, this.aiPersonality = AiPersonality.balanced, this.fontFamily = FontFamily.restart, this.textAlign = SimpleTextAlign.left, this.isOnboardingComplete = false}): super._();
  

@override@JsonKey() final  bool hasNotificationEnabled;
@override@JsonKey() final  bool hasAutoSyncEnabled;
@override@JsonKey() final  ThemeMode themeMode;
@override@JsonKey() final  ColorTheme colorTheme;
@override@JsonKey() final  LanguageCode languageCode;
@override@JsonKey() final  AiPersonality aiPersonality;
@override@JsonKey() final  FontFamily fontFamily;
@override@JsonKey() final  SimpleTextAlign textAlign;
@override@JsonKey() final  bool isOnboardingComplete;

/// Create a copy of Settings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsCopyWith<_Settings> get copyWith => __$SettingsCopyWithImpl<_Settings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Settings&&(identical(other.hasNotificationEnabled, hasNotificationEnabled) || other.hasNotificationEnabled == hasNotificationEnabled)&&(identical(other.hasAutoSyncEnabled, hasAutoSyncEnabled) || other.hasAutoSyncEnabled == hasAutoSyncEnabled)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.colorTheme, colorTheme) || other.colorTheme == colorTheme)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.aiPersonality, aiPersonality) || other.aiPersonality == aiPersonality)&&(identical(other.fontFamily, fontFamily) || other.fontFamily == fontFamily)&&(identical(other.textAlign, textAlign) || other.textAlign == textAlign)&&(identical(other.isOnboardingComplete, isOnboardingComplete) || other.isOnboardingComplete == isOnboardingComplete));
}


@override
int get hashCode => Object.hash(runtimeType,hasNotificationEnabled,hasAutoSyncEnabled,themeMode,colorTheme,languageCode,aiPersonality,fontFamily,textAlign,isOnboardingComplete);

@override
String toString() {
  return 'Settings(hasNotificationEnabled: $hasNotificationEnabled, hasAutoSyncEnabled: $hasAutoSyncEnabled, themeMode: $themeMode, colorTheme: $colorTheme, languageCode: $languageCode, aiPersonality: $aiPersonality, fontFamily: $fontFamily, textAlign: $textAlign, isOnboardingComplete: $isOnboardingComplete)';
}


}

/// @nodoc
abstract mixin class _$SettingsCopyWith<$Res> implements $SettingsCopyWith<$Res> {
  factory _$SettingsCopyWith(_Settings value, $Res Function(_Settings) _then) = __$SettingsCopyWithImpl;
@override @useResult
$Res call({
 bool hasNotificationEnabled, bool hasAutoSyncEnabled, ThemeMode themeMode, ColorTheme colorTheme, LanguageCode languageCode, AiPersonality aiPersonality, FontFamily fontFamily, SimpleTextAlign textAlign, bool isOnboardingComplete
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
@override @pragma('vm:prefer-inline') $Res call({Object? hasNotificationEnabled = null,Object? hasAutoSyncEnabled = null,Object? themeMode = null,Object? colorTheme = null,Object? languageCode = null,Object? aiPersonality = null,Object? fontFamily = null,Object? textAlign = null,Object? isOnboardingComplete = null,}) {
  return _then(_Settings(
hasNotificationEnabled: null == hasNotificationEnabled ? _self.hasNotificationEnabled : hasNotificationEnabled // ignore: cast_nullable_to_non_nullable
as bool,hasAutoSyncEnabled: null == hasAutoSyncEnabled ? _self.hasAutoSyncEnabled : hasAutoSyncEnabled // ignore: cast_nullable_to_non_nullable
as bool,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,colorTheme: null == colorTheme ? _self.colorTheme : colorTheme // ignore: cast_nullable_to_non_nullable
as ColorTheme,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as LanguageCode,aiPersonality: null == aiPersonality ? _self.aiPersonality : aiPersonality // ignore: cast_nullable_to_non_nullable
as AiPersonality,fontFamily: null == fontFamily ? _self.fontFamily : fontFamily // ignore: cast_nullable_to_non_nullable
as FontFamily,textAlign: null == textAlign ? _self.textAlign : textAlign // ignore: cast_nullable_to_non_nullable
as SimpleTextAlign,isOnboardingComplete: null == isOnboardingComplete ? _self.isOnboardingComplete : isOnboardingComplete // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
