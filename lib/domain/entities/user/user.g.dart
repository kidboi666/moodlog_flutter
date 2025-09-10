// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  uid: json['uid'] as String,
  email: json['email'] as String?,
  isAnonymous: json['isAnonymous'] as bool,
  displayName: json['displayName'] as String?,
  photoURL: json['photoURL'] as String?,
  metadata: UserMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
  providerData: (json['providerData'] as List<dynamic>)
      .map((e) => UserProviderData.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'uid': instance.uid,
  'email': instance.email,
  'isAnonymous': instance.isAnonymous,
  'displayName': instance.displayName,
  'photoURL': instance.photoURL,
  'metadata': instance.metadata,
  'providerData': instance.providerData,
};
