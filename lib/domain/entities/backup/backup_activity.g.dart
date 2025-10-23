// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BackupActivity _$BackupActivityFromJson(Map<String, dynamic> json) =>
    _BackupActivity(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      color: json['color'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$BackupActivityToJson(_BackupActivity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'createdAt': instance.createdAt.toIso8601String(),
    };
