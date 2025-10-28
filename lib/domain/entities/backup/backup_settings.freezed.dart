// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backup_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BackupSettings {

 bool get hasNotificationEnabled; bool get hasAutoSyncEnabled; String get themeMode; String get colorTheme; String get languageCode; String get fontType; String get textAlign; bool get isOnboardingComplete; bool get isAppLockEnabled; String get lockType; bool get isProUser;
/// Create a copy of BackupSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackupSettingsCopyWith<BackupSettings> get copyWith => _$BackupSettingsCopyWithImpl<BackupSettings>(this as BackupSettings, _$identity);

  /// Serializes this BackupSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupSettings&&(identical(other.hasNotificationEnabled, hasNotificationEnabled) || other.hasNotificationEnabled == hasNotificationEnabled)&&(identical(other.hasAutoSyncEnabled, hasAutoSyncEnabled) || other.hasAutoSyncEnabled == hasAutoSyncEnabled)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.colorTheme, colorTheme) || other.colorTheme == colorTheme)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.fontType, fontType) || other.fontType == fontType)&&(identical(other.textAlign, textAlign) || other.textAlign == textAlign)&&(identical(other.isOnboardingComplete, isOnboardingComplete) || other.isOnboardingComplete == isOnboardingComplete)&&(identical(other.isAppLockEnabled, isAppLockEnabled) || other.isAppLockEnabled == isAppLockEnabled)&&(identical(other.lockType, lockType) || other.lockType == lockType)&&(identical(other.isProUser, isProUser) || other.isProUser == isProUser));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasNotificationEnabled,hasAutoSyncEnabled,themeMode,colorTheme,languageCode,fontType,textAlign,isOnboardingComplete,isAppLockEnabled,lockType,isProUser);

@override
String toString() {
  return 'BackupSettings(hasNotificationEnabled: $hasNotificationEnabled, hasAutoSyncEnabled: $hasAutoSyncEnabled, themeMode: $themeMode, colorTheme: $colorTheme, languageCode: $languageCode, fontType: $fontType, textAlign: $textAlign, isOnboardingComplete: $isOnboardingComplete, isAppLockEnabled: $isAppLockEnabled, lockType: $lockType, isProUser: $isProUser)';
}


}

/// @nodoc
abstract mixin class $BackupSettingsCopyWith<$Res>  {
  factory $BackupSettingsCopyWith(BackupSettings value, $Res Function(BackupSettings) _then) = _$BackupSettingsCopyWithImpl;
@useResult
$Res call({
 bool hasNotificationEnabled, bool hasAutoSyncEnabled, String themeMode, String colorTheme, String languageCode, String fontType, String textAlign, bool isOnboardingComplete, bool isAppLockEnabled, String lockType, bool isProUser
});




}
/// @nodoc
class _$BackupSettingsCopyWithImpl<$Res>
    implements $BackupSettingsCopyWith<$Res> {
  _$BackupSettingsCopyWithImpl(this._self, this._then);

  final BackupSettings _self;
  final $Res Function(BackupSettings) _then;

/// Create a copy of BackupSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hasNotificationEnabled = null,Object? hasAutoSyncEnabled = null,Object? themeMode = null,Object? colorTheme = null,Object? languageCode = null,Object? fontType = null,Object? textAlign = null,Object? isOnboardingComplete = null,Object? isAppLockEnabled = null,Object? lockType = null,Object? isProUser = null,}) {
  return _then(_self.copyWith(
hasNotificationEnabled: null == hasNotificationEnabled ? _self.hasNotificationEnabled : hasNotificationEnabled // ignore: cast_nullable_to_non_nullable
as bool,hasAutoSyncEnabled: null == hasAutoSyncEnabled ? _self.hasAutoSyncEnabled : hasAutoSyncEnabled // ignore: cast_nullable_to_non_nullable
as bool,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as String,colorTheme: null == colorTheme ? _self.colorTheme : colorTheme // ignore: cast_nullable_to_non_nullable
as String,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,fontType: null == fontType ? _self.fontType : fontType // ignore: cast_nullable_to_non_nullable
as String,textAlign: null == textAlign ? _self.textAlign : textAlign // ignore: cast_nullable_to_non_nullable
as String,isOnboardingComplete: null == isOnboardingComplete ? _self.isOnboardingComplete : isOnboardingComplete // ignore: cast_nullable_to_non_nullable
as bool,isAppLockEnabled: null == isAppLockEnabled ? _self.isAppLockEnabled : isAppLockEnabled // ignore: cast_nullable_to_non_nullable
as bool,lockType: null == lockType ? _self.lockType : lockType // ignore: cast_nullable_to_non_nullable
as String,isProUser: null == isProUser ? _self.isProUser : isProUser // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [BackupSettings].
extension BackupSettingsPatterns on BackupSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BackupSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BackupSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BackupSettings value)  $default,){
final _that = this;
switch (_that) {
case _BackupSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BackupSettings value)?  $default,){
final _that = this;
switch (_that) {
case _BackupSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool hasNotificationEnabled,  bool hasAutoSyncEnabled,  String themeMode,  String colorTheme,  String languageCode,  String fontType,  String textAlign,  bool isOnboardingComplete,  bool isAppLockEnabled,  String lockType,  bool isProUser)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BackupSettings() when $default != null:
return $default(_that.hasNotificationEnabled,_that.hasAutoSyncEnabled,_that.themeMode,_that.colorTheme,_that.languageCode,_that.fontType,_that.textAlign,_that.isOnboardingComplete,_that.isAppLockEnabled,_that.lockType,_that.isProUser);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool hasNotificationEnabled,  bool hasAutoSyncEnabled,  String themeMode,  String colorTheme,  String languageCode,  String fontType,  String textAlign,  bool isOnboardingComplete,  bool isAppLockEnabled,  String lockType,  bool isProUser)  $default,) {final _that = this;
switch (_that) {
case _BackupSettings():
return $default(_that.hasNotificationEnabled,_that.hasAutoSyncEnabled,_that.themeMode,_that.colorTheme,_that.languageCode,_that.fontType,_that.textAlign,_that.isOnboardingComplete,_that.isAppLockEnabled,_that.lockType,_that.isProUser);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool hasNotificationEnabled,  bool hasAutoSyncEnabled,  String themeMode,  String colorTheme,  String languageCode,  String fontType,  String textAlign,  bool isOnboardingComplete,  bool isAppLockEnabled,  String lockType,  bool isProUser)?  $default,) {final _that = this;
switch (_that) {
case _BackupSettings() when $default != null:
return $default(_that.hasNotificationEnabled,_that.hasAutoSyncEnabled,_that.themeMode,_that.colorTheme,_that.languageCode,_that.fontType,_that.textAlign,_that.isOnboardingComplete,_that.isAppLockEnabled,_that.lockType,_that.isProUser);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BackupSettings implements BackupSettings {
  const _BackupSettings({required this.hasNotificationEnabled, required this.hasAutoSyncEnabled, required this.themeMode, required this.colorTheme, required this.languageCode, required this.fontType, required this.textAlign, required this.isOnboardingComplete, required this.isAppLockEnabled, required this.lockType, required this.isProUser});
  factory _BackupSettings.fromJson(Map<String, dynamic> json) => _$BackupSettingsFromJson(json);

@override final  bool hasNotificationEnabled;
@override final  bool hasAutoSyncEnabled;
@override final  String themeMode;
@override final  String colorTheme;
@override final  String languageCode;
@override final  String fontType;
@override final  String textAlign;
@override final  bool isOnboardingComplete;
@override final  bool isAppLockEnabled;
@override final  String lockType;
@override final  bool isProUser;

/// Create a copy of BackupSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BackupSettingsCopyWith<_BackupSettings> get copyWith => __$BackupSettingsCopyWithImpl<_BackupSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BackupSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackupSettings&&(identical(other.hasNotificationEnabled, hasNotificationEnabled) || other.hasNotificationEnabled == hasNotificationEnabled)&&(identical(other.hasAutoSyncEnabled, hasAutoSyncEnabled) || other.hasAutoSyncEnabled == hasAutoSyncEnabled)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.colorTheme, colorTheme) || other.colorTheme == colorTheme)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.fontType, fontType) || other.fontType == fontType)&&(identical(other.textAlign, textAlign) || other.textAlign == textAlign)&&(identical(other.isOnboardingComplete, isOnboardingComplete) || other.isOnboardingComplete == isOnboardingComplete)&&(identical(other.isAppLockEnabled, isAppLockEnabled) || other.isAppLockEnabled == isAppLockEnabled)&&(identical(other.lockType, lockType) || other.lockType == lockType)&&(identical(other.isProUser, isProUser) || other.isProUser == isProUser));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasNotificationEnabled,hasAutoSyncEnabled,themeMode,colorTheme,languageCode,fontType,textAlign,isOnboardingComplete,isAppLockEnabled,lockType,isProUser);

@override
String toString() {
  return 'BackupSettings(hasNotificationEnabled: $hasNotificationEnabled, hasAutoSyncEnabled: $hasAutoSyncEnabled, themeMode: $themeMode, colorTheme: $colorTheme, languageCode: $languageCode, fontType: $fontType, textAlign: $textAlign, isOnboardingComplete: $isOnboardingComplete, isAppLockEnabled: $isAppLockEnabled, lockType: $lockType, isProUser: $isProUser)';
}


}

/// @nodoc
abstract mixin class _$BackupSettingsCopyWith<$Res> implements $BackupSettingsCopyWith<$Res> {
  factory _$BackupSettingsCopyWith(_BackupSettings value, $Res Function(_BackupSettings) _then) = __$BackupSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool hasNotificationEnabled, bool hasAutoSyncEnabled, String themeMode, String colorTheme, String languageCode, String fontType, String textAlign, bool isOnboardingComplete, bool isAppLockEnabled, String lockType, bool isProUser
});




}
/// @nodoc
class __$BackupSettingsCopyWithImpl<$Res>
    implements _$BackupSettingsCopyWith<$Res> {
  __$BackupSettingsCopyWithImpl(this._self, this._then);

  final _BackupSettings _self;
  final $Res Function(_BackupSettings) _then;

/// Create a copy of BackupSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hasNotificationEnabled = null,Object? hasAutoSyncEnabled = null,Object? themeMode = null,Object? colorTheme = null,Object? languageCode = null,Object? fontType = null,Object? textAlign = null,Object? isOnboardingComplete = null,Object? isAppLockEnabled = null,Object? lockType = null,Object? isProUser = null,}) {
  return _then(_BackupSettings(
hasNotificationEnabled: null == hasNotificationEnabled ? _self.hasNotificationEnabled : hasNotificationEnabled // ignore: cast_nullable_to_non_nullable
as bool,hasAutoSyncEnabled: null == hasAutoSyncEnabled ? _self.hasAutoSyncEnabled : hasAutoSyncEnabled // ignore: cast_nullable_to_non_nullable
as bool,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as String,colorTheme: null == colorTheme ? _self.colorTheme : colorTheme // ignore: cast_nullable_to_non_nullable
as String,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,fontType: null == fontType ? _self.fontType : fontType // ignore: cast_nullable_to_non_nullable
as String,textAlign: null == textAlign ? _self.textAlign : textAlign // ignore: cast_nullable_to_non_nullable
as String,isOnboardingComplete: null == isOnboardingComplete ? _self.isOnboardingComplete : isOnboardingComplete // ignore: cast_nullable_to_non_nullable
as bool,isAppLockEnabled: null == isAppLockEnabled ? _self.isAppLockEnabled : isAppLockEnabled // ignore: cast_nullable_to_non_nullable
as bool,lockType: null == lockType ? _self.lockType : lockType // ignore: cast_nullable_to_non_nullable
as String,isProUser: null == isProUser ? _self.isProUser : isProUser // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
