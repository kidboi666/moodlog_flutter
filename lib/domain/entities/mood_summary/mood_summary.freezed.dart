// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mood_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MoodSummary {

 int get id; MoodSummaryPeriod get period; DateTime get startDate; DateTime get endDate; DateTime get generatedAt; String get emotionalFlow; String get dominantMoods; String get activityPatterns; String get personalAdvice; String get keyPoints; Map<String, dynamic> get metadata;
/// Create a copy of MoodSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MoodSummaryCopyWith<MoodSummary> get copyWith => _$MoodSummaryCopyWithImpl<MoodSummary>(this as MoodSummary, _$identity);

  /// Serializes this MoodSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MoodSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.period, period) || other.period == period)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.emotionalFlow, emotionalFlow) || other.emotionalFlow == emotionalFlow)&&(identical(other.dominantMoods, dominantMoods) || other.dominantMoods == dominantMoods)&&(identical(other.activityPatterns, activityPatterns) || other.activityPatterns == activityPatterns)&&(identical(other.personalAdvice, personalAdvice) || other.personalAdvice == personalAdvice)&&(identical(other.keyPoints, keyPoints) || other.keyPoints == keyPoints)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,period,startDate,endDate,generatedAt,emotionalFlow,dominantMoods,activityPatterns,personalAdvice,keyPoints,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'MoodSummary(id: $id, period: $period, startDate: $startDate, endDate: $endDate, generatedAt: $generatedAt, emotionalFlow: $emotionalFlow, dominantMoods: $dominantMoods, activityPatterns: $activityPatterns, personalAdvice: $personalAdvice, keyPoints: $keyPoints, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $MoodSummaryCopyWith<$Res>  {
  factory $MoodSummaryCopyWith(MoodSummary value, $Res Function(MoodSummary) _then) = _$MoodSummaryCopyWithImpl;
@useResult
$Res call({
 int id, MoodSummaryPeriod period, DateTime startDate, DateTime endDate, DateTime generatedAt, String emotionalFlow, String dominantMoods, String activityPatterns, String personalAdvice, String keyPoints, Map<String, dynamic> metadata
});




}
/// @nodoc
class _$MoodSummaryCopyWithImpl<$Res>
    implements $MoodSummaryCopyWith<$Res> {
  _$MoodSummaryCopyWithImpl(this._self, this._then);

  final MoodSummary _self;
  final $Res Function(MoodSummary) _then;

/// Create a copy of MoodSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? period = null,Object? startDate = null,Object? endDate = null,Object? generatedAt = null,Object? emotionalFlow = null,Object? dominantMoods = null,Object? activityPatterns = null,Object? personalAdvice = null,Object? keyPoints = null,Object? metadata = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as MoodSummaryPeriod,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,emotionalFlow: null == emotionalFlow ? _self.emotionalFlow : emotionalFlow // ignore: cast_nullable_to_non_nullable
as String,dominantMoods: null == dominantMoods ? _self.dominantMoods : dominantMoods // ignore: cast_nullable_to_non_nullable
as String,activityPatterns: null == activityPatterns ? _self.activityPatterns : activityPatterns // ignore: cast_nullable_to_non_nullable
as String,personalAdvice: null == personalAdvice ? _self.personalAdvice : personalAdvice // ignore: cast_nullable_to_non_nullable
as String,keyPoints: null == keyPoints ? _self.keyPoints : keyPoints // ignore: cast_nullable_to_non_nullable
as String,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [MoodSummary].
extension MoodSummaryPatterns on MoodSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MoodSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MoodSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MoodSummary value)  $default,){
final _that = this;
switch (_that) {
case _MoodSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MoodSummary value)?  $default,){
final _that = this;
switch (_that) {
case _MoodSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  MoodSummaryPeriod period,  DateTime startDate,  DateTime endDate,  DateTime generatedAt,  String emotionalFlow,  String dominantMoods,  String activityPatterns,  String personalAdvice,  String keyPoints,  Map<String, dynamic> metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MoodSummary() when $default != null:
return $default(_that.id,_that.period,_that.startDate,_that.endDate,_that.generatedAt,_that.emotionalFlow,_that.dominantMoods,_that.activityPatterns,_that.personalAdvice,_that.keyPoints,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  MoodSummaryPeriod period,  DateTime startDate,  DateTime endDate,  DateTime generatedAt,  String emotionalFlow,  String dominantMoods,  String activityPatterns,  String personalAdvice,  String keyPoints,  Map<String, dynamic> metadata)  $default,) {final _that = this;
switch (_that) {
case _MoodSummary():
return $default(_that.id,_that.period,_that.startDate,_that.endDate,_that.generatedAt,_that.emotionalFlow,_that.dominantMoods,_that.activityPatterns,_that.personalAdvice,_that.keyPoints,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  MoodSummaryPeriod period,  DateTime startDate,  DateTime endDate,  DateTime generatedAt,  String emotionalFlow,  String dominantMoods,  String activityPatterns,  String personalAdvice,  String keyPoints,  Map<String, dynamic> metadata)?  $default,) {final _that = this;
switch (_that) {
case _MoodSummary() when $default != null:
return $default(_that.id,_that.period,_that.startDate,_that.endDate,_that.generatedAt,_that.emotionalFlow,_that.dominantMoods,_that.activityPatterns,_that.personalAdvice,_that.keyPoints,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MoodSummary implements MoodSummary {
  const _MoodSummary({required this.id, required this.period, required this.startDate, required this.endDate, required this.generatedAt, required this.emotionalFlow, required this.dominantMoods, required this.activityPatterns, required this.personalAdvice, required this.keyPoints, required final  Map<String, dynamic> metadata}): _metadata = metadata;
  factory _MoodSummary.fromJson(Map<String, dynamic> json) => _$MoodSummaryFromJson(json);

@override final  int id;
@override final  MoodSummaryPeriod period;
@override final  DateTime startDate;
@override final  DateTime endDate;
@override final  DateTime generatedAt;
@override final  String emotionalFlow;
@override final  String dominantMoods;
@override final  String activityPatterns;
@override final  String personalAdvice;
@override final  String keyPoints;
 final  Map<String, dynamic> _metadata;
@override Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of MoodSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MoodSummaryCopyWith<_MoodSummary> get copyWith => __$MoodSummaryCopyWithImpl<_MoodSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MoodSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MoodSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.period, period) || other.period == period)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.emotionalFlow, emotionalFlow) || other.emotionalFlow == emotionalFlow)&&(identical(other.dominantMoods, dominantMoods) || other.dominantMoods == dominantMoods)&&(identical(other.activityPatterns, activityPatterns) || other.activityPatterns == activityPatterns)&&(identical(other.personalAdvice, personalAdvice) || other.personalAdvice == personalAdvice)&&(identical(other.keyPoints, keyPoints) || other.keyPoints == keyPoints)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,period,startDate,endDate,generatedAt,emotionalFlow,dominantMoods,activityPatterns,personalAdvice,keyPoints,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'MoodSummary(id: $id, period: $period, startDate: $startDate, endDate: $endDate, generatedAt: $generatedAt, emotionalFlow: $emotionalFlow, dominantMoods: $dominantMoods, activityPatterns: $activityPatterns, personalAdvice: $personalAdvice, keyPoints: $keyPoints, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$MoodSummaryCopyWith<$Res> implements $MoodSummaryCopyWith<$Res> {
  factory _$MoodSummaryCopyWith(_MoodSummary value, $Res Function(_MoodSummary) _then) = __$MoodSummaryCopyWithImpl;
@override @useResult
$Res call({
 int id, MoodSummaryPeriod period, DateTime startDate, DateTime endDate, DateTime generatedAt, String emotionalFlow, String dominantMoods, String activityPatterns, String personalAdvice, String keyPoints, Map<String, dynamic> metadata
});




}
/// @nodoc
class __$MoodSummaryCopyWithImpl<$Res>
    implements _$MoodSummaryCopyWith<$Res> {
  __$MoodSummaryCopyWithImpl(this._self, this._then);

  final _MoodSummary _self;
  final $Res Function(_MoodSummary) _then;

/// Create a copy of MoodSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? period = null,Object? startDate = null,Object? endDate = null,Object? generatedAt = null,Object? emotionalFlow = null,Object? dominantMoods = null,Object? activityPatterns = null,Object? personalAdvice = null,Object? keyPoints = null,Object? metadata = null,}) {
  return _then(_MoodSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as MoodSummaryPeriod,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,emotionalFlow: null == emotionalFlow ? _self.emotionalFlow : emotionalFlow // ignore: cast_nullable_to_non_nullable
as String,dominantMoods: null == dominantMoods ? _self.dominantMoods : dominantMoods // ignore: cast_nullable_to_non_nullable
as String,activityPatterns: null == activityPatterns ? _self.activityPatterns : activityPatterns // ignore: cast_nullable_to_non_nullable
as String,personalAdvice: null == personalAdvice ? _self.personalAdvice : personalAdvice // ignore: cast_nullable_to_non_nullable
as String,keyPoints: null == keyPoints ? _self.keyPoints : keyPoints // ignore: cast_nullable_to_non_nullable
as String,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
