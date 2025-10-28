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

 bool get hasNotificationEnabled; bool get hasAutoSyncEnabled; ThemeMode get themeMode; ColorTheme get colorTheme; LanguageCode get languageCode; FontType get fontType; SimpleTextAlign get textAlign; TimeFormat get timeFormat; bool get isOnboardingComplete; bool get isAppLockEnabled; LockType get lockType; bool get isProUser;
/// Create a copy of Settings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsCopyWith<Settings> get copyWith => _$SettingsCopyWithImpl<Settings>(this as Settings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Settings&&(identical(other.hasNotificationEnabled, hasNotificationEnabled) || other.hasNotificationEnabled == hasNotificationEnabled)&&(identical(other.hasAutoSyncEnabled, hasAutoSyncEnabled) || other.hasAutoSyncEnabled == hasAutoSyncEnabled)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.colorTheme, colorTheme) || other.colorTheme == colorTheme)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.fontType, fontType) || other.fontType == fontType)&&(identical(other.textAlign, textAlign) || other.textAlign == textAlign)&&(identical(other.timeFormat, timeFormat) || other.timeFormat == timeFormat)&&(identical(other.isOnboardingComplete, isOnboardingComplete) || other.isOnboardingComplete == isOnboardingComplete)&&(identical(other.isAppLockEnabled, isAppLockEnabled) || other.isAppLockEnabled == isAppLockEnabled)&&(identical(other.lockType, lockType) || other.lockType == lockType)&&(identical(other.isProUser, isProUser) || other.isProUser == isProUser));
}


@override
int get hashCode => Object.hash(runtimeType,hasNotificationEnabled,hasAutoSyncEnabled,themeMode,colorTheme,languageCode,fontType,textAlign,timeFormat,isOnboardingComplete,isAppLockEnabled,lockType,isProUser);

@override
String toString() {
  return 'Settings(hasNotificationEnabled: $hasNotificationEnabled, hasAutoSyncEnabled: $hasAutoSyncEnabled, themeMode: $themeMode, colorTheme: $colorTheme, languageCode: $languageCode, fontType: $fontType, textAlign: $textAlign, timeFormat: $timeFormat, isOnboardingComplete: $isOnboardingComplete, isAppLockEnabled: $isAppLockEnabled, lockType: $lockType, isProUser: $isProUser)';
}


}

/// @nodoc
abstract mixin class $SettingsCopyWith<$Res>  {
  factory $SettingsCopyWith(Settings value, $Res Function(Settings) _then) = _$SettingsCopyWithImpl;
@useResult
$Res call({
 bool hasNotificationEnabled, bool hasAutoSyncEnabled, ThemeMode themeMode, ColorTheme colorTheme, LanguageCode languageCode, FontType fontType, SimpleTextAlign textAlign, TimeFormat timeFormat, bool isOnboardingComplete, bool isAppLockEnabled, LockType lockType, bool isProUser
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
@pragma('vm:prefer-inline') @override $Res call({Object? hasNotificationEnabled = null,Object? hasAutoSyncEnabled = null,Object? themeMode = null,Object? colorTheme = null,Object? languageCode = null,Object? fontType = null,Object? textAlign = null,Object? timeFormat = null,Object? isOnboardingComplete = null,Object? isAppLockEnabled = null,Object? lockType = null,Object? isProUser = null,}) {
  return _then(_self.copyWith(
hasNotificationEnabled: null == hasNotificationEnabled ? _self.hasNotificationEnabled : hasNotificationEnabled // ignore: cast_nullable_to_non_nullable
as bool,hasAutoSyncEnabled: null == hasAutoSyncEnabled ? _self.hasAutoSyncEnabled : hasAutoSyncEnabled // ignore: cast_nullable_to_non_nullable
as bool,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,colorTheme: null == colorTheme ? _self.colorTheme : colorTheme // ignore: cast_nullable_to_non_nullable
as ColorTheme,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as LanguageCode,fontType: null == fontType ? _self.fontType : fontType // ignore: cast_nullable_to_non_nullable
as FontType,textAlign: null == textAlign ? _self.textAlign : textAlign // ignore: cast_nullable_to_non_nullable
as SimpleTextAlign,timeFormat: null == timeFormat ? _self.timeFormat : timeFormat // ignore: cast_nullable_to_non_nullable
as TimeFormat,isOnboardingComplete: null == isOnboardingComplete ? _self.isOnboardingComplete : isOnboardingComplete // ignore: cast_nullable_to_non_nullable
as bool,isAppLockEnabled: null == isAppLockEnabled ? _self.isAppLockEnabled : isAppLockEnabled // ignore: cast_nullable_to_non_nullable
as bool,lockType: null == lockType ? _self.lockType : lockType // ignore: cast_nullable_to_non_nullable
as LockType,isProUser: null == isProUser ? _self.isProUser : isProUser // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool hasNotificationEnabled,  bool hasAutoSyncEnabled,  ThemeMode themeMode,  ColorTheme colorTheme,  LanguageCode languageCode,  FontType fontType,  SimpleTextAlign textAlign,  TimeFormat timeFormat,  bool isOnboardingComplete,  bool isAppLockEnabled,  LockType lockType,  bool isProUser)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Settings() when $default != null:
return $default(_that.hasNotificationEnabled,_that.hasAutoSyncEnabled,_that.themeMode,_that.colorTheme,_that.languageCode,_that.fontType,_that.textAlign,_that.timeFormat,_that.isOnboardingComplete,_that.isAppLockEnabled,_that.lockType,_that.isProUser);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool hasNotificationEnabled,  bool hasAutoSyncEnabled,  ThemeMode themeMode,  ColorTheme colorTheme,  LanguageCode languageCode,  FontType fontType,  SimpleTextAlign textAlign,  TimeFormat timeFormat,  bool isOnboardingComplete,  bool isAppLockEnabled,  LockType lockType,  bool isProUser)  $default,) {final _that = this;
switch (_that) {
case _Settings():
return $default(_that.hasNotificationEnabled,_that.hasAutoSyncEnabled,_that.themeMode,_that.colorTheme,_that.languageCode,_that.fontType,_that.textAlign,_that.timeFormat,_that.isOnboardingComplete,_that.isAppLockEnabled,_that.lockType,_that.isProUser);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool hasNotificationEnabled,  bool hasAutoSyncEnabled,  ThemeMode themeMode,  ColorTheme colorTheme,  LanguageCode languageCode,  FontType fontType,  SimpleTextAlign textAlign,  TimeFormat timeFormat,  bool isOnboardingComplete,  bool isAppLockEnabled,  LockType lockType,  bool isProUser)?  $default,) {final _that = this;
switch (_that) {
case _Settings() when $default != null:
return $default(_that.hasNotificationEnabled,_that.hasAutoSyncEnabled,_that.themeMode,_that.colorTheme,_that.languageCode,_that.fontType,_that.textAlign,_that.timeFormat,_that.isOnboardingComplete,_that.isAppLockEnabled,_that.lockType,_that.isProUser);case _:
  return null;

}
}

}

/// @nodoc


class _Settings extends Settings {
  const _Settings({this.hasNotificationEnabled = false, this.hasAutoSyncEnabled = false, this.themeMode = ThemeMode.system, this.colorTheme = ColorTheme.blue, this.languageCode = LanguageCode.ko, this.fontType = LocalFont.pretendard, this.textAlign = SimpleTextAlign.left, this.timeFormat = TimeFormat.hour24, this.isOnboardingComplete = false, this.isAppLockEnabled = false, this.lockType = LockType.none, this.isProUser = false}): super._();
  

@override@JsonKey() final  bool hasNotificationEnabled;
@override@JsonKey() final  bool hasAutoSyncEnabled;
@override@JsonKey() final  ThemeMode themeMode;
@override@JsonKey() final  ColorTheme colorTheme;
@override@JsonKey() final  LanguageCode languageCode;
@override@JsonKey() final  FontType fontType;
@override@JsonKey() final  SimpleTextAlign textAlign;
@override@JsonKey() final  TimeFormat timeFormat;
@override@JsonKey() final  bool isOnboardingComplete;
@override@JsonKey() final  bool isAppLockEnabled;
@override@JsonKey() final  LockType lockType;
@override@JsonKey() final  bool isProUser;

/// Create a copy of Settings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsCopyWith<_Settings> get copyWith => __$SettingsCopyWithImpl<_Settings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Settings&&(identical(other.hasNotificationEnabled, hasNotificationEnabled) || other.hasNotificationEnabled == hasNotificationEnabled)&&(identical(other.hasAutoSyncEnabled, hasAutoSyncEnabled) || other.hasAutoSyncEnabled == hasAutoSyncEnabled)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.colorTheme, colorTheme) || other.colorTheme == colorTheme)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.fontType, fontType) || other.fontType == fontType)&&(identical(other.textAlign, textAlign) || other.textAlign == textAlign)&&(identical(other.timeFormat, timeFormat) || other.timeFormat == timeFormat)&&(identical(other.isOnboardingComplete, isOnboardingComplete) || other.isOnboardingComplete == isOnboardingComplete)&&(identical(other.isAppLockEnabled, isAppLockEnabled) || other.isAppLockEnabled == isAppLockEnabled)&&(identical(other.lockType, lockType) || other.lockType == lockType)&&(identical(other.isProUser, isProUser) || other.isProUser == isProUser));
}


@override
int get hashCode => Object.hash(runtimeType,hasNotificationEnabled,hasAutoSyncEnabled,themeMode,colorTheme,languageCode,fontType,textAlign,timeFormat,isOnboardingComplete,isAppLockEnabled,lockType,isProUser);

@override
String toString() {
  return 'Settings(hasNotificationEnabled: $hasNotificationEnabled, hasAutoSyncEnabled: $hasAutoSyncEnabled, themeMode: $themeMode, colorTheme: $colorTheme, languageCode: $languageCode, fontType: $fontType, textAlign: $textAlign, timeFormat: $timeFormat, isOnboardingComplete: $isOnboardingComplete, isAppLockEnabled: $isAppLockEnabled, lockType: $lockType, isProUser: $isProUser)';
}


}

/// @nodoc
abstract mixin class _$SettingsCopyWith<$Res> implements $SettingsCopyWith<$Res> {
  factory _$SettingsCopyWith(_Settings value, $Res Function(_Settings) _then) = __$SettingsCopyWithImpl;
@override @useResult
$Res call({
 bool hasNotificationEnabled, bool hasAutoSyncEnabled, ThemeMode themeMode, ColorTheme colorTheme, LanguageCode languageCode, FontType fontType, SimpleTextAlign textAlign, TimeFormat timeFormat, bool isOnboardingComplete, bool isAppLockEnabled, LockType lockType, bool isProUser
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
@override @pragma('vm:prefer-inline') $Res call({Object? hasNotificationEnabled = null,Object? hasAutoSyncEnabled = null,Object? themeMode = null,Object? colorTheme = null,Object? languageCode = null,Object? fontType = null,Object? textAlign = null,Object? timeFormat = null,Object? isOnboardingComplete = null,Object? isAppLockEnabled = null,Object? lockType = null,Object? isProUser = null,}) {
  return _then(_Settings(
hasNotificationEnabled: null == hasNotificationEnabled ? _self.hasNotificationEnabled : hasNotificationEnabled // ignore: cast_nullable_to_non_nullable
as bool,hasAutoSyncEnabled: null == hasAutoSyncEnabled ? _self.hasAutoSyncEnabled : hasAutoSyncEnabled // ignore: cast_nullable_to_non_nullable
as bool,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,colorTheme: null == colorTheme ? _self.colorTheme : colorTheme // ignore: cast_nullable_to_non_nullable
as ColorTheme,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as LanguageCode,fontType: null == fontType ? _self.fontType : fontType // ignore: cast_nullable_to_non_nullable
as FontType,textAlign: null == textAlign ? _self.textAlign : textAlign // ignore: cast_nullable_to_non_nullable
as SimpleTextAlign,timeFormat: null == timeFormat ? _self.timeFormat : timeFormat // ignore: cast_nullable_to_non_nullable
as TimeFormat,isOnboardingComplete: null == isOnboardingComplete ? _self.isOnboardingComplete : isOnboardingComplete // ignore: cast_nullable_to_non_nullable
as bool,isAppLockEnabled: null == isAppLockEnabled ? _self.isAppLockEnabled : isAppLockEnabled // ignore: cast_nullable_to_non_nullable
as bool,lockType: null == lockType ? _self.lockType : lockType // ignore: cast_nullable_to_non_nullable
as LockType,isProUser: null == isProUser ? _self.isProUser : isProUser // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
