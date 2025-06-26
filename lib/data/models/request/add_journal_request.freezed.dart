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

 String? get content; String get moodName; String? get imageUri;
/// Create a copy of AddJournalRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddJournalRequestCopyWith<AddJournalRequest> get copyWith => _$AddJournalRequestCopyWithImpl<AddJournalRequest>(this as AddJournalRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddJournalRequest&&(identical(other.content, content) || other.content == content)&&(identical(other.moodName, moodName) || other.moodName == moodName)&&(identical(other.imageUri, imageUri) || other.imageUri == imageUri));
}


@override
int get hashCode => Object.hash(runtimeType,content,moodName,imageUri);

@override
String toString() {
  return 'AddJournalRequest(content: $content, moodName: $moodName, imageUri: $imageUri)';
}


}

/// @nodoc
abstract mixin class $AddJournalRequestCopyWith<$Res>  {
  factory $AddJournalRequestCopyWith(AddJournalRequest value, $Res Function(AddJournalRequest) _then) = _$AddJournalRequestCopyWithImpl;
@useResult
$Res call({
 String? content, String moodName, String? imageUri
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
@pragma('vm:prefer-inline') @override $Res call({Object? content = freezed,Object? moodName = null,Object? imageUri = freezed,}) {
  return _then(_self.copyWith(
content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,moodName: null == moodName ? _self.moodName : moodName // ignore: cast_nullable_to_non_nullable
as String,imageUri: freezed == imageUri ? _self.imageUri : imageUri // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _AddJournalRequest implements AddJournalRequest {
  const _AddJournalRequest({this.content, required this.moodName, this.imageUri});
  

@override final  String? content;
@override final  String moodName;
@override final  String? imageUri;

/// Create a copy of AddJournalRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddJournalRequestCopyWith<_AddJournalRequest> get copyWith => __$AddJournalRequestCopyWithImpl<_AddJournalRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddJournalRequest&&(identical(other.content, content) || other.content == content)&&(identical(other.moodName, moodName) || other.moodName == moodName)&&(identical(other.imageUri, imageUri) || other.imageUri == imageUri));
}


@override
int get hashCode => Object.hash(runtimeType,content,moodName,imageUri);

@override
String toString() {
  return 'AddJournalRequest(content: $content, moodName: $moodName, imageUri: $imageUri)';
}


}

/// @nodoc
abstract mixin class _$AddJournalRequestCopyWith<$Res> implements $AddJournalRequestCopyWith<$Res> {
  factory _$AddJournalRequestCopyWith(_AddJournalRequest value, $Res Function(_AddJournalRequest) _then) = __$AddJournalRequestCopyWithImpl;
@override @useResult
$Res call({
 String? content, String moodName, String? imageUri
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
@override @pragma('vm:prefer-inline') $Res call({Object? content = freezed,Object? moodName = null,Object? imageUri = freezed,}) {
  return _then(_AddJournalRequest(
content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,moodName: null == moodName ? _self.moodName : moodName // ignore: cast_nullable_to_non_nullable
as String,imageUri: freezed == imageUri ? _self.imageUri : imageUri // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
