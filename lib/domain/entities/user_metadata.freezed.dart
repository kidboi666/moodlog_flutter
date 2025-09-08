// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserMetadata {

 DateTime? get creationTime; DateTime? get lastSignInTime;
/// Create a copy of UserMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserMetadataCopyWith<UserMetadata> get copyWith => _$UserMetadataCopyWithImpl<UserMetadata>(this as UserMetadata, _$identity);

  /// Serializes this UserMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserMetadata&&(identical(other.creationTime, creationTime) || other.creationTime == creationTime)&&(identical(other.lastSignInTime, lastSignInTime) || other.lastSignInTime == lastSignInTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,creationTime,lastSignInTime);

@override
String toString() {
  return 'UserMetadata(creationTime: $creationTime, lastSignInTime: $lastSignInTime)';
}


}

/// @nodoc
abstract mixin class $UserMetadataCopyWith<$Res>  {
  factory $UserMetadataCopyWith(UserMetadata value, $Res Function(UserMetadata) _then) = _$UserMetadataCopyWithImpl;
@useResult
$Res call({
 DateTime? creationTime, DateTime? lastSignInTime
});




}
/// @nodoc
class _$UserMetadataCopyWithImpl<$Res>
    implements $UserMetadataCopyWith<$Res> {
  _$UserMetadataCopyWithImpl(this._self, this._then);

  final UserMetadata _self;
  final $Res Function(UserMetadata) _then;

/// Create a copy of UserMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? creationTime = freezed,Object? lastSignInTime = freezed,}) {
  return _then(_self.copyWith(
creationTime: freezed == creationTime ? _self.creationTime : creationTime // ignore: cast_nullable_to_non_nullable
as DateTime?,lastSignInTime: freezed == lastSignInTime ? _self.lastSignInTime : lastSignInTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserMetadata].
extension UserMetadataPatterns on UserMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserMetadata value)  $default,){
final _that = this;
switch (_that) {
case _UserMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _UserMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? creationTime,  DateTime? lastSignInTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserMetadata() when $default != null:
return $default(_that.creationTime,_that.lastSignInTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? creationTime,  DateTime? lastSignInTime)  $default,) {final _that = this;
switch (_that) {
case _UserMetadata():
return $default(_that.creationTime,_that.lastSignInTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? creationTime,  DateTime? lastSignInTime)?  $default,) {final _that = this;
switch (_that) {
case _UserMetadata() when $default != null:
return $default(_that.creationTime,_that.lastSignInTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserMetadata implements UserMetadata {
  const _UserMetadata({this.creationTime, this.lastSignInTime});
  factory _UserMetadata.fromJson(Map<String, dynamic> json) => _$UserMetadataFromJson(json);

@override final  DateTime? creationTime;
@override final  DateTime? lastSignInTime;

/// Create a copy of UserMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserMetadataCopyWith<_UserMetadata> get copyWith => __$UserMetadataCopyWithImpl<_UserMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserMetadata&&(identical(other.creationTime, creationTime) || other.creationTime == creationTime)&&(identical(other.lastSignInTime, lastSignInTime) || other.lastSignInTime == lastSignInTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,creationTime,lastSignInTime);

@override
String toString() {
  return 'UserMetadata(creationTime: $creationTime, lastSignInTime: $lastSignInTime)';
}


}

/// @nodoc
abstract mixin class _$UserMetadataCopyWith<$Res> implements $UserMetadataCopyWith<$Res> {
  factory _$UserMetadataCopyWith(_UserMetadata value, $Res Function(_UserMetadata) _then) = __$UserMetadataCopyWithImpl;
@override @useResult
$Res call({
 DateTime? creationTime, DateTime? lastSignInTime
});




}
/// @nodoc
class __$UserMetadataCopyWithImpl<$Res>
    implements _$UserMetadataCopyWith<$Res> {
  __$UserMetadataCopyWithImpl(this._self, this._then);

  final _UserMetadata _self;
  final $Res Function(_UserMetadata) _then;

/// Create a copy of UserMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? creationTime = freezed,Object? lastSignInTime = freezed,}) {
  return _then(_UserMetadata(
creationTime: freezed == creationTime ? _self.creationTime : creationTime // ignore: cast_nullable_to_non_nullable
as DateTime?,lastSignInTime: freezed == lastSignInTime ? _self.lastSignInTime : lastSignInTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
