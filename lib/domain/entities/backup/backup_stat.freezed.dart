// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backup_stat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BackupStat {

 int get id; int get currentStreak; int get maxStreak; DateTime get lastActiveDate;
/// Create a copy of BackupStat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackupStatCopyWith<BackupStat> get copyWith => _$BackupStatCopyWithImpl<BackupStat>(this as BackupStat, _$identity);

  /// Serializes this BackupStat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupStat&&(identical(other.id, id) || other.id == id)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.maxStreak, maxStreak) || other.maxStreak == maxStreak)&&(identical(other.lastActiveDate, lastActiveDate) || other.lastActiveDate == lastActiveDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,currentStreak,maxStreak,lastActiveDate);

@override
String toString() {
  return 'BackupStat(id: $id, currentStreak: $currentStreak, maxStreak: $maxStreak, lastActiveDate: $lastActiveDate)';
}


}

/// @nodoc
abstract mixin class $BackupStatCopyWith<$Res>  {
  factory $BackupStatCopyWith(BackupStat value, $Res Function(BackupStat) _then) = _$BackupStatCopyWithImpl;
@useResult
$Res call({
 int id, int currentStreak, int maxStreak, DateTime lastActiveDate
});




}
/// @nodoc
class _$BackupStatCopyWithImpl<$Res>
    implements $BackupStatCopyWith<$Res> {
  _$BackupStatCopyWithImpl(this._self, this._then);

  final BackupStat _self;
  final $Res Function(BackupStat) _then;

/// Create a copy of BackupStat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? currentStreak = null,Object? maxStreak = null,Object? lastActiveDate = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,maxStreak: null == maxStreak ? _self.maxStreak : maxStreak // ignore: cast_nullable_to_non_nullable
as int,lastActiveDate: null == lastActiveDate ? _self.lastActiveDate : lastActiveDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [BackupStat].
extension BackupStatPatterns on BackupStat {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BackupStat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BackupStat() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BackupStat value)  $default,){
final _that = this;
switch (_that) {
case _BackupStat():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BackupStat value)?  $default,){
final _that = this;
switch (_that) {
case _BackupStat() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int currentStreak,  int maxStreak,  DateTime lastActiveDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BackupStat() when $default != null:
return $default(_that.id,_that.currentStreak,_that.maxStreak,_that.lastActiveDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int currentStreak,  int maxStreak,  DateTime lastActiveDate)  $default,) {final _that = this;
switch (_that) {
case _BackupStat():
return $default(_that.id,_that.currentStreak,_that.maxStreak,_that.lastActiveDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int currentStreak,  int maxStreak,  DateTime lastActiveDate)?  $default,) {final _that = this;
switch (_that) {
case _BackupStat() when $default != null:
return $default(_that.id,_that.currentStreak,_that.maxStreak,_that.lastActiveDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BackupStat implements BackupStat {
  const _BackupStat({required this.id, required this.currentStreak, required this.maxStreak, required this.lastActiveDate});
  factory _BackupStat.fromJson(Map<String, dynamic> json) => _$BackupStatFromJson(json);

@override final  int id;
@override final  int currentStreak;
@override final  int maxStreak;
@override final  DateTime lastActiveDate;

/// Create a copy of BackupStat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BackupStatCopyWith<_BackupStat> get copyWith => __$BackupStatCopyWithImpl<_BackupStat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BackupStatToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackupStat&&(identical(other.id, id) || other.id == id)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.maxStreak, maxStreak) || other.maxStreak == maxStreak)&&(identical(other.lastActiveDate, lastActiveDate) || other.lastActiveDate == lastActiveDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,currentStreak,maxStreak,lastActiveDate);

@override
String toString() {
  return 'BackupStat(id: $id, currentStreak: $currentStreak, maxStreak: $maxStreak, lastActiveDate: $lastActiveDate)';
}


}

/// @nodoc
abstract mixin class _$BackupStatCopyWith<$Res> implements $BackupStatCopyWith<$Res> {
  factory _$BackupStatCopyWith(_BackupStat value, $Res Function(_BackupStat) _then) = __$BackupStatCopyWithImpl;
@override @useResult
$Res call({
 int id, int currentStreak, int maxStreak, DateTime lastActiveDate
});




}
/// @nodoc
class __$BackupStatCopyWithImpl<$Res>
    implements _$BackupStatCopyWith<$Res> {
  __$BackupStatCopyWithImpl(this._self, this._then);

  final _BackupStat _self;
  final $Res Function(_BackupStat) _then;

/// Create a copy of BackupStat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? currentStreak = null,Object? maxStreak = null,Object? lastActiveDate = null,}) {
  return _then(_BackupStat(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,maxStreak: null == maxStreak ? _self.maxStreak : maxStreak // ignore: cast_nullable_to_non_nullable
as int,lastActiveDate: null == lastActiveDate ? _self.lastActiveDate : lastActiveDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
