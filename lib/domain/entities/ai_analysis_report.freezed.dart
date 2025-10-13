// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_analysis_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AiAnalysisReport {

 String get summary; List<String> get positiveKeywords; List<String> get negativeKeywords;
/// Create a copy of AiAnalysisReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiAnalysisReportCopyWith<AiAnalysisReport> get copyWith => _$AiAnalysisReportCopyWithImpl<AiAnalysisReport>(this as AiAnalysisReport, _$identity);

  /// Serializes this AiAnalysisReport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiAnalysisReport&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.positiveKeywords, positiveKeywords)&&const DeepCollectionEquality().equals(other.negativeKeywords, negativeKeywords));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,summary,const DeepCollectionEquality().hash(positiveKeywords),const DeepCollectionEquality().hash(negativeKeywords));

@override
String toString() {
  return 'AiAnalysisReport(summary: $summary, positiveKeywords: $positiveKeywords, negativeKeywords: $negativeKeywords)';
}


}

/// @nodoc
abstract mixin class $AiAnalysisReportCopyWith<$Res>  {
  factory $AiAnalysisReportCopyWith(AiAnalysisReport value, $Res Function(AiAnalysisReport) _then) = _$AiAnalysisReportCopyWithImpl;
@useResult
$Res call({
 String summary, List<String> positiveKeywords, List<String> negativeKeywords
});




}
/// @nodoc
class _$AiAnalysisReportCopyWithImpl<$Res>
    implements $AiAnalysisReportCopyWith<$Res> {
  _$AiAnalysisReportCopyWithImpl(this._self, this._then);

  final AiAnalysisReport _self;
  final $Res Function(AiAnalysisReport) _then;

/// Create a copy of AiAnalysisReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? summary = null,Object? positiveKeywords = null,Object? negativeKeywords = null,}) {
  return _then(_self.copyWith(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,positiveKeywords: null == positiveKeywords ? _self.positiveKeywords : positiveKeywords // ignore: cast_nullable_to_non_nullable
as List<String>,negativeKeywords: null == negativeKeywords ? _self.negativeKeywords : negativeKeywords // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [AiAnalysisReport].
extension AiAnalysisReportPatterns on AiAnalysisReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiAnalysisReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiAnalysisReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiAnalysisReport value)  $default,){
final _that = this;
switch (_that) {
case _AiAnalysisReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiAnalysisReport value)?  $default,){
final _that = this;
switch (_that) {
case _AiAnalysisReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String summary,  List<String> positiveKeywords,  List<String> negativeKeywords)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiAnalysisReport() when $default != null:
return $default(_that.summary,_that.positiveKeywords,_that.negativeKeywords);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String summary,  List<String> positiveKeywords,  List<String> negativeKeywords)  $default,) {final _that = this;
switch (_that) {
case _AiAnalysisReport():
return $default(_that.summary,_that.positiveKeywords,_that.negativeKeywords);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String summary,  List<String> positiveKeywords,  List<String> negativeKeywords)?  $default,) {final _that = this;
switch (_that) {
case _AiAnalysisReport() when $default != null:
return $default(_that.summary,_that.positiveKeywords,_that.negativeKeywords);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiAnalysisReport implements AiAnalysisReport {
  const _AiAnalysisReport({required this.summary, required final  List<String> positiveKeywords, required final  List<String> negativeKeywords}): _positiveKeywords = positiveKeywords,_negativeKeywords = negativeKeywords;
  factory _AiAnalysisReport.fromJson(Map<String, dynamic> json) => _$AiAnalysisReportFromJson(json);

@override final  String summary;
 final  List<String> _positiveKeywords;
@override List<String> get positiveKeywords {
  if (_positiveKeywords is EqualUnmodifiableListView) return _positiveKeywords;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_positiveKeywords);
}

 final  List<String> _negativeKeywords;
@override List<String> get negativeKeywords {
  if (_negativeKeywords is EqualUnmodifiableListView) return _negativeKeywords;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_negativeKeywords);
}


/// Create a copy of AiAnalysisReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiAnalysisReportCopyWith<_AiAnalysisReport> get copyWith => __$AiAnalysisReportCopyWithImpl<_AiAnalysisReport>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiAnalysisReportToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiAnalysisReport&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other._positiveKeywords, _positiveKeywords)&&const DeepCollectionEquality().equals(other._negativeKeywords, _negativeKeywords));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,summary,const DeepCollectionEquality().hash(_positiveKeywords),const DeepCollectionEquality().hash(_negativeKeywords));

@override
String toString() {
  return 'AiAnalysisReport(summary: $summary, positiveKeywords: $positiveKeywords, negativeKeywords: $negativeKeywords)';
}


}

/// @nodoc
abstract mixin class _$AiAnalysisReportCopyWith<$Res> implements $AiAnalysisReportCopyWith<$Res> {
  factory _$AiAnalysisReportCopyWith(_AiAnalysisReport value, $Res Function(_AiAnalysisReport) _then) = __$AiAnalysisReportCopyWithImpl;
@override @useResult
$Res call({
 String summary, List<String> positiveKeywords, List<String> negativeKeywords
});




}
/// @nodoc
class __$AiAnalysisReportCopyWithImpl<$Res>
    implements _$AiAnalysisReportCopyWith<$Res> {
  __$AiAnalysisReportCopyWithImpl(this._self, this._then);

  final _AiAnalysisReport _self;
  final $Res Function(_AiAnalysisReport) _then;

/// Create a copy of AiAnalysisReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? summary = null,Object? positiveKeywords = null,Object? negativeKeywords = null,}) {
  return _then(_AiAnalysisReport(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,positiveKeywords: null == positiveKeywords ? _self._positiveKeywords : positiveKeywords // ignore: cast_nullable_to_non_nullable
as List<String>,negativeKeywords: null == negativeKeywords ? _self._negativeKeywords : negativeKeywords // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
