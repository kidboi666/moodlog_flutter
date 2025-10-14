// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backup_journal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BackupJournal {

 int get id; String get moodType; DateTime get createdAt; bool get aiResponseEnabled; String? get content; List<String>? get imageUri; String? get aiResponse; double? get latitude; double? get longitude; String? get address; double? get temperature; String? get weatherIcon; String? get weatherDescription; List<String>? get tagNames;
/// Create a copy of BackupJournal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackupJournalCopyWith<BackupJournal> get copyWith => _$BackupJournalCopyWithImpl<BackupJournal>(this as BackupJournal, _$identity);

  /// Serializes this BackupJournal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupJournal&&(identical(other.id, id) || other.id == id)&&(identical(other.moodType, moodType) || other.moodType == moodType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.aiResponseEnabled, aiResponseEnabled) || other.aiResponseEnabled == aiResponseEnabled)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other.imageUri, imageUri)&&(identical(other.aiResponse, aiResponse) || other.aiResponse == aiResponse)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.address, address) || other.address == address)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.weatherIcon, weatherIcon) || other.weatherIcon == weatherIcon)&&(identical(other.weatherDescription, weatherDescription) || other.weatherDescription == weatherDescription)&&const DeepCollectionEquality().equals(other.tagNames, tagNames));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,moodType,createdAt,aiResponseEnabled,content,const DeepCollectionEquality().hash(imageUri),aiResponse,latitude,longitude,address,temperature,weatherIcon,weatherDescription,const DeepCollectionEquality().hash(tagNames));

@override
String toString() {
  return 'BackupJournal(id: $id, moodType: $moodType, createdAt: $createdAt, aiResponseEnabled: $aiResponseEnabled, content: $content, imageUri: $imageUri, aiResponse: $aiResponse, latitude: $latitude, longitude: $longitude, address: $address, temperature: $temperature, weatherIcon: $weatherIcon, weatherDescription: $weatherDescription, tagNames: $tagNames)';
}


}

/// @nodoc
abstract mixin class $BackupJournalCopyWith<$Res>  {
  factory $BackupJournalCopyWith(BackupJournal value, $Res Function(BackupJournal) _then) = _$BackupJournalCopyWithImpl;
@useResult
$Res call({
 int id, String moodType, DateTime createdAt, bool aiResponseEnabled, String? content, List<String>? imageUri, String? aiResponse, double? latitude, double? longitude, String? address, double? temperature, String? weatherIcon, String? weatherDescription, List<String>? tagNames
});




}
/// @nodoc
class _$BackupJournalCopyWithImpl<$Res>
    implements $BackupJournalCopyWith<$Res> {
  _$BackupJournalCopyWithImpl(this._self, this._then);

  final BackupJournal _self;
  final $Res Function(BackupJournal) _then;

/// Create a copy of BackupJournal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? moodType = null,Object? createdAt = null,Object? aiResponseEnabled = null,Object? content = freezed,Object? imageUri = freezed,Object? aiResponse = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? address = freezed,Object? temperature = freezed,Object? weatherIcon = freezed,Object? weatherDescription = freezed,Object? tagNames = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,moodType: null == moodType ? _self.moodType : moodType // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,aiResponseEnabled: null == aiResponseEnabled ? _self.aiResponseEnabled : aiResponseEnabled // ignore: cast_nullable_to_non_nullable
as bool,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,imageUri: freezed == imageUri ? _self.imageUri : imageUri // ignore: cast_nullable_to_non_nullable
as List<String>?,aiResponse: freezed == aiResponse ? _self.aiResponse : aiResponse // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double?,weatherIcon: freezed == weatherIcon ? _self.weatherIcon : weatherIcon // ignore: cast_nullable_to_non_nullable
as String?,weatherDescription: freezed == weatherDescription ? _self.weatherDescription : weatherDescription // ignore: cast_nullable_to_non_nullable
as String?,tagNames: freezed == tagNames ? _self.tagNames : tagNames // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [BackupJournal].
extension BackupJournalPatterns on BackupJournal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BackupJournal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BackupJournal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BackupJournal value)  $default,){
final _that = this;
switch (_that) {
case _BackupJournal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BackupJournal value)?  $default,){
final _that = this;
switch (_that) {
case _BackupJournal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String moodType,  DateTime createdAt,  bool aiResponseEnabled,  String? content,  List<String>? imageUri,  String? aiResponse,  double? latitude,  double? longitude,  String? address,  double? temperature,  String? weatherIcon,  String? weatherDescription,  List<String>? tagNames)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BackupJournal() when $default != null:
return $default(_that.id,_that.moodType,_that.createdAt,_that.aiResponseEnabled,_that.content,_that.imageUri,_that.aiResponse,_that.latitude,_that.longitude,_that.address,_that.temperature,_that.weatherIcon,_that.weatherDescription,_that.tagNames);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String moodType,  DateTime createdAt,  bool aiResponseEnabled,  String? content,  List<String>? imageUri,  String? aiResponse,  double? latitude,  double? longitude,  String? address,  double? temperature,  String? weatherIcon,  String? weatherDescription,  List<String>? tagNames)  $default,) {final _that = this;
switch (_that) {
case _BackupJournal():
return $default(_that.id,_that.moodType,_that.createdAt,_that.aiResponseEnabled,_that.content,_that.imageUri,_that.aiResponse,_that.latitude,_that.longitude,_that.address,_that.temperature,_that.weatherIcon,_that.weatherDescription,_that.tagNames);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String moodType,  DateTime createdAt,  bool aiResponseEnabled,  String? content,  List<String>? imageUri,  String? aiResponse,  double? latitude,  double? longitude,  String? address,  double? temperature,  String? weatherIcon,  String? weatherDescription,  List<String>? tagNames)?  $default,) {final _that = this;
switch (_that) {
case _BackupJournal() when $default != null:
return $default(_that.id,_that.moodType,_that.createdAt,_that.aiResponseEnabled,_that.content,_that.imageUri,_that.aiResponse,_that.latitude,_that.longitude,_that.address,_that.temperature,_that.weatherIcon,_that.weatherDescription,_that.tagNames);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BackupJournal implements BackupJournal {
  const _BackupJournal({required this.id, required this.moodType, required this.createdAt, required this.aiResponseEnabled, this.content, final  List<String>? imageUri, this.aiResponse, this.latitude, this.longitude, this.address, this.temperature, this.weatherIcon, this.weatherDescription, final  List<String>? tagNames}): _imageUri = imageUri,_tagNames = tagNames;
  factory _BackupJournal.fromJson(Map<String, dynamic> json) => _$BackupJournalFromJson(json);

@override final  int id;
@override final  String moodType;
@override final  DateTime createdAt;
@override final  bool aiResponseEnabled;
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
@override final  double? temperature;
@override final  String? weatherIcon;
@override final  String? weatherDescription;
 final  List<String>? _tagNames;
@override List<String>? get tagNames {
  final value = _tagNames;
  if (value == null) return null;
  if (_tagNames is EqualUnmodifiableListView) return _tagNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of BackupJournal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BackupJournalCopyWith<_BackupJournal> get copyWith => __$BackupJournalCopyWithImpl<_BackupJournal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BackupJournalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackupJournal&&(identical(other.id, id) || other.id == id)&&(identical(other.moodType, moodType) || other.moodType == moodType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.aiResponseEnabled, aiResponseEnabled) || other.aiResponseEnabled == aiResponseEnabled)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other._imageUri, _imageUri)&&(identical(other.aiResponse, aiResponse) || other.aiResponse == aiResponse)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.address, address) || other.address == address)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.weatherIcon, weatherIcon) || other.weatherIcon == weatherIcon)&&(identical(other.weatherDescription, weatherDescription) || other.weatherDescription == weatherDescription)&&const DeepCollectionEquality().equals(other._tagNames, _tagNames));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,moodType,createdAt,aiResponseEnabled,content,const DeepCollectionEquality().hash(_imageUri),aiResponse,latitude,longitude,address,temperature,weatherIcon,weatherDescription,const DeepCollectionEquality().hash(_tagNames));

@override
String toString() {
  return 'BackupJournal(id: $id, moodType: $moodType, createdAt: $createdAt, aiResponseEnabled: $aiResponseEnabled, content: $content, imageUri: $imageUri, aiResponse: $aiResponse, latitude: $latitude, longitude: $longitude, address: $address, temperature: $temperature, weatherIcon: $weatherIcon, weatherDescription: $weatherDescription, tagNames: $tagNames)';
}


}

/// @nodoc
abstract mixin class _$BackupJournalCopyWith<$Res> implements $BackupJournalCopyWith<$Res> {
  factory _$BackupJournalCopyWith(_BackupJournal value, $Res Function(_BackupJournal) _then) = __$BackupJournalCopyWithImpl;
@override @useResult
$Res call({
 int id, String moodType, DateTime createdAt, bool aiResponseEnabled, String? content, List<String>? imageUri, String? aiResponse, double? latitude, double? longitude, String? address, double? temperature, String? weatherIcon, String? weatherDescription, List<String>? tagNames
});




}
/// @nodoc
class __$BackupJournalCopyWithImpl<$Res>
    implements _$BackupJournalCopyWith<$Res> {
  __$BackupJournalCopyWithImpl(this._self, this._then);

  final _BackupJournal _self;
  final $Res Function(_BackupJournal) _then;

/// Create a copy of BackupJournal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? moodType = null,Object? createdAt = null,Object? aiResponseEnabled = null,Object? content = freezed,Object? imageUri = freezed,Object? aiResponse = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? address = freezed,Object? temperature = freezed,Object? weatherIcon = freezed,Object? weatherDescription = freezed,Object? tagNames = freezed,}) {
  return _then(_BackupJournal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,moodType: null == moodType ? _self.moodType : moodType // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,aiResponseEnabled: null == aiResponseEnabled ? _self.aiResponseEnabled : aiResponseEnabled // ignore: cast_nullable_to_non_nullable
as bool,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,imageUri: freezed == imageUri ? _self._imageUri : imageUri // ignore: cast_nullable_to_non_nullable
as List<String>?,aiResponse: freezed == aiResponse ? _self.aiResponse : aiResponse // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double?,weatherIcon: freezed == weatherIcon ? _self.weatherIcon : weatherIcon // ignore: cast_nullable_to_non_nullable
as String?,weatherDescription: freezed == weatherDescription ? _self.weatherDescription : weatherDescription // ignore: cast_nullable_to_non_nullable
as String?,tagNames: freezed == tagNames ? _self._tagNames : tagNames // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
