// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_journal_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateJournalRequest {

  String? get content;

  MoodType get moodType;

  List<String>? get imageUri;

  bool get aiResponseEnabled;

  List<String>? get tagNames;

  String? get aiResponse;

  DateTime get createdAt;

  double? get latitude;

  double? get longitude;

  String? get address;

  double? get temperature;

  String? get weatherIcon;

  String? get weatherDescription;

  /// Create a copy of CreateJournalRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreateJournalRequestCopyWith<CreateJournalRequest> get copyWith =>
      _$CreateJournalRequestCopyWithImpl<CreateJournalRequest>(
          this as CreateJournalRequest, _$identity);


  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CreateJournalRequest &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.moodType, moodType) ||
                other.moodType == moodType) &&
            const DeepCollectionEquality().equals(other.imageUri, imageUri) &&
            (identical(other.aiResponseEnabled, aiResponseEnabled) ||
                other.aiResponseEnabled == aiResponseEnabled) &&
            const DeepCollectionEquality().equals(other.tagNames, tagNames) &&
            (identical(other.aiResponse, aiResponse) ||
                other.aiResponse == aiResponse) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.weatherIcon, weatherIcon) ||
                other.weatherIcon == weatherIcon) &&
            (identical(other.weatherDescription, weatherDescription) ||
                other.weatherDescription == weatherDescription));
  }


  @override
  int get hashCode =>
      Object.hash(
          runtimeType,
          content,
          moodType,
          const DeepCollectionEquality().hash(imageUri),
          aiResponseEnabled,
          const DeepCollectionEquality().hash(tagNames),
          aiResponse,
          createdAt,
          latitude,
          longitude,
          address,
          temperature,
          weatherIcon,
          weatherDescription);

  @override
  String toString() {
    return 'CreateJournalRequest(content: $content, moodType: $moodType, imageUri: $imageUri, aiResponseEnabled: $aiResponseEnabled, tagNames: $tagNames, aiResponse: $aiResponse, createdAt: $createdAt, latitude: $latitude, longitude: $longitude, address: $address, temperature: $temperature, weatherIcon: $weatherIcon, weatherDescription: $weatherDescription)';
  }


}

/// @nodoc
abstract mixin class $CreateJournalRequestCopyWith<$Res> {
  factory $CreateJournalRequestCopyWith(CreateJournalRequest value,
      $Res Function(CreateJournalRequest) _then) = _$CreateJournalRequestCopyWithImpl;

  @useResult
  $Res call({
    String? content, MoodType moodType, List<
        String>? imageUri, bool aiResponseEnabled, List<
        String>? tagNames, String? aiResponse, DateTime createdAt, double? latitude, double? longitude, String? address, double? temperature, String? weatherIcon, String? weatherDescription
  });


}

/// @nodoc
class _$CreateJournalRequestCopyWithImpl<$Res>
    implements $CreateJournalRequestCopyWith<$Res> {
  _$CreateJournalRequestCopyWithImpl(this._self, this._then);

  final CreateJournalRequest _self;
  final $Res Function(CreateJournalRequest) _then;

  /// Create a copy of CreateJournalRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call(
      {Object? content = freezed, Object? moodType = null, Object? imageUri = freezed, Object? aiResponseEnabled = null, Object? tagNames = freezed, Object? aiResponse = freezed, Object? createdAt = null, Object? latitude = freezed, Object? longitude = freezed, Object? address = freezed, Object? temperature = freezed, Object? weatherIcon = freezed, Object? weatherDescription = freezed,}) {
    return _then(_self.copyWith(
      content: freezed == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
      as String?,
      moodType: null == moodType
          ? _self.moodType
          : moodType // ignore: cast_nullable_to_non_nullable
      as MoodType,
      imageUri: freezed == imageUri
          ? _self.imageUri
          : imageUri // ignore: cast_nullable_to_non_nullable
      as List<String>?,
      aiResponseEnabled: null == aiResponseEnabled
          ? _self.aiResponseEnabled
          : aiResponseEnabled // ignore: cast_nullable_to_non_nullable
      as bool,
      tagNames: freezed == tagNames
          ? _self.tagNames
          : tagNames // ignore: cast_nullable_to_non_nullable
      as List<String>?,
      aiResponse: freezed == aiResponse
          ? _self.aiResponse
          : aiResponse // ignore: cast_nullable_to_non_nullable
      as String?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
      as DateTime,
      latitude: freezed == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
      as double?,
      longitude: freezed == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
      as double?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
      as String?,
      temperature: freezed == temperature
          ? _self.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
      as double?,
      weatherIcon: freezed == weatherIcon
          ? _self.weatherIcon
          : weatherIcon // ignore: cast_nullable_to_non_nullable
      as String?,
      weatherDescription: freezed == weatherDescription
          ? _self.weatherDescription
          : weatherDescription // ignore: cast_nullable_to_non_nullable
      as String?,
    ));
  }

}


/// Adds pattern-matching-related methods to [CreateJournalRequest].
extension CreateJournalRequestPatterns on CreateJournalRequest {
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

  @optionalTypeArgs TResult maybeMap

  <

  TResult

  extends

  Object?

  >

  (

  TResult Function( _CreateJournalRequest value)? $default,{required TResult orElse(),}){
  final _that = this;
  switch (_that) {
  case _CreateJournalRequest() when $default != null:
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

  @optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateJournalRequest value) $default,){
  final _that = this;
  switch (_that) {
  case _CreateJournalRequest():
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

  @optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateJournalRequest value)? $default,){
  final _that = this;
  switch (_that) {
  case _CreateJournalRequest() when $default != null:
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

  @optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? content, MoodType moodType, List<String>? imageUri, bool aiResponseEnabled, List<String>? tagNames, String? aiResponse, DateTime createdAt, double? latitude, double? longitude, String? address, double? temperature, String? weatherIcon, String? weatherDescription)? $default,{required TResult orElse(),}) {final _that = this;
  switch (_that) {
  case _CreateJournalRequest() when $default != null:
  return $default(_that.content,_that.moodType,_that.imageUri,_that.aiResponseEnabled,_that.tagNames,_that.aiResponse,_that.createdAt,_that.latitude,_that.longitude,_that.address,_that.temperature,_that.weatherIcon,_that.weatherDescription);case _:
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

  @optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? content, MoodType moodType, List<String>? imageUri, bool aiResponseEnabled, List<String>? tagNames, String? aiResponse, DateTime createdAt, double? latitude, double? longitude, String? address, double? temperature, String? weatherIcon, String? weatherDescription) $default,) {final _that = this;
  switch (_that) {
  case _CreateJournalRequest():
  return $default(_that.content,_that.moodType,_that.imageUri,_that.aiResponseEnabled,_that.tagNames,_that.aiResponse,_that.createdAt,_that.latitude,_that.longitude,_that.address,_that.temperature,_that.weatherIcon,_that.weatherDescription);case _:
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

  @optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? content, MoodType moodType, List<String>? imageUri, bool aiResponseEnabled, List<String>? tagNames, String? aiResponse, DateTime createdAt, double? latitude, double? longitude, String? address, double? temperature, String? weatherIcon, String? weatherDescription)? $default,) {final _that = this;
  switch (_that) {
  case _CreateJournalRequest() when $default != null:
  return $default(_that.content,_that.moodType,_that.imageUri,_that.aiResponseEnabled,_that.tagNames,_that.aiResponse,_that.createdAt,_that.latitude,_that.longitude,_that.address,_that.temperature,_that.weatherIcon,_that.weatherDescription);case _:
  return null;

  }
  }

}

/// @nodoc


class _CreateJournalRequest extends CreateJournalRequest {
  const _CreateJournalRequest({this.content, required this.moodType, final List<
      String>? imageUri, required this.aiResponseEnabled, final List<
      String>? tagNames, this.aiResponse, required this.createdAt, this.latitude, this.longitude, this.address, this.temperature, this.weatherIcon, this.weatherDescription})
      : _imageUri = imageUri,
        _tagNames = tagNames,
        super._();


  @override final String? content;
  @override final MoodType moodType;
  final List<String>? _imageUri;

  @override List<String>? get imageUri {
    final value = _imageUri;
    if (value == null) return null;
    if (_imageUri is EqualUnmodifiableListView) return _imageUri;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override final bool aiResponseEnabled;
  final List<String>? _tagNames;

  @override List<String>? get tagNames {
    final value = _tagNames;
    if (value == null) return null;
    if (_tagNames is EqualUnmodifiableListView) return _tagNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override final String? aiResponse;
  @override final DateTime createdAt;
  @override final double? latitude;
  @override final double? longitude;
  @override final String? address;
  @override final double? temperature;
  @override final String? weatherIcon;
  @override final String? weatherDescription;

  /// Create a copy of CreateJournalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CreateJournalRequestCopyWith<_CreateJournalRequest> get copyWith =>
      __$CreateJournalRequestCopyWithImpl<_CreateJournalRequest>(
          this, _$identity);


  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _CreateJournalRequest &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.moodType, moodType) ||
                other.moodType == moodType) &&
            const DeepCollectionEquality().equals(other._imageUri, _imageUri) &&
            (identical(other.aiResponseEnabled, aiResponseEnabled) ||
                other.aiResponseEnabled == aiResponseEnabled) &&
            const DeepCollectionEquality().equals(other._tagNames, _tagNames) &&
            (identical(other.aiResponse, aiResponse) ||
                other.aiResponse == aiResponse) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.weatherIcon, weatherIcon) ||
                other.weatherIcon == weatherIcon) &&
            (identical(other.weatherDescription, weatherDescription) ||
                other.weatherDescription == weatherDescription));
  }


  @override
  int get hashCode =>
      Object.hash(
          runtimeType,
          content,
          moodType,
          const DeepCollectionEquality().hash(_imageUri),
          aiResponseEnabled,
          const DeepCollectionEquality().hash(_tagNames),
          aiResponse,
          createdAt,
          latitude,
          longitude,
          address,
          temperature,
          weatherIcon,
          weatherDescription);

  @override
  String toString() {
    return 'CreateJournalRequest(content: $content, moodType: $moodType, imageUri: $imageUri, aiResponseEnabled: $aiResponseEnabled, tagNames: $tagNames, aiResponse: $aiResponse, createdAt: $createdAt, latitude: $latitude, longitude: $longitude, address: $address, temperature: $temperature, weatherIcon: $weatherIcon, weatherDescription: $weatherDescription)';
  }


}

/// @nodoc
abstract mixin class _$CreateJournalRequestCopyWith<$Res>
    implements $CreateJournalRequestCopyWith<$Res> {
  factory _$CreateJournalRequestCopyWith(_CreateJournalRequest value,
      $Res Function(_CreateJournalRequest) _then) = __$CreateJournalRequestCopyWithImpl;

  @override
  @useResult
  $Res call({
    String? content, MoodType moodType, List<
        String>? imageUri, bool aiResponseEnabled, List<
        String>? tagNames, String? aiResponse, DateTime createdAt, double? latitude, double? longitude, String? address, double? temperature, String? weatherIcon, String? weatherDescription
  });


}

/// @nodoc
class __$CreateJournalRequestCopyWithImpl<$Res>
    implements _$CreateJournalRequestCopyWith<$Res> {
  __$CreateJournalRequestCopyWithImpl(this._self, this._then);

  final _CreateJournalRequest _self;
  final $Res Function(_CreateJournalRequest) _then;

  /// Create a copy of CreateJournalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call(
      {Object? content = freezed, Object? moodType = null, Object? imageUri = freezed, Object? aiResponseEnabled = null, Object? tagNames = freezed, Object? aiResponse = freezed, Object? createdAt = null, Object? latitude = freezed, Object? longitude = freezed, Object? address = freezed, Object? temperature = freezed, Object? weatherIcon = freezed, Object? weatherDescription = freezed,}) {
    return _then(_CreateJournalRequest(
      content: freezed == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
      as String?,
      moodType: null == moodType
          ? _self.moodType
          : moodType // ignore: cast_nullable_to_non_nullable
      as MoodType,
      imageUri: freezed == imageUri
          ? _self._imageUri
          : imageUri // ignore: cast_nullable_to_non_nullable
      as List<String>?,
      aiResponseEnabled: null == aiResponseEnabled
          ? _self.aiResponseEnabled
          : aiResponseEnabled // ignore: cast_nullable_to_non_nullable
      as bool,
      tagNames: freezed == tagNames
          ? _self._tagNames
          : tagNames // ignore: cast_nullable_to_non_nullable
      as List<String>?,
      aiResponse: freezed == aiResponse
          ? _self.aiResponse
          : aiResponse // ignore: cast_nullable_to_non_nullable
      as String?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
      as DateTime,
      latitude: freezed == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
      as double?,
      longitude: freezed == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
      as double?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
      as String?,
      temperature: freezed == temperature
          ? _self.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
      as double?,
      weatherIcon: freezed == weatherIcon
          ? _self.weatherIcon
          : weatherIcon // ignore: cast_nullable_to_non_nullable
      as String?,
      weatherDescription: freezed == weatherDescription
          ? _self.weatherDescription
          : weatherDescription // ignore: cast_nullable_to_non_nullable
      as String?,
    ));
  }


}

// dart format on
