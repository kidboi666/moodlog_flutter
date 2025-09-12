// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_journal_ai_response_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UpdateJournalAiResponseRequest {

 int get id; bool get aiResponseEnabled; String? get aiResponse;
/// Create a copy of UpdateJournalAiResponseRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateJournalAiResponseRequestCopyWith<UpdateJournalAiResponseRequest> get copyWith => _$UpdateJournalAiResponseRequestCopyWithImpl<UpdateJournalAiResponseRequest>(this as UpdateJournalAiResponseRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateJournalAiResponseRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.aiResponseEnabled, aiResponseEnabled) || other.aiResponseEnabled == aiResponseEnabled)&&(identical(other.aiResponse, aiResponse) || other.aiResponse == aiResponse));
}


@override
int get hashCode => Object.hash(runtimeType,id,aiResponseEnabled,aiResponse);

@override
String toString() {
  return 'UpdateJournalAiResponseRequest(id: $id, aiResponseEnabled: $aiResponseEnabled, aiResponse: $aiResponse)';
}


}

/// @nodoc
abstract mixin class $UpdateJournalAiResponseRequestCopyWith<$Res>  {
  factory $UpdateJournalAiResponseRequestCopyWith(UpdateJournalAiResponseRequest value, $Res Function(UpdateJournalAiResponseRequest) _then) = _$UpdateJournalAiResponseRequestCopyWithImpl;
@useResult
$Res call({
 int id, bool aiResponseEnabled, String? aiResponse
});




}
/// @nodoc
class _$UpdateJournalAiResponseRequestCopyWithImpl<$Res>
    implements $UpdateJournalAiResponseRequestCopyWith<$Res> {
  _$UpdateJournalAiResponseRequestCopyWithImpl(this._self, this._then);

  final UpdateJournalAiResponseRequest _self;
  final $Res Function(UpdateJournalAiResponseRequest) _then;

/// Create a copy of UpdateJournalAiResponseRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? aiResponseEnabled = null,Object? aiResponse = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,aiResponseEnabled: null == aiResponseEnabled ? _self.aiResponseEnabled : aiResponseEnabled // ignore: cast_nullable_to_non_nullable
as bool,aiResponse: freezed == aiResponse ? _self.aiResponse : aiResponse // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateJournalAiResponseRequest].
extension UpdateJournalAiResponseRequestPatterns on UpdateJournalAiResponseRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateJournalAiResponseRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateJournalAiResponseRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateJournalAiResponseRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateJournalAiResponseRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateJournalAiResponseRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateJournalAiResponseRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  bool aiResponseEnabled,  String? aiResponse)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateJournalAiResponseRequest() when $default != null:
return $default(_that.id,_that.aiResponseEnabled,_that.aiResponse);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  bool aiResponseEnabled,  String? aiResponse)  $default,) {final _that = this;
switch (_that) {
case _UpdateJournalAiResponseRequest():
return $default(_that.id,_that.aiResponseEnabled,_that.aiResponse);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  bool aiResponseEnabled,  String? aiResponse)?  $default,) {final _that = this;
switch (_that) {
case _UpdateJournalAiResponseRequest() when $default != null:
return $default(_that.id,_that.aiResponseEnabled,_that.aiResponse);case _:
  return null;

}
}

}

/// @nodoc


class _UpdateJournalAiResponseRequest extends UpdateJournalAiResponseRequest {
  const _UpdateJournalAiResponseRequest({required this.id, required this.aiResponseEnabled, required this.aiResponse}): super._();
  

@override final  int id;
@override final  bool aiResponseEnabled;
@override final  String? aiResponse;

/// Create a copy of UpdateJournalAiResponseRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateJournalAiResponseRequestCopyWith<_UpdateJournalAiResponseRequest> get copyWith => __$UpdateJournalAiResponseRequestCopyWithImpl<_UpdateJournalAiResponseRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateJournalAiResponseRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.aiResponseEnabled, aiResponseEnabled) || other.aiResponseEnabled == aiResponseEnabled)&&(identical(other.aiResponse, aiResponse) || other.aiResponse == aiResponse));
}


@override
int get hashCode => Object.hash(runtimeType,id,aiResponseEnabled,aiResponse);

@override
String toString() {
  return 'UpdateJournalAiResponseRequest(id: $id, aiResponseEnabled: $aiResponseEnabled, aiResponse: $aiResponse)';
}


}

/// @nodoc
abstract mixin class _$UpdateJournalAiResponseRequestCopyWith<$Res> implements $UpdateJournalAiResponseRequestCopyWith<$Res> {
  factory _$UpdateJournalAiResponseRequestCopyWith(_UpdateJournalAiResponseRequest value, $Res Function(_UpdateJournalAiResponseRequest) _then) = __$UpdateJournalAiResponseRequestCopyWithImpl;
@override @useResult
$Res call({
 int id, bool aiResponseEnabled, String? aiResponse
});




}
/// @nodoc
class __$UpdateJournalAiResponseRequestCopyWithImpl<$Res>
    implements _$UpdateJournalAiResponseRequestCopyWith<$Res> {
  __$UpdateJournalAiResponseRequestCopyWithImpl(this._self, this._then);

  final _UpdateJournalAiResponseRequest _self;
  final $Res Function(_UpdateJournalAiResponseRequest) _then;

/// Create a copy of UpdateJournalAiResponseRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? aiResponseEnabled = null,Object? aiResponse = freezed,}) {
  return _then(_UpdateJournalAiResponseRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,aiResponseEnabled: null == aiResponseEnabled ? _self.aiResponseEnabled : aiResponseEnabled // ignore: cast_nullable_to_non_nullable
as bool,aiResponse: freezed == aiResponse ? _self.aiResponse : aiResponse // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
