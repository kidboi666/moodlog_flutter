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

 int get id; MoodType get moodType; String? get content; List<String>? get imageUri; bool get aiResponseEnabled; double? get latitude; double? get longitude; String? get address; List<String>? get tagNames; List<String>? get emotionNames; int? get sleepQuality; double? get temperature; String? get weatherIcon; String? get weatherDescription;
/// Create a copy of UpdateJournalRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateJournalRequestCopyWith<UpdateJournalRequest> get copyWith => _$UpdateJournalRequestCopyWithImpl<UpdateJournalRequest>(this as UpdateJournalRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateJournalRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.moodType, moodType) || other.moodType == moodType)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other.imageUri, imageUri)&&(identical(other.aiResponseEnabled, aiResponseEnabled) || other.aiResponseEnabled == aiResponseEnabled)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.address, address) || other.address == address)&&const DeepCollectionEquality().equals(other.tagNames, tagNames)&&const DeepCollectionEquality().equals(other.emotionNames, emotionNames)&&(identical(other.sleepQuality, sleepQuality) || other.sleepQuality == sleepQuality)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.weatherIcon, weatherIcon) || other.weatherIcon == weatherIcon)&&(identical(other.weatherDescription, weatherDescription) || other.weatherDescription == weatherDescription));
}


@override
int get hashCode => Object.hash(runtimeType,id,moodType,content,const DeepCollectionEquality().hash(imageUri),aiResponseEnabled,latitude,longitude,address,const DeepCollectionEquality().hash(tagNames),const DeepCollectionEquality().hash(emotionNames),sleepQuality,temperature,weatherIcon,weatherDescription);

@override
String toString() {
  return 'UpdateJournalRequest(id: $id, moodType: $moodType, content: $content, imageUri: $imageUri, aiResponseEnabled: $aiResponseEnabled, latitude: $latitude, longitude: $longitude, address: $address, tagNames: $tagNames, emotionNames: $emotionNames, sleepQuality: $sleepQuality, temperature: $temperature, weatherIcon: $weatherIcon, weatherDescription: $weatherDescription)';
}


}

/// @nodoc
abstract mixin class $UpdateJournalRequestCopyWith<$Res>  {
  factory $UpdateJournalRequestCopyWith(UpdateJournalRequest value, $Res Function(UpdateJournalRequest) _then) = _$UpdateJournalRequestCopyWithImpl;
@useResult
$Res call({
 int id, MoodType moodType, String? content, List<String>? imageUri, bool aiResponseEnabled, double? latitude, double? longitude, String? address, List<String>? tagNames, List<String>? emotionNames, int? sleepQuality, double? temperature, String? weatherIcon, String? weatherDescription
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? moodType = null,Object? content = freezed,Object? imageUri = freezed,Object? aiResponseEnabled = null,Object? latitude = freezed,Object? longitude = freezed,Object? address = freezed,Object? tagNames = freezed,Object? emotionNames = freezed,Object? sleepQuality = freezed,Object? temperature = freezed,Object? weatherIcon = freezed,Object? weatherDescription = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,moodType: null == moodType ? _self.moodType : moodType // ignore: cast_nullable_to_non_nullable
as MoodType,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,imageUri: freezed == imageUri ? _self.imageUri : imageUri // ignore: cast_nullable_to_non_nullable
as List<String>?,aiResponseEnabled: null == aiResponseEnabled ? _self.aiResponseEnabled : aiResponseEnabled // ignore: cast_nullable_to_non_nullable
as bool,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,tagNames: freezed == tagNames ? _self.tagNames : tagNames // ignore: cast_nullable_to_non_nullable
as List<String>?,emotionNames: freezed == emotionNames ? _self.emotionNames : emotionNames // ignore: cast_nullable_to_non_nullable
as List<String>?,sleepQuality: freezed == sleepQuality ? _self.sleepQuality : sleepQuality // ignore: cast_nullable_to_non_nullable
as int?,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double?,weatherIcon: freezed == weatherIcon ? _self.weatherIcon : weatherIcon // ignore: cast_nullable_to_non_nullable
as String?,weatherDescription: freezed == weatherDescription ? _self.weatherDescription : weatherDescription // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  MoodType moodType,  String? content,  List<String>? imageUri,  bool aiResponseEnabled,  double? latitude,  double? longitude,  String? address,  List<String>? tagNames,  List<String>? emotionNames,  int? sleepQuality,  double? temperature,  String? weatherIcon,  String? weatherDescription)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateJournalRequest() when $default != null:
return $default(_that.id,_that.moodType,_that.content,_that.imageUri,_that.aiResponseEnabled,_that.latitude,_that.longitude,_that.address,_that.tagNames,_that.emotionNames,_that.sleepQuality,_that.temperature,_that.weatherIcon,_that.weatherDescription);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  MoodType moodType,  String? content,  List<String>? imageUri,  bool aiResponseEnabled,  double? latitude,  double? longitude,  String? address,  List<String>? tagNames,  List<String>? emotionNames,  int? sleepQuality,  double? temperature,  String? weatherIcon,  String? weatherDescription)  $default,) {final _that = this;
switch (_that) {
case _UpdateJournalRequest():
return $default(_that.id,_that.moodType,_that.content,_that.imageUri,_that.aiResponseEnabled,_that.latitude,_that.longitude,_that.address,_that.tagNames,_that.emotionNames,_that.sleepQuality,_that.temperature,_that.weatherIcon,_that.weatherDescription);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  MoodType moodType,  String? content,  List<String>? imageUri,  bool aiResponseEnabled,  double? latitude,  double? longitude,  String? address,  List<String>? tagNames,  List<String>? emotionNames,  int? sleepQuality,  double? temperature,  String? weatherIcon,  String? weatherDescription)?  $default,) {final _that = this;
switch (_that) {
case _UpdateJournalRequest() when $default != null:
return $default(_that.id,_that.moodType,_that.content,_that.imageUri,_that.aiResponseEnabled,_that.latitude,_that.longitude,_that.address,_that.tagNames,_that.emotionNames,_that.sleepQuality,_that.temperature,_that.weatherIcon,_that.weatherDescription);case _:
  return null;

}
}

}

/// @nodoc


class _UpdateJournalRequest extends UpdateJournalRequest {
  const _UpdateJournalRequest({required this.id, required this.moodType, this.content, final  List<String>? imageUri, required this.aiResponseEnabled, this.latitude, this.longitude, this.address, final  List<String>? tagNames, final  List<String>? emotionNames, this.sleepQuality, this.temperature, this.weatherIcon, this.weatherDescription}): _imageUri = imageUri,_tagNames = tagNames,_emotionNames = emotionNames,super._();
  

@override final  int id;
@override final  MoodType moodType;
@override final  String? content;
 final  List<String>? _imageUri;
@override List<String>? get imageUri {
  final value = _imageUri;
  if (value == null) return null;
  if (_imageUri is EqualUnmodifiableListView) return _imageUri;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  bool aiResponseEnabled;
@override final  double? latitude;
@override final  double? longitude;
@override final  String? address;
 final  List<String>? _tagNames;
@override List<String>? get tagNames {
  final value = _tagNames;
  if (value == null) return null;
  if (_tagNames is EqualUnmodifiableListView) return _tagNames;
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

@override final  int? sleepQuality;
@override final  double? temperature;
@override final  String? weatherIcon;
@override final  String? weatherDescription;

/// Create a copy of UpdateJournalRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateJournalRequestCopyWith<_UpdateJournalRequest> get copyWith => __$UpdateJournalRequestCopyWithImpl<_UpdateJournalRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateJournalRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.moodType, moodType) || other.moodType == moodType)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other._imageUri, _imageUri)&&(identical(other.aiResponseEnabled, aiResponseEnabled) || other.aiResponseEnabled == aiResponseEnabled)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.address, address) || other.address == address)&&const DeepCollectionEquality().equals(other._tagNames, _tagNames)&&const DeepCollectionEquality().equals(other._emotionNames, _emotionNames)&&(identical(other.sleepQuality, sleepQuality) || other.sleepQuality == sleepQuality)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.weatherIcon, weatherIcon) || other.weatherIcon == weatherIcon)&&(identical(other.weatherDescription, weatherDescription) || other.weatherDescription == weatherDescription));
}


@override
int get hashCode => Object.hash(runtimeType,id,moodType,content,const DeepCollectionEquality().hash(_imageUri),aiResponseEnabled,latitude,longitude,address,const DeepCollectionEquality().hash(_tagNames),const DeepCollectionEquality().hash(_emotionNames),sleepQuality,temperature,weatherIcon,weatherDescription);

@override
String toString() {
  return 'UpdateJournalRequest(id: $id, moodType: $moodType, content: $content, imageUri: $imageUri, aiResponseEnabled: $aiResponseEnabled, latitude: $latitude, longitude: $longitude, address: $address, tagNames: $tagNames, emotionNames: $emotionNames, sleepQuality: $sleepQuality, temperature: $temperature, weatherIcon: $weatherIcon, weatherDescription: $weatherDescription)';
}


}

/// @nodoc
abstract mixin class _$UpdateJournalRequestCopyWith<$Res> implements $UpdateJournalRequestCopyWith<$Res> {
  factory _$UpdateJournalRequestCopyWith(_UpdateJournalRequest value, $Res Function(_UpdateJournalRequest) _then) = __$UpdateJournalRequestCopyWithImpl;
@override @useResult
$Res call({
 int id, MoodType moodType, String? content, List<String>? imageUri, bool aiResponseEnabled, double? latitude, double? longitude, String? address, List<String>? tagNames, List<String>? emotionNames, int? sleepQuality, double? temperature, String? weatherIcon, String? weatherDescription
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? moodType = null,Object? content = freezed,Object? imageUri = freezed,Object? aiResponseEnabled = null,Object? latitude = freezed,Object? longitude = freezed,Object? address = freezed,Object? tagNames = freezed,Object? emotionNames = freezed,Object? sleepQuality = freezed,Object? temperature = freezed,Object? weatherIcon = freezed,Object? weatherDescription = freezed,}) {
  return _then(_UpdateJournalRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,moodType: null == moodType ? _self.moodType : moodType // ignore: cast_nullable_to_non_nullable
as MoodType,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,imageUri: freezed == imageUri ? _self._imageUri : imageUri // ignore: cast_nullable_to_non_nullable
as List<String>?,aiResponseEnabled: null == aiResponseEnabled ? _self.aiResponseEnabled : aiResponseEnabled // ignore: cast_nullable_to_non_nullable
as bool,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,tagNames: freezed == tagNames ? _self._tagNames : tagNames // ignore: cast_nullable_to_non_nullable
as List<String>?,emotionNames: freezed == emotionNames ? _self._emotionNames : emotionNames // ignore: cast_nullable_to_non_nullable
as List<String>?,sleepQuality: freezed == sleepQuality ? _self.sleepQuality : sleepQuality // ignore: cast_nullable_to_non_nullable
as int?,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double?,weatherIcon: freezed == weatherIcon ? _self.weatherIcon : weatherIcon // ignore: cast_nullable_to_non_nullable
as String?,weatherDescription: freezed == weatherDescription ? _self.weatherDescription : weatherDescription // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
