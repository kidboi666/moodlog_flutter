// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$User {

 String get uid; String? get email; bool get isAnonymous; String? get displayName; String? get photoURL; UserMetadata get metadata; List<UserProviderData> get providerData;
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this as User, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.email, email) || other.email == email)&&(identical(other.isAnonymous, isAnonymous) || other.isAnonymous == isAnonymous)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoURL, photoURL) || other.photoURL == photoURL)&&(identical(other.metadata, metadata) || other.metadata == metadata)&&const DeepCollectionEquality().equals(other.providerData, providerData));
}


@override
int get hashCode => Object.hash(runtimeType,uid,email,isAnonymous,displayName,photoURL,metadata,const DeepCollectionEquality().hash(providerData));

@override
String toString() {
  return 'User(uid: $uid, email: $email, isAnonymous: $isAnonymous, displayName: $displayName, photoURL: $photoURL, metadata: $metadata, providerData: $providerData)';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res>  {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@useResult
$Res call({
 String uid, String? email, bool isAnonymous, String? displayName, String? photoURL, UserMetadata metadata, List<UserProviderData> providerData
});


$UserMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class _$UserCopyWithImpl<$Res>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? email = freezed,Object? isAnonymous = null,Object? displayName = freezed,Object? photoURL = freezed,Object? metadata = null,Object? providerData = null,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,isAnonymous: null == isAnonymous ? _self.isAnonymous : isAnonymous // ignore: cast_nullable_to_non_nullable
as bool,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,photoURL: freezed == photoURL ? _self.photoURL : photoURL // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as UserMetadata,providerData: null == providerData ? _self.providerData : providerData // ignore: cast_nullable_to_non_nullable
as List<UserProviderData>,
  ));
}
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserMetadataCopyWith<$Res> get metadata {
  
  return $UserMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}


/// Adds pattern-matching-related methods to [User].
extension UserPatterns on User {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _User value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _User() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _User value)  $default,){
final _that = this;
switch (_that) {
case _User():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _User value)?  $default,){
final _that = this;
switch (_that) {
case _User() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  String? email,  bool isAnonymous,  String? displayName,  String? photoURL,  UserMetadata metadata,  List<UserProviderData> providerData)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.uid,_that.email,_that.isAnonymous,_that.displayName,_that.photoURL,_that.metadata,_that.providerData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  String? email,  bool isAnonymous,  String? displayName,  String? photoURL,  UserMetadata metadata,  List<UserProviderData> providerData)  $default,) {final _that = this;
switch (_that) {
case _User():
return $default(_that.uid,_that.email,_that.isAnonymous,_that.displayName,_that.photoURL,_that.metadata,_that.providerData);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  String? email,  bool isAnonymous,  String? displayName,  String? photoURL,  UserMetadata metadata,  List<UserProviderData> providerData)?  $default,) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.uid,_that.email,_that.isAnonymous,_that.displayName,_that.photoURL,_that.metadata,_that.providerData);case _:
  return null;

}
}

}

/// @nodoc


class _User implements User {
  const _User({required this.uid, this.email, required this.isAnonymous, this.displayName, this.photoURL, required this.metadata, required final  List<UserProviderData> providerData}): _providerData = providerData;
  

@override final  String uid;
@override final  String? email;
@override final  bool isAnonymous;
@override final  String? displayName;
@override final  String? photoURL;
@override final  UserMetadata metadata;
 final  List<UserProviderData> _providerData;
@override List<UserProviderData> get providerData {
  if (_providerData is EqualUnmodifiableListView) return _providerData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_providerData);
}


/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCopyWith<_User> get copyWith => __$UserCopyWithImpl<_User>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _User&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.email, email) || other.email == email)&&(identical(other.isAnonymous, isAnonymous) || other.isAnonymous == isAnonymous)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoURL, photoURL) || other.photoURL == photoURL)&&(identical(other.metadata, metadata) || other.metadata == metadata)&&const DeepCollectionEquality().equals(other._providerData, _providerData));
}


@override
int get hashCode => Object.hash(runtimeType,uid,email,isAnonymous,displayName,photoURL,metadata,const DeepCollectionEquality().hash(_providerData));

@override
String toString() {
  return 'User(uid: $uid, email: $email, isAnonymous: $isAnonymous, displayName: $displayName, photoURL: $photoURL, metadata: $metadata, providerData: $providerData)';
}


}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) = __$UserCopyWithImpl;
@override @useResult
$Res call({
 String uid, String? email, bool isAnonymous, String? displayName, String? photoURL, UserMetadata metadata, List<UserProviderData> providerData
});


@override $UserMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class __$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? email = freezed,Object? isAnonymous = null,Object? displayName = freezed,Object? photoURL = freezed,Object? metadata = null,Object? providerData = null,}) {
  return _then(_User(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,isAnonymous: null == isAnonymous ? _self.isAnonymous : isAnonymous // ignore: cast_nullable_to_non_nullable
as bool,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,photoURL: freezed == photoURL ? _self.photoURL : photoURL // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as UserMetadata,providerData: null == providerData ? _self._providerData : providerData // ignore: cast_nullable_to_non_nullable
as List<UserProviderData>,
  ));
}

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserMetadataCopyWith<$Res> get metadata {
  
  return $UserMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}

// dart format on
