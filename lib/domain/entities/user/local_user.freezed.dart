// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'local_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocalUser {

 String get userId; String get nickname; String? get profileImagePath; DateTime get createdAt;
/// Create a copy of LocalUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocalUserCopyWith<LocalUser> get copyWith => _$LocalUserCopyWithImpl<LocalUser>(this as LocalUser, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalUser&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.profileImagePath, profileImagePath) || other.profileImagePath == profileImagePath)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,userId,nickname,profileImagePath,createdAt);

@override
String toString() {
  return 'LocalUser(userId: $userId, nickname: $nickname, profileImagePath: $profileImagePath, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $LocalUserCopyWith<$Res>  {
  factory $LocalUserCopyWith(LocalUser value, $Res Function(LocalUser) _then) = _$LocalUserCopyWithImpl;
@useResult
$Res call({
 String userId, String nickname, String? profileImagePath, DateTime createdAt
});




}
/// @nodoc
class _$LocalUserCopyWithImpl<$Res>
    implements $LocalUserCopyWith<$Res> {
  _$LocalUserCopyWithImpl(this._self, this._then);

  final LocalUser _self;
  final $Res Function(LocalUser) _then;

/// Create a copy of LocalUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? nickname = null,Object? profileImagePath = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,profileImagePath: freezed == profileImagePath ? _self.profileImagePath : profileImagePath // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [LocalUser].
extension LocalUserPatterns on LocalUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocalUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocalUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocalUser value)  $default,){
final _that = this;
switch (_that) {
case _LocalUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocalUser value)?  $default,){
final _that = this;
switch (_that) {
case _LocalUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String nickname,  String? profileImagePath,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocalUser() when $default != null:
return $default(_that.userId,_that.nickname,_that.profileImagePath,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String nickname,  String? profileImagePath,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _LocalUser():
return $default(_that.userId,_that.nickname,_that.profileImagePath,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String nickname,  String? profileImagePath,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _LocalUser() when $default != null:
return $default(_that.userId,_that.nickname,_that.profileImagePath,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _LocalUser implements LocalUser {
  const _LocalUser({required this.userId, required this.nickname, this.profileImagePath, required this.createdAt});
  

@override final  String userId;
@override final  String nickname;
@override final  String? profileImagePath;
@override final  DateTime createdAt;

/// Create a copy of LocalUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocalUserCopyWith<_LocalUser> get copyWith => __$LocalUserCopyWithImpl<_LocalUser>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocalUser&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.profileImagePath, profileImagePath) || other.profileImagePath == profileImagePath)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,userId,nickname,profileImagePath,createdAt);

@override
String toString() {
  return 'LocalUser(userId: $userId, nickname: $nickname, profileImagePath: $profileImagePath, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$LocalUserCopyWith<$Res> implements $LocalUserCopyWith<$Res> {
  factory _$LocalUserCopyWith(_LocalUser value, $Res Function(_LocalUser) _then) = __$LocalUserCopyWithImpl;
@override @useResult
$Res call({
 String userId, String nickname, String? profileImagePath, DateTime createdAt
});




}
/// @nodoc
class __$LocalUserCopyWithImpl<$Res>
    implements _$LocalUserCopyWith<$Res> {
  __$LocalUserCopyWithImpl(this._self, this._then);

  final _LocalUser _self;
  final $Res Function(_LocalUser) _then;

/// Create a copy of LocalUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? nickname = null,Object? profileImagePath = freezed,Object? createdAt = null,}) {
  return _then(_LocalUser(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,profileImagePath: freezed == profileImagePath ? _self.profileImagePath : profileImagePath // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
