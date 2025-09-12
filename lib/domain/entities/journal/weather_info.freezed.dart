// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WeatherInfo {

 double get temperature; String get description; String get icon; double get humidity; double get pressure; double get windSpeed; String get location; DateTime get timestamp;
/// Create a copy of WeatherInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherInfoCopyWith<WeatherInfo> get copyWith => _$WeatherInfoCopyWithImpl<WeatherInfo>(this as WeatherInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherInfo&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.pressure, pressure) || other.pressure == pressure)&&(identical(other.windSpeed, windSpeed) || other.windSpeed == windSpeed)&&(identical(other.location, location) || other.location == location)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,temperature,description,icon,humidity,pressure,windSpeed,location,timestamp);

@override
String toString() {
  return 'WeatherInfo(temperature: $temperature, description: $description, icon: $icon, humidity: $humidity, pressure: $pressure, windSpeed: $windSpeed, location: $location, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $WeatherInfoCopyWith<$Res>  {
  factory $WeatherInfoCopyWith(WeatherInfo value, $Res Function(WeatherInfo) _then) = _$WeatherInfoCopyWithImpl;
@useResult
$Res call({
 double temperature, String description, String icon, double humidity, double pressure, double windSpeed, String location, DateTime timestamp
});




}
/// @nodoc
class _$WeatherInfoCopyWithImpl<$Res>
    implements $WeatherInfoCopyWith<$Res> {
  _$WeatherInfoCopyWithImpl(this._self, this._then);

  final WeatherInfo _self;
  final $Res Function(WeatherInfo) _then;

/// Create a copy of WeatherInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? temperature = null,Object? description = null,Object? icon = null,Object? humidity = null,Object? pressure = null,Object? windSpeed = null,Object? location = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,humidity: null == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as double,pressure: null == pressure ? _self.pressure : pressure // ignore: cast_nullable_to_non_nullable
as double,windSpeed: null == windSpeed ? _self.windSpeed : windSpeed // ignore: cast_nullable_to_non_nullable
as double,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [WeatherInfo].
extension WeatherInfoPatterns on WeatherInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherInfo value)  $default,){
final _that = this;
switch (_that) {
case _WeatherInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherInfo value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double temperature,  String description,  String icon,  double humidity,  double pressure,  double windSpeed,  String location,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherInfo() when $default != null:
return $default(_that.temperature,_that.description,_that.icon,_that.humidity,_that.pressure,_that.windSpeed,_that.location,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double temperature,  String description,  String icon,  double humidity,  double pressure,  double windSpeed,  String location,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _WeatherInfo():
return $default(_that.temperature,_that.description,_that.icon,_that.humidity,_that.pressure,_that.windSpeed,_that.location,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double temperature,  String description,  String icon,  double humidity,  double pressure,  double windSpeed,  String location,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _WeatherInfo() when $default != null:
return $default(_that.temperature,_that.description,_that.icon,_that.humidity,_that.pressure,_that.windSpeed,_that.location,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc


class _WeatherInfo implements WeatherInfo {
  const _WeatherInfo({required this.temperature, required this.description, required this.icon, required this.humidity, required this.pressure, required this.windSpeed, required this.location, required this.timestamp});
  

@override final  double temperature;
@override final  String description;
@override final  String icon;
@override final  double humidity;
@override final  double pressure;
@override final  double windSpeed;
@override final  String location;
@override final  DateTime timestamp;

/// Create a copy of WeatherInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherInfoCopyWith<_WeatherInfo> get copyWith => __$WeatherInfoCopyWithImpl<_WeatherInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherInfo&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.pressure, pressure) || other.pressure == pressure)&&(identical(other.windSpeed, windSpeed) || other.windSpeed == windSpeed)&&(identical(other.location, location) || other.location == location)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,temperature,description,icon,humidity,pressure,windSpeed,location,timestamp);

@override
String toString() {
  return 'WeatherInfo(temperature: $temperature, description: $description, icon: $icon, humidity: $humidity, pressure: $pressure, windSpeed: $windSpeed, location: $location, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$WeatherInfoCopyWith<$Res> implements $WeatherInfoCopyWith<$Res> {
  factory _$WeatherInfoCopyWith(_WeatherInfo value, $Res Function(_WeatherInfo) _then) = __$WeatherInfoCopyWithImpl;
@override @useResult
$Res call({
 double temperature, String description, String icon, double humidity, double pressure, double windSpeed, String location, DateTime timestamp
});




}
/// @nodoc
class __$WeatherInfoCopyWithImpl<$Res>
    implements _$WeatherInfoCopyWith<$Res> {
  __$WeatherInfoCopyWithImpl(this._self, this._then);

  final _WeatherInfo _self;
  final $Res Function(_WeatherInfo) _then;

/// Create a copy of WeatherInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? temperature = null,Object? description = null,Object? icon = null,Object? humidity = null,Object? pressure = null,Object? windSpeed = null,Object? location = null,Object? timestamp = null,}) {
  return _then(_WeatherInfo(
temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,humidity: null == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as double,pressure: null == pressure ? _self.pressure : pressure // ignore: cast_nullable_to_non_nullable
as double,windSpeed: null == windSpeed ? _self.windSpeed : windSpeed // ignore: cast_nullable_to_non_nullable
as double,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
