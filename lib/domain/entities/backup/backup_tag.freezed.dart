// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backup_tag.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BackupTag {

 int get id; String get name; String? get color; DateTime get createdAt;
/// Create a copy of BackupTag
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackupTagCopyWith<BackupTag> get copyWith => _$BackupTagCopyWithImpl<BackupTag>(this as BackupTag, _$identity);

  /// Serializes this BackupTag to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupTag&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,color,createdAt);

@override
String toString() {
  return 'BackupTag(id: $id, name: $name, color: $color, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $BackupTagCopyWith<$Res>  {
  factory $BackupTagCopyWith(BackupTag value, $Res Function(BackupTag) _then) = _$BackupTagCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? color, DateTime createdAt
});




}
/// @nodoc
class _$BackupTagCopyWithImpl<$Res>
    implements $BackupTagCopyWith<$Res> {
  _$BackupTagCopyWithImpl(this._self, this._then);

  final BackupTag _self;
  final $Res Function(BackupTag) _then;

/// Create a copy of BackupTag
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? color = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [BackupTag].
extension BackupTagPatterns on BackupTag {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BackupTag value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BackupTag() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BackupTag value)  $default,){
final _that = this;
switch (_that) {
case _BackupTag():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BackupTag value)?  $default,){
final _that = this;
switch (_that) {
case _BackupTag() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? color,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BackupTag() when $default != null:
return $default(_that.id,_that.name,_that.color,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? color,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _BackupTag():
return $default(_that.id,_that.name,_that.color,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? color,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _BackupTag() when $default != null:
return $default(_that.id,_that.name,_that.color,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BackupTag implements BackupTag {
  const _BackupTag({required this.id, required this.name, this.color, required this.createdAt});
  factory _BackupTag.fromJson(Map<String, dynamic> json) => _$BackupTagFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? color;
@override final  DateTime createdAt;

/// Create a copy of BackupTag
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BackupTagCopyWith<_BackupTag> get copyWith => __$BackupTagCopyWithImpl<_BackupTag>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BackupTagToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackupTag&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,color,createdAt);

@override
String toString() {
  return 'BackupTag(id: $id, name: $name, color: $color, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$BackupTagCopyWith<$Res> implements $BackupTagCopyWith<$Res> {
  factory _$BackupTagCopyWith(_BackupTag value, $Res Function(_BackupTag) _then) = __$BackupTagCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? color, DateTime createdAt
});




}
/// @nodoc
class __$BackupTagCopyWithImpl<$Res>
    implements _$BackupTagCopyWith<$Res> {
  __$BackupTagCopyWithImpl(this._self, this._then);

  final _BackupTag _self;
  final $Res Function(_BackupTag) _then;

/// Create a copy of BackupTag
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? color = freezed,Object? createdAt = null,}) {
  return _then(_BackupTag(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
