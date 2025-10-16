// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_journal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BackupJournal _$BackupJournalFromJson(Map<String, dynamic> json) =>
    _BackupJournal(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      content: json['content'] as String,
      imageUri: (json['imageUri'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      address: json['address'] as String?,
      temperature: (json['temperature'] as num?)?.toDouble(),
      weatherIcon: json['weatherIcon'] as String?,
      weatherDescription: json['weatherDescription'] as String?,
    );

Map<String, dynamic> _$BackupJournalToJson(_BackupJournal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'content': instance.content,
      'imageUri': instance.imageUri,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'temperature': instance.temperature,
      'weatherIcon': instance.weatherIcon,
      'weatherDescription': instance.weatherDescription,
    };
