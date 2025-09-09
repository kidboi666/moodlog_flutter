// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mood_analytics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MoodAnalytics {

 String get moodType; String get entryType; bool get hasImage; bool get hasTag;
/// Create a copy of MoodAnalytics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MoodAnalyticsCopyWith<MoodAnalytics> get copyWith => _$MoodAnalyticsCopyWithImpl<MoodAnalytics>(this as MoodAnalytics, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MoodAnalytics&&(identical(other.moodType, moodType) || other.moodType == moodType)&&(identical(other.entryType, entryType) || other.entryType == entryType)&&(identical(other.hasImage, hasImage) || other.hasImage == hasImage)&&(identical(other.hasTag, hasTag) || other.hasTag == hasTag));
}


@override
int get hashCode => Object.hash(runtimeType,moodType,entryType,hasImage,hasTag);

@override
String toString() {
  return 'MoodAnalytics(moodType: $moodType, entryType: $entryType, hasImage: $hasImage, hasTag: $hasTag)';
}


}

/// @nodoc
abstract mixin class $MoodAnalyticsCopyWith<$Res>  {
  factory $MoodAnalyticsCopyWith(MoodAnalytics value, $Res Function(MoodAnalytics) _then) = _$MoodAnalyticsCopyWithImpl;
@useResult
$Res call({
 String moodType, String entryType, bool hasImage, bool hasTag
});




}
/// @nodoc
class _$MoodAnalyticsCopyWithImpl<$Res>
    implements $MoodAnalyticsCopyWith<$Res> {
  _$MoodAnalyticsCopyWithImpl(this._self, this._then);

  final MoodAnalytics _self;
  final $Res Function(MoodAnalytics) _then;

/// Create a copy of MoodAnalytics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? moodType = null,Object? entryType = null,Object? hasImage = null,Object? hasTag = null,}) {
  return _then(_self.copyWith(
moodType: null == moodType ? _self.moodType : moodType // ignore: cast_nullable_to_non_nullable
as String,entryType: null == entryType ? _self.entryType : entryType // ignore: cast_nullable_to_non_nullable
as String,hasImage: null == hasImage ? _self.hasImage : hasImage // ignore: cast_nullable_to_non_nullable
as bool,hasTag: null == hasTag ? _self.hasTag : hasTag // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MoodAnalytics].
extension MoodAnalyticsPatterns on MoodAnalytics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MoodAnalytics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MoodAnalytics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MoodAnalytics value)  $default,){
final _that = this;
switch (_that) {
case _MoodAnalytics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MoodAnalytics value)?  $default,){
final _that = this;
switch (_that) {
case _MoodAnalytics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String moodType,  String entryType,  bool hasImage,  bool hasTag)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MoodAnalytics() when $default != null:
return $default(_that.moodType,_that.entryType,_that.hasImage,_that.hasTag);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String moodType,  String entryType,  bool hasImage,  bool hasTag)  $default,) {final _that = this;
switch (_that) {
case _MoodAnalytics():
return $default(_that.moodType,_that.entryType,_that.hasImage,_that.hasTag);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String moodType,  String entryType,  bool hasImage,  bool hasTag)?  $default,) {final _that = this;
switch (_that) {
case _MoodAnalytics() when $default != null:
return $default(_that.moodType,_that.entryType,_that.hasImage,_that.hasTag);case _:
  return null;

}
}

}

/// @nodoc


class _MoodAnalytics implements MoodAnalytics {
  const _MoodAnalytics({required this.moodType, required this.entryType, this.hasImage = false, this.hasTag = false});
  

@override final  String moodType;
@override final  String entryType;
@override@JsonKey() final  bool hasImage;
@override@JsonKey() final  bool hasTag;

/// Create a copy of MoodAnalytics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MoodAnalyticsCopyWith<_MoodAnalytics> get copyWith => __$MoodAnalyticsCopyWithImpl<_MoodAnalytics>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MoodAnalytics&&(identical(other.moodType, moodType) || other.moodType == moodType)&&(identical(other.entryType, entryType) || other.entryType == entryType)&&(identical(other.hasImage, hasImage) || other.hasImage == hasImage)&&(identical(other.hasTag, hasTag) || other.hasTag == hasTag));
}


@override
int get hashCode => Object.hash(runtimeType,moodType,entryType,hasImage,hasTag);

@override
String toString() {
  return 'MoodAnalytics(moodType: $moodType, entryType: $entryType, hasImage: $hasImage, hasTag: $hasTag)';
}


}

/// @nodoc
abstract mixin class _$MoodAnalyticsCopyWith<$Res> implements $MoodAnalyticsCopyWith<$Res> {
  factory _$MoodAnalyticsCopyWith(_MoodAnalytics value, $Res Function(_MoodAnalytics) _then) = __$MoodAnalyticsCopyWithImpl;
@override @useResult
$Res call({
 String moodType, String entryType, bool hasImage, bool hasTag
});




}
/// @nodoc
class __$MoodAnalyticsCopyWithImpl<$Res>
    implements _$MoodAnalyticsCopyWith<$Res> {
  __$MoodAnalyticsCopyWithImpl(this._self, this._then);

  final _MoodAnalytics _self;
  final $Res Function(_MoodAnalytics) _then;

/// Create a copy of MoodAnalytics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? moodType = null,Object? entryType = null,Object? hasImage = null,Object? hasTag = null,}) {
  return _then(_MoodAnalytics(
moodType: null == moodType ? _self.moodType : moodType // ignore: cast_nullable_to_non_nullable
as String,entryType: null == entryType ? _self.entryType : entryType // ignore: cast_nullable_to_non_nullable
as String,hasImage: null == hasImage ? _self.hasImage : hasImage // ignore: cast_nullable_to_non_nullable
as bool,hasTag: null == hasTag ? _self.hasTag : hasTag // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
