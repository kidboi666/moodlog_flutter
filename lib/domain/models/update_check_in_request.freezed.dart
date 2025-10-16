// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_check_in_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UpdateCheckInRequest {

 int get id; MoodType get moodType; int? get sleepQuality; List<String>? get emotionNames; List<String>? get tagNames; String? get memo; double? get latitude; double? get longitude; String? get address; double? get temperature; String? get weatherIcon; String? get weatherDescription;
/// Create a copy of UpdateCheckInRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateCheckInRequestCopyWith<UpdateCheckInRequest> get copyWith => _$UpdateCheckInRequestCopyWithImpl<UpdateCheckInRequest>(this as UpdateCheckInRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateCheckInRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.moodType, moodType) || other.moodType == moodType)&&(identical(other.sleepQuality, sleepQuality) || other.sleepQuality == sleepQuality)&&const DeepCollectionEquality().equals(other.emotionNames, emotionNames)&&const DeepCollectionEquality().equals(other.tagNames, tagNames)&&(identical(other.memo, memo) || other.memo == memo)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.address, address) || other.address == address)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.weatherIcon, weatherIcon) || other.weatherIcon == weatherIcon)&&(identical(other.weatherDescription, weatherDescription) || other.weatherDescription == weatherDescription));
}


@override
int get hashCode => Object.hash(runtimeType,id,moodType,sleepQuality,const DeepCollectionEquality().hash(emotionNames),const DeepCollectionEquality().hash(tagNames),memo,latitude,longitude,address,temperature,weatherIcon,weatherDescription);

@override
String toString() {
  return 'UpdateCheckInRequest(id: $id, moodType: $moodType, sleepQuality: $sleepQuality, emotionNames: $emotionNames, tagNames: $tagNames, memo: $memo, latitude: $latitude, longitude: $longitude, address: $address, temperature: $temperature, weatherIcon: $weatherIcon, weatherDescription: $weatherDescription)';
}


}

/// @nodoc
abstract mixin class $UpdateCheckInRequestCopyWith<$Res>  {
  factory $UpdateCheckInRequestCopyWith(UpdateCheckInRequest value, $Res Function(UpdateCheckInRequest) _then) = _$UpdateCheckInRequestCopyWithImpl;
@useResult
$Res call({
 int id, MoodType moodType, int? sleepQuality, List<String>? emotionNames, List<String>? tagNames, String? memo, double? latitude, double? longitude, String? address, double? temperature, String? weatherIcon, String? weatherDescription
});




}
/// @nodoc
class _$UpdateCheckInRequestCopyWithImpl<$Res>
    implements $UpdateCheckInRequestCopyWith<$Res> {
  _$UpdateCheckInRequestCopyWithImpl(this._self, this._then);

  final UpdateCheckInRequest _self;
  final $Res Function(UpdateCheckInRequest) _then;

/// Create a copy of UpdateCheckInRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? moodType = null,Object? sleepQuality = freezed,Object? emotionNames = freezed,Object? tagNames = freezed,Object? memo = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? address = freezed,Object? temperature = freezed,Object? weatherIcon = freezed,Object? weatherDescription = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,moodType: null == moodType ? _self.moodType : moodType // ignore: cast_nullable_to_non_nullable
as MoodType,sleepQuality: freezed == sleepQuality ? _self.sleepQuality : sleepQuality // ignore: cast_nullable_to_non_nullable
as int?,emotionNames: freezed == emotionNames ? _self.emotionNames : emotionNames // ignore: cast_nullable_to_non_nullable
as List<String>?,tagNames: freezed == tagNames ? _self.tagNames : tagNames // ignore: cast_nullable_to_non_nullable
as List<String>?,memo: freezed == memo ? _self.memo : memo // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double?,weatherIcon: freezed == weatherIcon ? _self.weatherIcon : weatherIcon // ignore: cast_nullable_to_non_nullable
as String?,weatherDescription: freezed == weatherDescription ? _self.weatherDescription : weatherDescription // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateCheckInRequest].
extension UpdateCheckInRequestPatterns on UpdateCheckInRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateCheckInRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateCheckInRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateCheckInRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateCheckInRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateCheckInRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateCheckInRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  MoodType moodType,  int? sleepQuality,  List<String>? emotionNames,  List<String>? tagNames,  String? memo,  double? latitude,  double? longitude,  String? address,  double? temperature,  String? weatherIcon,  String? weatherDescription)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateCheckInRequest() when $default != null:
return $default(_that.id,_that.moodType,_that.sleepQuality,_that.emotionNames,_that.tagNames,_that.memo,_that.latitude,_that.longitude,_that.address,_that.temperature,_that.weatherIcon,_that.weatherDescription);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  MoodType moodType,  int? sleepQuality,  List<String>? emotionNames,  List<String>? tagNames,  String? memo,  double? latitude,  double? longitude,  String? address,  double? temperature,  String? weatherIcon,  String? weatherDescription)  $default,) {final _that = this;
switch (_that) {
case _UpdateCheckInRequest():
return $default(_that.id,_that.moodType,_that.sleepQuality,_that.emotionNames,_that.tagNames,_that.memo,_that.latitude,_that.longitude,_that.address,_that.temperature,_that.weatherIcon,_that.weatherDescription);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  MoodType moodType,  int? sleepQuality,  List<String>? emotionNames,  List<String>? tagNames,  String? memo,  double? latitude,  double? longitude,  String? address,  double? temperature,  String? weatherIcon,  String? weatherDescription)?  $default,) {final _that = this;
switch (_that) {
case _UpdateCheckInRequest() when $default != null:
return $default(_that.id,_that.moodType,_that.sleepQuality,_that.emotionNames,_that.tagNames,_that.memo,_that.latitude,_that.longitude,_that.address,_that.temperature,_that.weatherIcon,_that.weatherDescription);case _:
  return null;

}
}

}

/// @nodoc


class _UpdateCheckInRequest extends UpdateCheckInRequest {
  const _UpdateCheckInRequest({required this.id, required this.moodType, this.sleepQuality, final  List<String>? emotionNames, final  List<String>? tagNames, this.memo, this.latitude, this.longitude, this.address, this.temperature, this.weatherIcon, this.weatherDescription}): _emotionNames = emotionNames,_tagNames = tagNames,super._();
  

@override final  int id;
@override final  MoodType moodType;
@override final  int? sleepQuality;
 final  List<String>? _emotionNames;
@override List<String>? get emotionNames {
  final value = _emotionNames;
  if (value == null) return null;
  if (_emotionNames is EqualUnmodifiableListView) return _emotionNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _tagNames;
@override List<String>? get tagNames {
  final value = _tagNames;
  if (value == null) return null;
  if (_tagNames is EqualUnmodifiableListView) return _tagNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? memo;
@override final  double? latitude;
@override final  double? longitude;
@override final  String? address;
@override final  double? temperature;
@override final  String? weatherIcon;
@override final  String? weatherDescription;

/// Create a copy of UpdateCheckInRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateCheckInRequestCopyWith<_UpdateCheckInRequest> get copyWith => __$UpdateCheckInRequestCopyWithImpl<_UpdateCheckInRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateCheckInRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.moodType, moodType) || other.moodType == moodType)&&(identical(other.sleepQuality, sleepQuality) || other.sleepQuality == sleepQuality)&&const DeepCollectionEquality().equals(other._emotionNames, _emotionNames)&&const DeepCollectionEquality().equals(other._tagNames, _tagNames)&&(identical(other.memo, memo) || other.memo == memo)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.address, address) || other.address == address)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.weatherIcon, weatherIcon) || other.weatherIcon == weatherIcon)&&(identical(other.weatherDescription, weatherDescription) || other.weatherDescription == weatherDescription));
}


@override
int get hashCode => Object.hash(runtimeType,id,moodType,sleepQuality,const DeepCollectionEquality().hash(_emotionNames),const DeepCollectionEquality().hash(_tagNames),memo,latitude,longitude,address,temperature,weatherIcon,weatherDescription);

@override
String toString() {
  return 'UpdateCheckInRequest(id: $id, moodType: $moodType, sleepQuality: $sleepQuality, emotionNames: $emotionNames, tagNames: $tagNames, memo: $memo, latitude: $latitude, longitude: $longitude, address: $address, temperature: $temperature, weatherIcon: $weatherIcon, weatherDescription: $weatherDescription)';
}


}

/// @nodoc
abstract mixin class _$UpdateCheckInRequestCopyWith<$Res> implements $UpdateCheckInRequestCopyWith<$Res> {
  factory _$UpdateCheckInRequestCopyWith(_UpdateCheckInRequest value, $Res Function(_UpdateCheckInRequest) _then) = __$UpdateCheckInRequestCopyWithImpl;
@override @useResult
$Res call({
 int id, MoodType moodType, int? sleepQuality, List<String>? emotionNames, List<String>? tagNames, String? memo, double? latitude, double? longitude, String? address, double? temperature, String? weatherIcon, String? weatherDescription
});




}
/// @nodoc
class __$UpdateCheckInRequestCopyWithImpl<$Res>
    implements _$UpdateCheckInRequestCopyWith<$Res> {
  __$UpdateCheckInRequestCopyWithImpl(this._self, this._then);

  final _UpdateCheckInRequest _self;
  final $Res Function(_UpdateCheckInRequest) _then;

/// Create a copy of UpdateCheckInRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? moodType = null,Object? sleepQuality = freezed,Object? emotionNames = freezed,Object? tagNames = freezed,Object? memo = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? address = freezed,Object? temperature = freezed,Object? weatherIcon = freezed,Object? weatherDescription = freezed,}) {
  return _then(_UpdateCheckInRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,moodType: null == moodType ? _self.moodType : moodType // ignore: cast_nullable_to_non_nullable
as MoodType,sleepQuality: freezed == sleepQuality ? _self.sleepQuality : sleepQuality // ignore: cast_nullable_to_non_nullable
as int?,emotionNames: freezed == emotionNames ? _self._emotionNames : emotionNames // ignore: cast_nullable_to_non_nullable
as List<String>?,tagNames: freezed == tagNames ? _self._tagNames : tagNames // ignore: cast_nullable_to_non_nullable
as List<String>?,memo: freezed == memo ? _self.memo : memo // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double?,weatherIcon: freezed == weatherIcon ? _self.weatherIcon : weatherIcon // ignore: cast_nullable_to_non_nullable
as String?,weatherDescription: freezed == weatherDescription ? _self.weatherDescription : weatherDescription // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
