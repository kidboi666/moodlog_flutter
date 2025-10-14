// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BackupTag _$BackupTagFromJson(Map<String, dynamic> json) => _BackupTag(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  color: json['color'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$BackupTagToJson(_BackupTag instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'createdAt': instance.createdAt.toIso8601String(),
    };
