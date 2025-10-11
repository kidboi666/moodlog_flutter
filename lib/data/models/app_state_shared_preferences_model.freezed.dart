// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_state_shared_preferences_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppStateSharedPreferencesModel {

 bool get hasNotificationEnabled; bool get hasAutoSyncEnabled; String get themeMode; String get colorTheme; String get languageCode; String get aiPersonality; String get fontFamily; String get textAlign; bool get isOnboardingComplete;
/// Create a copy of AppStateSharedPreferencesModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStateSharedPreferencesModelCopyWith<AppStateSharedPreferencesModel> get copyWith => _$AppStateSharedPreferencesModelCopyWithImpl<AppStateSharedPreferencesModel>(this as AppStateSharedPreferencesModel, _$identity);

  /// Serializes this AppStateSharedPreferencesModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppStateSharedPreferencesModel&&(identical(other.hasNotificationEnabled, hasNotificationEnabled) || other.hasNotificationEnabled == hasNotificationEnabled)&&(identical(other.hasAutoSyncEnabled, hasAutoSyncEnabled) || other.hasAutoSyncEnabled == hasAutoSyncEnabled)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.colorTheme, colorTheme) || other.colorTheme == colorTheme)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.aiPersonality, aiPersonality) || other.aiPersonality == aiPersonality)&&(identical(other.fontFamily, fontFamily) || other.fontFamily == fontFamily)&&(identical(other.textAlign, textAlign) || other.textAlign == textAlign)&&(identical(other.isOnboardingComplete, isOnboardingComplete) || other.isOnboardingComplete == isOnboardingComplete));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasNotificationEnabled,hasAutoSyncEnabled,themeMode,colorTheme,languageCode,aiPersonality,fontFamily,textAlign,isOnboardingComplete);

@override
String toString() {
  return 'AppStateSharedPreferencesModel(hasNotificationEnabled: $hasNotificationEnabled, hasAutoSyncEnabled: $hasAutoSyncEnabled, themeMode: $themeMode, colorTheme: $colorTheme, languageCode: $languageCode, aiPersonality: $aiPersonality, fontFamily: $fontFamily, textAlign: $textAlign, isOnboardingComplete: $isOnboardingComplete)';
}


}

/// @nodoc
abstract mixin class $AppStateSharedPreferencesModelCopyWith<$Res>  {
  factory $AppStateSharedPreferencesModelCopyWith(AppStateSharedPreferencesModel value, $Res Function(AppStateSharedPreferencesModel) _then) = _$AppStateSharedPreferencesModelCopyWithImpl;
@useResult
$Res call({
 bool hasNotificationEnabled, bool hasAutoSyncEnabled, String themeMode, String colorTheme, String languageCode, String aiPersonality, String fontFamily, String textAlign, bool isOnboardingComplete
});




}
/// @nodoc
class _$AppStateSharedPreferencesModelCopyWithImpl<$Res>
    implements $AppStateSharedPreferencesModelCopyWith<$Res> {
  _$AppStateSharedPreferencesModelCopyWithImpl(this._self, this._then);

  final AppStateSharedPreferencesModel _self;
  final $Res Function(AppStateSharedPreferencesModel) _then;

/// Create a copy of AppStateSharedPreferencesModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hasNotificationEnabled = null,Object? hasAutoSyncEnabled = null,Object? themeMode = null,Object? colorTheme = null,Object? languageCode = null,Object? aiPersonality = null,Object? fontFamily = null,Object? textAlign = null,Object? isOnboardingComplete = null,}) {
  return _then(_self.copyWith(
hasNotificationEnabled: null == hasNotificationEnabled ? _self.hasNotificationEnabled : hasNotificationEnabled // ignore: cast_nullable_to_non_nullable
as bool,hasAutoSyncEnabled: null == hasAutoSyncEnabled ? _self.hasAutoSyncEnabled : hasAutoSyncEnabled // ignore: cast_nullable_to_non_nullable
as bool,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as String,colorTheme: null == colorTheme ? _self.colorTheme : colorTheme // ignore: cast_nullable_to_non_nullable
as String,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,aiPersonality: null == aiPersonality ? _self.aiPersonality : aiPersonality // ignore: cast_nullable_to_non_nullable
as String,fontFamily: null == fontFamily ? _self.fontFamily : fontFamily // ignore: cast_nullable_to_non_nullable
as String,textAlign: null == textAlign ? _self.textAlign : textAlign // ignore: cast_nullable_to_non_nullable
as String,isOnboardingComplete: null == isOnboardingComplete ? _self.isOnboardingComplete : isOnboardingComplete // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AppStateSharedPreferencesModel].
extension AppStateSharedPreferencesModelPatterns on AppStateSharedPreferencesModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppStateSharedPreferencesModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppStateSharedPreferencesModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppStateSharedPreferencesModel value)  $default,){
final _that = this;
switch (_that) {
case _AppStateSharedPreferencesModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppStateSharedPreferencesModel value)?  $default,){
final _that = this;
switch (_that) {
case _AppStateSharedPreferencesModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool hasNotificationEnabled,  bool hasAutoSyncEnabled,  String themeMode,  String colorTheme,  String languageCode,  String aiPersonality,  String fontFamily,  String textAlign,  bool isOnboardingComplete)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppStateSharedPreferencesModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool hasNotificationEnabled,  bool hasAutoSyncEnabled,  String themeMode,  String colorTheme,  String languageCode,  String aiPersonality,  String fontFamily,  String textAlign,  bool isOnboardingComplete)  $default,) {final _that = this;
switch (_that) {
case _AppStateSharedPreferencesModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool hasNotificationEnabled,  bool hasAutoSyncEnabled,  String themeMode,  String colorTheme,  String languageCode,  String aiPersonality,  String fontFamily,  String textAlign,  bool isOnboardingComplete)?  $default,) {final _that = this;
switch (_that) {
case _AppStateSharedPreferencesModel() when $default != null:
return $default(_that.hasNotificationEnabled,_that.hasAutoSyncEnabled,_that.themeMode,_that.colorTheme,_that.languageCode,_that.aiPersonality,_that.fontFamily,_that.textAlign,_that.isOnboardingComplete);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppStateSharedPreferencesModel extends AppStateSharedPreferencesModel {
  const _AppStateSharedPreferencesModel({this.hasNotificationEnabled = false, this.hasAutoSyncEnabled = false, this.themeMode = 'ThemeMode.system', this.colorTheme = 'ColorTheme.blue', this.languageCode = 'LanguageCode.ko', this.aiPersonality = 'AiPersonality.balanced', this.fontFamily = 'FontFamily.restart', this.textAlign = 'SimpleTextAlign.left', this.isOnboardingComplete = false}): super._();
  factory _AppStateSharedPreferencesModel.fromJson(Map<String, dynamic> json) => _$AppStateSharedPreferencesModelFromJson(json);

@override@JsonKey() final  bool hasNotificationEnabled;
@override@JsonKey() final  bool hasAutoSyncEnabled;
@override@JsonKey() final  String themeMode;
@override@JsonKey() final  String colorTheme;
@override@JsonKey() final  String languageCode;
@override@JsonKey() final  String aiPersonality;
@override@JsonKey() final  String fontFamily;
@override@JsonKey() final  String textAlign;
@override@JsonKey() final  bool isOnboardingComplete;

/// Create a copy of AppStateSharedPreferencesModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppStateSharedPreferencesModelCopyWith<_AppStateSharedPreferencesModel> get copyWith => __$AppStateSharedPreferencesModelCopyWithImpl<_AppStateSharedPreferencesModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppStateSharedPreferencesModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppStateSharedPreferencesModel&&(identical(other.hasNotificationEnabled, hasNotificationEnabled) || other.hasNotificationEnabled == hasNotificationEnabled)&&(identical(other.hasAutoSyncEnabled, hasAutoSyncEnabled) || other.hasAutoSyncEnabled == hasAutoSyncEnabled)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.colorTheme, colorTheme) || other.colorTheme == colorTheme)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.aiPersonality, aiPersonality) || other.aiPersonality == aiPersonality)&&(identical(other.fontFamily, fontFamily) || other.fontFamily == fontFamily)&&(identical(other.textAlign, textAlign) || other.textAlign == textAlign)&&(identical(other.isOnboardingComplete, isOnboardingComplete) || other.isOnboardingComplete == isOnboardingComplete));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasNotificationEnabled,hasAutoSyncEnabled,themeMode,colorTheme,languageCode,aiPersonality,fontFamily,textAlign,isOnboardingComplete);

@override
String toString() {
  return 'AppStateSharedPreferencesModel(hasNotificationEnabled: $hasNotificationEnabled, hasAutoSyncEnabled: $hasAutoSyncEnabled, themeMode: $themeMode, colorTheme: $colorTheme, languageCode: $languageCode, aiPersonality: $aiPersonality, fontFamily: $fontFamily, textAlign: $textAlign, isOnboardingComplete: $isOnboardingComplete)';
}


}

/// @nodoc
abstract mixin class _$AppStateSharedPreferencesModelCopyWith<$Res> implements $AppStateSharedPreferencesModelCopyWith<$Res> {
  factory _$AppStateSharedPreferencesModelCopyWith(_AppStateSharedPreferencesModel value, $Res Function(_AppStateSharedPreferencesModel) _then) = __$AppStateSharedPreferencesModelCopyWithImpl;
@override @useResult
$Res call({
 bool hasNotificationEnabled, bool hasAutoSyncEnabled, String themeMode, String colorTheme, String languageCode, String aiPersonality, String fontFamily, String textAlign, bool isOnboardingComplete
});




}
/// @nodoc
class __$AppStateSharedPreferencesModelCopyWithImpl<$Res>
    implements _$AppStateSharedPreferencesModelCopyWith<$Res> {
  __$AppStateSharedPreferencesModelCopyWithImpl(this._self, this._then);

  final _AppStateSharedPreferencesModel _self;
  final $Res Function(_AppStateSharedPreferencesModel) _then;

/// Create a copy of AppStateSharedPreferencesModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hasNotificationEnabled = null,Object? hasAutoSyncEnabled = null,Object? themeMode = null,Object? colorTheme = null,Object? languageCode = null,Object? aiPersonality = null,Object? fontFamily = null,Object? textAlign = null,Object? isOnboardingComplete = null,}) {
  return _then(_AppStateSharedPreferencesModel(
hasNotificationEnabled: null == hasNotificationEnabled ? _self.hasNotificationEnabled : hasNotificationEnabled // ignore: cast_nullable_to_non_nullable
as bool,hasAutoSyncEnabled: null == hasAutoSyncEnabled ? _self.hasAutoSyncEnabled : hasAutoSyncEnabled // ignore: cast_nullable_to_non_nullable
as bool,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as String,colorTheme: null == colorTheme ? _self.colorTheme : colorTheme // ignore: cast_nullable_to_non_nullable
as String,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,aiPersonality: null == aiPersonality ? _self.aiPersonality : aiPersonality // ignore: cast_nullable_to_non_nullable
as String,fontFamily: null == fontFamily ? _self.fontFamily : fontFamily // ignore: cast_nullable_to_non_nullable
as String,textAlign: null == textAlign ? _self.textAlign : textAlign // ignore: cast_nullable_to_non_nullable
as String,isOnboardingComplete: null == isOnboardingComplete ? _self.isOnboardingComplete : isOnboardingComplete // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
