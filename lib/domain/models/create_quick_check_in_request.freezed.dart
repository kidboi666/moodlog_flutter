// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_quick_check_in_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateQuickCheckInRequest {

 MoodType get moodType; String? get content; List<String>? get activityNames; List<String>? get emotionNames; DateTime get createdAt; double? get latitude; double? get longitude; String? get address; double? get temperature; String? get weatherIcon; String? get weatherDescription; int? get sleepQuality;
/// Create a copy of CreateQuickCheckInRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateQuickCheckInRequestCopyWith<CreateQuickCheckInRequest> get copyWith => _$CreateQuickCheckInRequestCopyWithImpl<CreateQuickCheckInRequest>(this as CreateQuickCheckInRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateQuickCheckInRequest&&(identical(other.moodType, moodType) || other.moodType == moodType)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other.activityNames, activityNames)&&const DeepCollectionEquality().equals(other.emotionNames, emotionNames)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.address, address) || other.address == address)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.weatherIcon, weatherIcon) || other.weatherIcon == weatherIcon)&&(identical(other.weatherDescription, weatherDescription) || other.weatherDescription == weatherDescription)&&(identical(other.sleepQuality, sleepQuality) || other.sleepQuality == sleepQuality));
}


@override
int get hashCode => Object.hash(runtimeType,moodType,content,const DeepCollectionEquality().hash(activityNames),const DeepCollectionEquality().hash(emotionNames),createdAt,latitude,longitude,address,temperature,weatherIcon,weatherDescription,sleepQuality);

@override
String toString() {
  return 'CreateQuickCheckInRequest(moodType: $moodType, content: $content, activityNames: $activityNames, emotionNames: $emotionNames, createdAt: $createdAt, latitude: $latitude, longitude: $longitude, address: $address, temperature: $temperature, weatherIcon: $weatherIcon, weatherDescription: $weatherDescription, sleepQuality: $sleepQuality)';
}


}

/// @nodoc
abstract mixin class $CreateQuickCheckInRequestCopyWith<$Res>  {
  factory $CreateQuickCheckInRequestCopyWith(CreateQuickCheckInRequest value, $Res Function(CreateQuickCheckInRequest) _then) = _$CreateQuickCheckInRequestCopyWithImpl;
@useResult
$Res call({
 MoodType moodType, String? content, List<String>? activityNames, List<String>? emotionNames, DateTime createdAt, double? latitude, double? longitude, String? address, double? temperature, String? weatherIcon, String? weatherDescription, int? sleepQuality
});




}
/// @nodoc
class _$CreateQuickCheckInRequestCopyWithImpl<$Res>
    implements $CreateQuickCheckInRequestCopyWith<$Res> {
  _$CreateQuickCheckInRequestCopyWithImpl(this._self, this._then);

  final CreateQuickCheckInRequest _self;
  final $Res Function(CreateQuickCheckInRequest) _then;

/// Create a copy of CreateQuickCheckInRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? moodType = null,Object? content = freezed,Object? activityNames = freezed,Object? emotionNames = freezed,Object? createdAt = null,Object? latitude = freezed,Object? longitude = freezed,Object? address = freezed,Object? temperature = freezed,Object? weatherIcon = freezed,Object? weatherDescription = freezed,Object? sleepQuality = freezed,}) {
  return _then(_self.copyWith(
moodType: null == moodType ? _self.moodType : moodType // ignore: cast_nullable_to_non_nullable
as MoodType,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,activityNames: freezed == activityNames ? _self.activityNames : activityNames // ignore: cast_nullable_to_non_nullable
as List<String>?,emotionNames: freezed == emotionNames ? _self.emotionNames : emotionNames // ignore: cast_nullable_to_non_nullable
as List<String>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double?,weatherIcon: freezed == weatherIcon ? _self.weatherIcon : weatherIcon // ignore: cast_nullable_to_non_nullable
as String?,weatherDescription: freezed == weatherDescription ? _self.weatherDescription : weatherDescription // ignore: cast_nullable_to_non_nullable
as String?,sleepQuality: freezed == sleepQuality ? _self.sleepQuality : sleepQuality // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateQuickCheckInRequest].
extension CreateQuickCheckInRequestPatterns on CreateQuickCheckInRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateQuickCheckInRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateQuickCheckInRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateQuickCheckInRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateQuickCheckInRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateQuickCheckInRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateQuickCheckInRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MoodType moodType,  String? content,  List<String>? activityNames,  List<String>? emotionNames,  DateTime createdAt,  double? latitude,  double? longitude,  String? address,  double? temperature,  String? weatherIcon,  String? weatherDescription,  int? sleepQuality)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateQuickCheckInRequest() when $default != null:
return $default(_that.moodType,_that.content,_that.activityNames,_that.emotionNames,_that.createdAt,_that.latitude,_that.longitude,_that.address,_that.temperature,_that.weatherIcon,_that.weatherDescription,_that.sleepQuality);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MoodType moodType,  String? content,  List<String>? activityNames,  List<String>? emotionNames,  DateTime createdAt,  double? latitude,  double? longitude,  String? address,  double? temperature,  String? weatherIcon,  String? weatherDescription,  int? sleepQuality)  $default,) {final _that = this;
switch (_that) {
case _CreateQuickCheckInRequest():
return $default(_that.moodType,_that.content,_that.activityNames,_that.emotionNames,_that.createdAt,_that.latitude,_that.longitude,_that.address,_that.temperature,_that.weatherIcon,_that.weatherDescription,_that.sleepQuality);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MoodType moodType,  String? content,  List<String>? activityNames,  List<String>? emotionNames,  DateTime createdAt,  double? latitude,  double? longitude,  String? address,  double? temperature,  String? weatherIcon,  String? weatherDescription,  int? sleepQuality)?  $default,) {final _that = this;
switch (_that) {
case _CreateQuickCheckInRequest() when $default != null:
return $default(_that.moodType,_that.content,_that.activityNames,_that.emotionNames,_that.createdAt,_that.latitude,_that.longitude,_that.address,_that.temperature,_that.weatherIcon,_that.weatherDescription,_that.sleepQuality);case _:
  return null;

}
}

}

/// @nodoc


class _CreateQuickCheckInRequest extends CreateQuickCheckInRequest {
  const _CreateQuickCheckInRequest({required this.moodType, this.content, final  List<String>? activityNames, final  List<String>? emotionNames, required this.createdAt, this.latitude, this.longitude, this.address, this.temperature, this.weatherIcon, this.weatherDescription, this.sleepQuality}): _activityNames = activityNames,_emotionNames = emotionNames,super._();
  

@override final  MoodType moodType;
@override final  String? content;
 final  List<String>? _activityNames;
@override List<String>? get activityNames {
  final value = _activityNames;
  if (value == null) return null;
  if (_activityNames is EqualUnmodifiableListView) return _activityNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _emotionNames;
@override List<String>? get emotionNames {
  final value = _emotionNames;
  if (value == null) return null;
  if (_emotionNames is EqualUnmodifiableListView) return _emotionNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  DateTime createdAt;
@override final  double? latitude;
@override final  double? longitude;
@override final  String? address;
@override final  double? temperature;
@override final  String? weatherIcon;
@override final  String? weatherDescription;
@override final  int? sleepQuality;

/// Create a copy of CreateQuickCheckInRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateQuickCheckInRequestCopyWith<_CreateQuickCheckInRequest> get copyWith => __$CreateQuickCheckInRequestCopyWithImpl<_CreateQuickCheckInRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateQuickCheckInRequest&&(identical(other.moodType, moodType) || other.moodType == moodType)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other._activityNames, _activityNames)&&const DeepCollectionEquality().equals(other._emotionNames, _emotionNames)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.address, address) || other.address == address)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.weatherIcon, weatherIcon) || other.weatherIcon == weatherIcon)&&(identical(other.weatherDescription, weatherDescription) || other.weatherDescription == weatherDescription)&&(identical(other.sleepQuality, sleepQuality) || other.sleepQuality == sleepQuality));
}


@override
int get hashCode => Object.hash(runtimeType,moodType,content,const DeepCollectionEquality().hash(_activityNames),const DeepCollectionEquality().hash(_emotionNames),createdAt,latitude,longitude,address,temperature,weatherIcon,weatherDescription,sleepQuality);

@override
String toString() {
  return 'CreateQuickCheckInRequest(moodType: $moodType, content: $content, activityNames: $activityNames, emotionNames: $emotionNames, createdAt: $createdAt, latitude: $latitude, longitude: $longitude, address: $address, temperature: $temperature, weatherIcon: $weatherIcon, weatherDescription: $weatherDescription, sleepQuality: $sleepQuality)';
}


}

/// @nodoc
abstract mixin class _$CreateQuickCheckInRequestCopyWith<$Res> implements $CreateQuickCheckInRequestCopyWith<$Res> {
  factory _$CreateQuickCheckInRequestCopyWith(_CreateQuickCheckInRequest value, $Res Function(_CreateQuickCheckInRequest) _then) = __$CreateQuickCheckInRequestCopyWithImpl;
@override @useResult
$Res call({
 MoodType moodType, String? content, List<String>? activityNames, List<String>? emotionNames, DateTime createdAt, double? latitude, double? longitude, String? address, double? temperature, String? weatherIcon, String? weatherDescription, int? sleepQuality
});




}
/// @nodoc
class __$CreateQuickCheckInRequestCopyWithImpl<$Res>
    implements _$CreateQuickCheckInRequestCopyWith<$Res> {
  __$CreateQuickCheckInRequestCopyWithImpl(this._self, this._then);

  final _CreateQuickCheckInRequest _self;
  final $Res Function(_CreateQuickCheckInRequest) _then;

/// Create a copy of CreateQuickCheckInRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? moodType = null,Object? content = freezed,Object? activityNames = freezed,Object? emotionNames = freezed,Object? createdAt = null,Object? latitude = freezed,Object? longitude = freezed,Object? address = freezed,Object? temperature = freezed,Object? weatherIcon = freezed,Object? weatherDescription = freezed,Object? sleepQuality = freezed,}) {
  return _then(_CreateQuickCheckInRequest(
moodType: null == moodType ? _self.moodType : moodType // ignore: cast_nullable_to_non_nullable
as MoodType,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,activityNames: freezed == activityNames ? _self._activityNames : activityNames // ignore: cast_nullable_to_non_nullable
as List<String>?,emotionNames: freezed == emotionNames ? _self._emotionNames : emotionNames // ignore: cast_nullable_to_non_nullable
as List<String>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double?,weatherIcon: freezed == weatherIcon ? _self.weatherIcon : weatherIcon // ignore: cast_nullable_to_non_nullable
as String?,weatherDescription: freezed == weatherDescription ? _self.weatherDescription : weatherDescription // ignore: cast_nullable_to_non_nullable
as String?,sleepQuality: freezed == sleepQuality ? _self.sleepQuality : sleepQuality // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
