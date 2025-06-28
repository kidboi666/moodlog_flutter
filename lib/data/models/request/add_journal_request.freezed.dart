// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_journal_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AddJournalRequest {

 String? get content; String get moodName; List<String> get imageUri; bool? get aiEnabled;
/// Create a copy of AddJournalRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddJournalRequestCopyWith<AddJournalRequest> get copyWith => _$AddJournalRequestCopyWithImpl<AddJournalRequest>(this as AddJournalRequest, _$identity);

  /// Serializes this AddJournalRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddJournalRequest&&(identical(other.content, content) || other.content == content)&&(identical(other.moodName, moodName) || other.moodName == moodName)&&const DeepCollectionEquality().equals(other.imageUri, imageUri)&&(identical(other.aiEnabled, aiEnabled) || other.aiEnabled == aiEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,moodName,const DeepCollectionEquality().hash(imageUri),aiEnabled);

@override
String toString() {
  return 'AddJournalRequest(content: $content, moodName: $moodName, imageUri: $imageUri, aiEnabled: $aiEnabled)';
}


}

/// @nodoc
abstract mixin class $AddJournalRequestCopyWith<$Res>  {
  factory $AddJournalRequestCopyWith(AddJournalRequest value, $Res Function(AddJournalRequest) _then) = _$AddJournalRequestCopyWithImpl;
@useResult
$Res call({
 String? content, String moodName, List<String> imageUri, bool? aiEnabled
});




}
/// @nodoc
class _$AddJournalRequestCopyWithImpl<$Res>
    implements $AddJournalRequestCopyWith<$Res> {
  _$AddJournalRequestCopyWithImpl(this._self, this._then);

  final AddJournalRequest _self;
  final $Res Function(AddJournalRequest) _then;

/// Create a copy of AddJournalRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = freezed,Object? moodName = null,Object? imageUri = null,Object? aiEnabled = freezed,}) {
  return _then(_self.copyWith(
content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,moodName: null == moodName ? _self.moodName : moodName // ignore: cast_nullable_to_non_nullable
as String,imageUri: null == imageUri ? _self.imageUri : imageUri // ignore: cast_nullable_to_non_nullable
as List<String>,aiEnabled: freezed == aiEnabled ? _self.aiEnabled : aiEnabled // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _AddJournalRequest implements AddJournalRequest {
  const _AddJournalRequest({this.content, required this.moodName, required final  List<String> imageUri, this.aiEnabled}): _imageUri = imageUri;
  factory _AddJournalRequest.fromJson(Map<String, dynamic> json) => _$AddJournalRequestFromJson(json);

@override final  String? content;
@override final  String moodName;
 final  List<String> _imageUri;
@override List<String> get imageUri {
  if (_imageUri is EqualUnmodifiableListView) return _imageUri;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_imageUri);
}

@override final  bool? aiEnabled;

/// Create a copy of AddJournalRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddJournalRequestCopyWith<_AddJournalRequest> get copyWith => __$AddJournalRequestCopyWithImpl<_AddJournalRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddJournalRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddJournalRequest&&(identical(other.content, content) || other.content == content)&&(identical(other.moodName, moodName) || other.moodName == moodName)&&const DeepCollectionEquality().equals(other._imageUri, _imageUri)&&(identical(other.aiEnabled, aiEnabled) || other.aiEnabled == aiEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,moodName,const DeepCollectionEquality().hash(_imageUri),aiEnabled);

@override
String toString() {
  return 'AddJournalRequest(content: $content, moodName: $moodName, imageUri: $imageUri, aiEnabled: $aiEnabled)';
}


}

/// @nodoc
abstract mixin class _$AddJournalRequestCopyWith<$Res> implements $AddJournalRequestCopyWith<$Res> {
  factory _$AddJournalRequestCopyWith(_AddJournalRequest value, $Res Function(_AddJournalRequest) _then) = __$AddJournalRequestCopyWithImpl;
@override @useResult
$Res call({
 String? content, String moodName, List<String> imageUri, bool? aiEnabled
});




}
/// @nodoc
class __$AddJournalRequestCopyWithImpl<$Res>
    implements _$AddJournalRequestCopyWith<$Res> {
  __$AddJournalRequestCopyWithImpl(this._self, this._then);

  final _AddJournalRequest _self;
  final $Res Function(_AddJournalRequest) _then;

/// Create a copy of AddJournalRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = freezed,Object? moodName = null,Object? imageUri = null,Object? aiEnabled = freezed,}) {
  return _then(_AddJournalRequest(
content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,moodName: null == moodName ? _self.moodName : moodName // ignore: cast_nullable_to_non_nullable
as String,imageUri: null == imageUri ? _self._imageUri : imageUri // ignore: cast_nullable_to_non_nullable
as List<String>,aiEnabled: freezed == aiEnabled ? _self.aiEnabled : aiEnabled // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
