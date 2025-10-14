// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BackupUser _$BackupUserFromJson(Map<String, dynamic> json) => _BackupUser(
  userId: json['userId'] as String,
  nickname: json['nickname'] as String,
  profileImagePath: json['profileImagePath'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$BackupUserToJson(_BackupUser instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'nickname': instance.nickname,
      'profileImagePath': instance.profileImagePath,
      'createdAt': instance.createdAt.toIso8601String(),
    };
