// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppState {

 bool get isFirstLaunch; ThemeMode get themeMode; LanguageCode get languageCode; DateTime? get lastActiveDate; DateTime? get firstLaunchedDate;
/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStateCopyWith<AppState> get copyWith => _$AppStateCopyWithImpl<AppState>(this as AppState, _$identity);

  /// Serializes this AppState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppState&&(identical(other.isFirstLaunch, isFirstLaunch) || other.isFirstLaunch == isFirstLaunch)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.lastActiveDate, lastActiveDate) || other.lastActiveDate == lastActiveDate)&&(identical(other.firstLaunchedDate, firstLaunchedDate) || other.firstLaunchedDate == firstLaunchedDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isFirstLaunch,themeMode,languageCode,lastActiveDate,firstLaunchedDate);

@override
String toString() {
  return 'AppState(isFirstLaunch: $isFirstLaunch, themeMode: $themeMode, languageCode: $languageCode, lastActiveDate: $lastActiveDate, firstLaunchedDate: $firstLaunchedDate)';
}


}

/// @nodoc
abstract mixin class $AppStateCopyWith<$Res>  {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) _then) = _$AppStateCopyWithImpl;
@useResult
$Res call({
 bool isFirstLaunch, ThemeMode themeMode, LanguageCode languageCode, DateTime? lastActiveDate, DateTime? firstLaunchedDate
});




}
/// @nodoc
class _$AppStateCopyWithImpl<$Res>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._self, this._then);

  final AppState _self;
  final $Res Function(AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isFirstLaunch = null,Object? themeMode = null,Object? languageCode = null,Object? lastActiveDate = freezed,Object? firstLaunchedDate = freezed,}) {
  return _then(_self.copyWith(
isFirstLaunch: null == isFirstLaunch ? _self.isFirstLaunch : isFirstLaunch // ignore: cast_nullable_to_non_nullable
as bool,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as LanguageCode,lastActiveDate: freezed == lastActiveDate ? _self.lastActiveDate : lastActiveDate // ignore: cast_nullable_to_non_nullable
as DateTime?,firstLaunchedDate: freezed == firstLaunchedDate ? _self.firstLaunchedDate : firstLaunchedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _AppState extends AppState {
  const _AppState({this.isFirstLaunch = true, this.themeMode = ThemeMode.system, this.languageCode = LanguageCode.ko, this.lastActiveDate, this.firstLaunchedDate}): super._();
  factory _AppState.fromJson(Map<String, dynamic> json) => _$AppStateFromJson(json);

@override@JsonKey() final  bool isFirstLaunch;
@override@JsonKey() final  ThemeMode themeMode;
@override@JsonKey() final  LanguageCode languageCode;
@override final  DateTime? lastActiveDate;
@override final  DateTime? firstLaunchedDate;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppStateCopyWith<_AppState> get copyWith => __$AppStateCopyWithImpl<_AppState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppState&&(identical(other.isFirstLaunch, isFirstLaunch) || other.isFirstLaunch == isFirstLaunch)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.lastActiveDate, lastActiveDate) || other.lastActiveDate == lastActiveDate)&&(identical(other.firstLaunchedDate, firstLaunchedDate) || other.firstLaunchedDate == firstLaunchedDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isFirstLaunch,themeMode,languageCode,lastActiveDate,firstLaunchedDate);

@override
String toString() {
  return 'AppState(isFirstLaunch: $isFirstLaunch, themeMode: $themeMode, languageCode: $languageCode, lastActiveDate: $lastActiveDate, firstLaunchedDate: $firstLaunchedDate)';
}


}

/// @nodoc
abstract mixin class _$AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$AppStateCopyWith(_AppState value, $Res Function(_AppState) _then) = __$AppStateCopyWithImpl;
@override @useResult
$Res call({
 bool isFirstLaunch, ThemeMode themeMode, LanguageCode languageCode, DateTime? lastActiveDate, DateTime? firstLaunchedDate
});




}
/// @nodoc
class __$AppStateCopyWithImpl<$Res>
    implements _$AppStateCopyWith<$Res> {
  __$AppStateCopyWithImpl(this._self, this._then);

  final _AppState _self;
  final $Res Function(_AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isFirstLaunch = null,Object? themeMode = null,Object? languageCode = null,Object? lastActiveDate = freezed,Object? firstLaunchedDate = freezed,}) {
  return _then(_AppState(
isFirstLaunch: null == isFirstLaunch ? _self.isFirstLaunch : isFirstLaunch // ignore: cast_nullable_to_non_nullable
as bool,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as LanguageCode,lastActiveDate: freezed == lastActiveDate ? _self.lastActiveDate : lastActiveDate // ignore: cast_nullable_to_non_nullable
as DateTime?,firstLaunchedDate: freezed == firstLaunchedDate ? _self.firstLaunchedDate : firstLaunchedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
