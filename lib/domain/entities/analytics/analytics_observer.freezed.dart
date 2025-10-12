// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'analytics_observer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AnalyticsObserver {

  String get name;

  Map<String, dynamic> get properties;

  /// Create a copy of AnalyticsObserver
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AnalyticsObserverCopyWith<AnalyticsObserver> get copyWith =>
      _$AnalyticsObserverCopyWithImpl<AnalyticsObserver>(
          this as AnalyticsObserver, _$identity);


  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AnalyticsObserver &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(
                other.properties, properties));
  }


  @override
  int get hashCode =>
      Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(properties));

  @override
  String toString() {
    return 'AnalyticsObserver(name: $name, properties: $properties)';
  }


}

/// @nodoc
abstract mixin class $AnalyticsObserverCopyWith<$Res> {
  factory $AnalyticsObserverCopyWith(AnalyticsObserver value,
      $Res Function(AnalyticsObserver) _then) = _$AnalyticsObserverCopyWithImpl;

  @useResult
  $Res call({
    String name, Map<String, dynamic> properties
  });


}

/// @nodoc
class _$AnalyticsObserverCopyWithImpl<$Res>
    implements $AnalyticsObserverCopyWith<$Res> {
  _$AnalyticsObserverCopyWithImpl(this._self, this._then);

  final AnalyticsObserver _self;
  final $Res Function(AnalyticsObserver) _then;

  /// Create a copy of AnalyticsObserver
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? properties = null,}) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
      as String,
      properties: null == properties
          ? _self.properties
          : properties // ignore: cast_nullable_to_non_nullable
      as Map<String, dynamic>,
    ));
  }

}


/// Adds pattern-matching-related methods to [AnalyticsObserver].
extension AnalyticsObserverPatterns on AnalyticsObserver {
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

  TResult Function( _AnalyticsObserver value)? $default,{required TResult orElse(),}){
  final _that = this;
  switch (_that) {
  case _AnalyticsObserver() when $default != null:
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

  @optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnalyticsObserver value) $default,){
  final _that = this;
  switch (_that) {
  case _AnalyticsObserver():
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

  @optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnalyticsObserver value)? $default,){
  final _that = this;
  switch (_that) {
  case _AnalyticsObserver() when $default != null:
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

  @optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name, Map<String, dynamic> properties)? $default,{required TResult orElse(),}) {final _that = this;
  switch (_that) {
  case _AnalyticsObserver() when $default != null:
  return $default(_that.name,_that.properties);case _:
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

  @optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name, Map<String, dynamic> properties) $default,) {final _that = this;
  switch (_that) {
  case _AnalyticsObserver():
  return $default(_that.name,_that.properties);case _:
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

  @optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name, Map<String, dynamic> properties)? $default,) {final _that = this;
  switch (_that) {
  case _AnalyticsObserver() when $default != null:
  return $default(_that.name,_that.properties);case _:
  return null;

  }
  }

}

/// @nodoc


class _AnalyticsObserver implements AnalyticsObserver {
  const _AnalyticsObserver(
      {required this.name, required final Map<String, dynamic> properties})
      : _properties = properties;


  @override final String name;
  final Map<String, dynamic> _properties;

  @override Map<String, dynamic> get properties {
    if (_properties is EqualUnmodifiableMapView) return _properties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_properties);
  }


  /// Create a copy of AnalyticsObserver
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AnalyticsObserverCopyWith<_AnalyticsObserver> get copyWith =>
      __$AnalyticsObserverCopyWithImpl<_AnalyticsObserver>(this, _$identity);


  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _AnalyticsObserver &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(
                other._properties, _properties));
  }


  @override
  int get hashCode =>
      Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(_properties));

  @override
  String toString() {
    return 'AnalyticsObserver(name: $name, properties: $properties)';
  }


}

/// @nodoc
abstract mixin class _$AnalyticsObserverCopyWith<$Res>
    implements $AnalyticsObserverCopyWith<$Res> {
  factory _$AnalyticsObserverCopyWith(_AnalyticsObserver value,
      $Res Function(_AnalyticsObserver) _then) = __$AnalyticsObserverCopyWithImpl;

  @override
  @useResult
  $Res call({
    String name, Map<String, dynamic> properties
  });


}

/// @nodoc
class __$AnalyticsObserverCopyWithImpl<$Res>
    implements _$AnalyticsObserverCopyWith<$Res> {
  __$AnalyticsObserverCopyWithImpl(this._self, this._then);

  final _AnalyticsObserver _self;
  final $Res Function(_AnalyticsObserver) _then;

  /// Create a copy of AnalyticsObserver
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? name = null, Object? properties = null,}) {
    return _then(_AnalyticsObserver(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
      as String,
      properties: null == properties
          ? _self._properties
          : properties // ignore: cast_nullable_to_non_nullable
      as Map<String, dynamic>,
    ));
  }


}

// dart format on
