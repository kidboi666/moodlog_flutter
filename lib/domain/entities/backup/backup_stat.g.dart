// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_stat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BackupStat _$BackupStatFromJson(Map<String, dynamic> json) => _BackupStat(
  id: (json['id'] as num).toInt(),
  currentStreak: (json['currentStreak'] as num).toInt(),
  maxStreak: (json['maxStreak'] as num).toInt(),
  lastActiveDate: DateTime.parse(json['lastActiveDate'] as String),
);

Map<String, dynamic> _$BackupStatToJson(_BackupStat instance) =>
    <String, dynamic>{
      'id': instance.id,
      'currentStreak': instance.currentStreak,
      'maxStreak': instance.maxStreak,
      'lastActiveDate': instance.lastActiveDate.toIso8601String(),
    };
