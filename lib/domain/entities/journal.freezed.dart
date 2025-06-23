// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'journal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Journal {

 int get id; String? get content; String get moodName; String? get imageUri; bool get aiResponseEnabled; String? get aiResponse; DateTime get createdAt;
/// Create a copy of Journal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JournalCopyWith<Journal> get copyWith => _$JournalCopyWithImpl<Journal>(this as Journal, _$identity);

  /// Serializes this Journal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Journal&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.moodName, moodName) || other.moodName == moodName)&&(identical(other.imageUri, imageUri) || other.imageUri == imageUri)&&(identical(other.aiResponseEnabled, aiResponseEnabled) || other.aiResponseEnabled == aiResponseEnabled)&&(identical(other.aiResponse, aiResponse) || other.aiResponse == aiResponse)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,moodName,imageUri,aiResponseEnabled,aiResponse,createdAt);

@override
String toString() {
  return 'Journal(id: $id, content: $content, moodName: $moodName, imageUri: $imageUri, aiResponseEnabled: $aiResponseEnabled, aiResponse: $aiResponse, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $JournalCopyWith<$Res>  {
  factory $JournalCopyWith(Journal value, $Res Function(Journal) _then) = _$JournalCopyWithImpl;
@useResult
$Res call({
 int id, String? content, String moodName, String? imageUri, bool aiResponseEnabled, String? aiResponse, DateTime createdAt
});




}
/// @nodoc
class _$JournalCopyWithImpl<$Res>
    implements $JournalCopyWith<$Res> {
  _$JournalCopyWithImpl(this._self, this._then);

  final Journal _self;
  final $Res Function(Journal) _then;

/// Create a copy of Journal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? content = freezed,Object? moodName = null,Object? imageUri = freezed,Object? aiResponseEnabled = null,Object? aiResponse = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,moodName: null == moodName ? _self.moodName : moodName // ignore: cast_nullable_to_non_nullable
as String,imageUri: freezed == imageUri ? _self.imageUri : imageUri // ignore: cast_nullable_to_non_nullable
as String?,aiResponseEnabled: null == aiResponseEnabled ? _self.aiResponseEnabled : aiResponseEnabled // ignore: cast_nullable_to_non_nullable
as bool,aiResponse: freezed == aiResponse ? _self.aiResponse : aiResponse // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Journal implements Journal {
  const _Journal({required this.id, required this.content, required this.moodName, required this.imageUri, required this.aiResponseEnabled, required this.aiResponse, required this.createdAt});
  factory _Journal.fromJson(Map<String, dynamic> json) => _$JournalFromJson(json);

@override final  int id;
@override final  String? content;
@override final  String moodName;
@override final  String? imageUri;
@override final  bool aiResponseEnabled;
@override final  String? aiResponse;
@override final  DateTime createdAt;

/// Create a copy of Journal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JournalCopyWith<_Journal> get copyWith => __$JournalCopyWithImpl<_Journal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JournalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Journal&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.moodName, moodName) || other.moodName == moodName)&&(identical(other.imageUri, imageUri) || other.imageUri == imageUri)&&(identical(other.aiResponseEnabled, aiResponseEnabled) || other.aiResponseEnabled == aiResponseEnabled)&&(identical(other.aiResponse, aiResponse) || other.aiResponse == aiResponse)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,moodName,imageUri,aiResponseEnabled,aiResponse,createdAt);

@override
String toString() {
  return 'Journal(id: $id, content: $content, moodName: $moodName, imageUri: $imageUri, aiResponseEnabled: $aiResponseEnabled, aiResponse: $aiResponse, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$JournalCopyWith<$Res> implements $JournalCopyWith<$Res> {
  factory _$JournalCopyWith(_Journal value, $Res Function(_Journal) _then) = __$JournalCopyWithImpl;
@override @useResult
$Res call({
 int id, String? content, String moodName, String? imageUri, bool aiResponseEnabled, String? aiResponse, DateTime createdAt
});




}
/// @nodoc
class __$JournalCopyWithImpl<$Res>
    implements _$JournalCopyWith<$Res> {
  __$JournalCopyWithImpl(this._self, this._then);

  final _Journal _self;
  final $Res Function(_Journal) _then;

/// Create a copy of Journal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? content = freezed,Object? moodName = null,Object? imageUri = freezed,Object? aiResponseEnabled = null,Object? aiResponse = freezed,Object? createdAt = null,}) {
  return _then(_Journal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,moodName: null == moodName ? _self.moodName : moodName // ignore: cast_nullable_to_non_nullable
as String,imageUri: freezed == imageUri ? _self.imageUri : imageUri // ignore: cast_nullable_to_non_nullable
as String?,aiResponseEnabled: null == aiResponseEnabled ? _self.aiResponseEnabled : aiResponseEnabled // ignore: cast_nullable_to_non_nullable
as bool,aiResponse: freezed == aiResponse ? _self.aiResponse : aiResponse // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
