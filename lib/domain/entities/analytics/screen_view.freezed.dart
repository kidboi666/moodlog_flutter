// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'screen_view.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ScreenView {

  String get screenName;

  String? get screenClass;

  /// Create a copy of ScreenView
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ScreenViewCopyWith<ScreenView> get copyWith =>
      _$ScreenViewCopyWithImpl<ScreenView>(this as ScreenView, _$identity);


  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ScreenView &&
            (identical(other.screenName, screenName) ||
                other.screenName == screenName) &&
            (identical(other.screenClass, screenClass) ||
                other.screenClass == screenClass));
  }


  @override
  int get hashCode => Object.hash(runtimeType, screenName, screenClass);

  @override
  String toString() {
    return 'ScreenView(screenName: $screenName, screenClass: $screenClass)';
  }


}

/// @nodoc
abstract mixin class $ScreenViewCopyWith<$Res> {
  factory $ScreenViewCopyWith(ScreenView value,
      $Res Function(ScreenView) _then) = _$ScreenViewCopyWithImpl;

  @useResult
  $Res call({
    String screenName, String? screenClass
  });


}

/// @nodoc
class _$ScreenViewCopyWithImpl<$Res>
    implements $ScreenViewCopyWith<$Res> {
  _$ScreenViewCopyWithImpl(this._self, this._then);

  final ScreenView _self;
  final $Res Function(ScreenView) _then;

  /// Create a copy of ScreenView
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? screenName = null, Object? screenClass = freezed,}) {
    return _then(_self.copyWith(
      screenName: null == screenName
          ? _self.screenName
          : screenName // ignore: cast_nullable_to_non_nullable
      as String,
      screenClass: freezed == screenClass
          ? _self.screenClass
          : screenClass // ignore: cast_nullable_to_non_nullable
      as String?,
    ));
  }

}


/// Adds pattern-matching-related methods to [ScreenView].
extension ScreenViewPatterns on ScreenView {
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

  TResult Function( _ScreenView value)? $default,{required TResult orElse(),}){
  final _that = this;
  switch (_that) {
  case _ScreenView() when $default != null:
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

  @optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScreenView value) $default,){
  final _that = this;
  switch (_that) {
  case _ScreenView():
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

  @optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScreenView value)? $default,){
  final _that = this;
  switch (_that) {
  case _ScreenView() when $default != null:
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

  @optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String screenName, String? screenClass)? $default,{required TResult orElse(),}) {final _that = this;
  switch (_that) {
  case _ScreenView() when $default != null:
  return $default(_that.screenName,_that.screenClass);case _:
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

  @optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String screenName, String? screenClass) $default,) {final _that = this;
  switch (_that) {
  case _ScreenView():
  return $default(_that.screenName,_that.screenClass);case _:
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

  @optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String screenName, String? screenClass)? $default,) {final _that = this;
  switch (_that) {
  case _ScreenView() when $default != null:
  return $default(_that.screenName,_that.screenClass);case _:
  return null;

  }
  }

}

/// @nodoc


class _ScreenView implements ScreenView {
  const _ScreenView({required this.screenName, this.screenClass});


  @override final String screenName;
  @override final String? screenClass;

  /// Create a copy of ScreenView
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ScreenViewCopyWith<_ScreenView> get copyWith =>
      __$ScreenViewCopyWithImpl<_ScreenView>(this, _$identity);


  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ScreenView &&
            (identical(other.screenName, screenName) ||
                other.screenName == screenName) &&
            (identical(other.screenClass, screenClass) ||
                other.screenClass == screenClass));
  }


  @override
  int get hashCode => Object.hash(runtimeType, screenName, screenClass);

  @override
  String toString() {
    return 'ScreenView(screenName: $screenName, screenClass: $screenClass)';
  }


}

/// @nodoc
abstract mixin class _$ScreenViewCopyWith<$Res>
    implements $ScreenViewCopyWith<$Res> {
  factory _$ScreenViewCopyWith(_ScreenView value,
      $Res Function(_ScreenView) _then) = __$ScreenViewCopyWithImpl;

  @override
  @useResult
  $Res call({
    String screenName, String? screenClass
  });


}

/// @nodoc
class __$ScreenViewCopyWithImpl<$Res>
    implements _$ScreenViewCopyWith<$Res> {
  __$ScreenViewCopyWithImpl(this._self, this._then);

  final _ScreenView _self;
  final $Res Function(_ScreenView) _then;

  /// Create a copy of ScreenView
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? screenName = null, Object? screenClass = freezed,}) {
    return _then(_ScreenView(
      screenName: null == screenName
          ? _self.screenName
          : screenName // ignore: cast_nullable_to_non_nullable
      as String,
      screenClass: freezed == screenClass
          ? _self.screenClass
          : screenClass // ignore: cast_nullable_to_non_nullable
      as String?,
    ));
  }


}

// dart format on
