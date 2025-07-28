// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_journal_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateJournalRequest {

 int get id; String? get content; List<String>? get imageUri; String? get aiResponse; double? get latitude; double? get longitude; String? get address;
/// Create a copy of UpdateJournalRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateJournalRequestCopyWith<UpdateJournalRequest> get copyWith => _$UpdateJournalRequestCopyWithImpl<UpdateJournalRequest>(this as UpdateJournalRequest, _$identity);

  /// Serializes this UpdateJournalRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateJournalRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other.imageUri, imageUri)&&(identical(other.aiResponse, aiResponse) || other.aiResponse == aiResponse)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,const DeepCollectionEquality().hash(imageUri),aiResponse,latitude,longitude,address);

@override
String toString() {
  return 'UpdateJournalRequest(id: $id, content: $content, imageUri: $imageUri, aiResponse: $aiResponse, latitude: $latitude, longitude: $longitude, address: $address)';
}


}

/// @nodoc
abstract mixin class $UpdateJournalRequestCopyWith<$Res>  {
  factory $UpdateJournalRequestCopyWith(UpdateJournalRequest value, $Res Function(UpdateJournalRequest) _then) = _$UpdateJournalRequestCopyWithImpl;
@useResult
$Res call({
 int id, String? content, List<String>? imageUri, String? aiResponse, double? latitude, double? longitude, String? address
});




}
/// @nodoc
class _$UpdateJournalRequestCopyWithImpl<$Res>
    implements $UpdateJournalRequestCopyWith<$Res> {
  _$UpdateJournalRequestCopyWithImpl(this._self, this._then);

  final UpdateJournalRequest _self;
  final $Res Function(UpdateJournalRequest) _then;

/// Create a copy of UpdateJournalRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? content = freezed,Object? imageUri = freezed,Object? aiResponse = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? address = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,imageUri: freezed == imageUri ? _self.imageUri : imageUri // ignore: cast_nullable_to_non_nullable
as List<String>?,aiResponse: freezed == aiResponse ? _self.aiResponse : aiResponse // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateJournalRequest].
extension UpdateJournalRequestPatterns on UpdateJournalRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateJournalRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateJournalRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateJournalRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateJournalRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateJournalRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateJournalRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? content,  List<String>? imageUri,  String? aiResponse,  double? latitude,  double? longitude,  String? address)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateJournalRequest() when $default != null:
return $default(_that.id,_that.content,_that.imageUri,_that.aiResponse,_that.latitude,_that.longitude,_that.address);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? content,  List<String>? imageUri,  String? aiResponse,  double? latitude,  double? longitude,  String? address)  $default,) {final _that = this;
switch (_that) {
case _UpdateJournalRequest():
return $default(_that.id,_that.content,_that.imageUri,_that.aiResponse,_that.latitude,_that.longitude,_that.address);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? content,  List<String>? imageUri,  String? aiResponse,  double? latitude,  double? longitude,  String? address)?  $default,) {final _that = this;
switch (_that) {
case _UpdateJournalRequest() when $default != null:
return $default(_that.id,_that.content,_that.imageUri,_that.aiResponse,_that.latitude,_that.longitude,_that.address);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateJournalRequest implements UpdateJournalRequest {
  const _UpdateJournalRequest({required this.id, this.content, final  List<String>? imageUri, this.aiResponse, this.latitude, this.longitude, this.address}): _imageUri = imageUri;
  factory _UpdateJournalRequest.fromJson(Map<String, dynamic> json) => _$UpdateJournalRequestFromJson(json);

@override final  int id;
@override final  String? content;
 final  List<String>? _imageUri;
@override List<String>? get imageUri {
  final value = _imageUri;
  if (value == null) return null;
  if (_imageUri is EqualUnmodifiableListView) return _imageUri;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? aiResponse;
@override final  double? latitude;
@override final  double? longitude;
@override final  String? address;

/// Create a copy of UpdateJournalRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateJournalRequestCopyWith<_UpdateJournalRequest> get copyWith => __$UpdateJournalRequestCopyWithImpl<_UpdateJournalRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateJournalRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateJournalRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other._imageUri, _imageUri)&&(identical(other.aiResponse, aiResponse) || other.aiResponse == aiResponse)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,const DeepCollectionEquality().hash(_imageUri),aiResponse,latitude,longitude,address);

@override
String toString() {
  return 'UpdateJournalRequest(id: $id, content: $content, imageUri: $imageUri, aiResponse: $aiResponse, latitude: $latitude, longitude: $longitude, address: $address)';
}


}

/// @nodoc
abstract mixin class _$UpdateJournalRequestCopyWith<$Res> implements $UpdateJournalRequestCopyWith<$Res> {
  factory _$UpdateJournalRequestCopyWith(_UpdateJournalRequest value, $Res Function(_UpdateJournalRequest) _then) = __$UpdateJournalRequestCopyWithImpl;
@override @useResult
$Res call({
 int id, String? content, List<String>? imageUri, String? aiResponse, double? latitude, double? longitude, String? address
});




}
/// @nodoc
class __$UpdateJournalRequestCopyWithImpl<$Res>
    implements _$UpdateJournalRequestCopyWith<$Res> {
  __$UpdateJournalRequestCopyWithImpl(this._self, this._then);

  final _UpdateJournalRequest _self;
  final $Res Function(_UpdateJournalRequest) _then;

/// Create a copy of UpdateJournalRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? content = freezed,Object? imageUri = freezed,Object? aiResponse = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? address = freezed,}) {
  return _then(_UpdateJournalRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,imageUri: freezed == imageUri ? _self._imageUri : imageUri // ignore: cast_nullable_to_non_nullable
as List<String>?,aiResponse: freezed == aiResponse ? _self.aiResponse : aiResponse // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
