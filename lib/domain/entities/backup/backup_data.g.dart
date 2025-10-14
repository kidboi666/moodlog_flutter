// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BackupData _$BackupDataFromJson(Map<String, dynamic> json) => _BackupData(
  version: json['version'] as String,
  backupDate: DateTime.parse(json['backupDate'] as String),
  user: BackupUser.fromJson(json['user'] as Map<String, dynamic>),
  settings: BackupSettings.fromJson(json['settings'] as Map<String, dynamic>),
  stat: BackupStat.fromJson(json['stat'] as Map<String, dynamic>),
  journals: (json['journals'] as List<dynamic>)
      .map((e) => BackupJournal.fromJson(e as Map<String, dynamic>))
      .toList(),
  tags: (json['tags'] as List<dynamic>)
      .map((e) => BackupTag.fromJson(e as Map<String, dynamic>))
      .toList(),
  images: Map<String, String>.from(json['images'] as Map),
);

Map<String, dynamic> _$BackupDataToJson(_BackupData instance) =>
    <String, dynamic>{
      'version': instance.version,
      'backupDate': instance.backupDate.toIso8601String(),
      'user': instance.user,
      'settings': instance.settings,
      'stat': instance.stat,
      'journals': instance.journals,
      'tags': instance.tags,
      'images': instance.images,
    };
