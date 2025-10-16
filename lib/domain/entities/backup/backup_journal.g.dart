// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_journal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BackupJournal _$BackupJournalFromJson(Map<String, dynamic> json) =>
    _BackupJournal(
      id: (json['id'] as num).toInt(),
      moodType: json['moodType'] as String,
      entryType: json['entryType'] as String? ?? 'fullJournal',
      createdAt: DateTime.parse(json['createdAt'] as String),
      aiResponseEnabled: json['aiResponseEnabled'] as bool,
      content: json['content'] as String?,
      note: json['note'] as String?,
      imageUri: (json['imageUri'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      aiResponse: json['aiResponse'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      address: json['address'] as String?,
      temperature: (json['temperature'] as num?)?.toDouble(),
      weatherIcon: json['weatherIcon'] as String?,
      weatherDescription: json['weatherDescription'] as String?,
      tagNames: (json['tagNames'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$BackupJournalToJson(_BackupJournal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'moodType': instance.moodType,
      'entryType': instance.entryType,
      'createdAt': instance.createdAt.toIso8601String(),
      'aiResponseEnabled': instance.aiResponseEnabled,
      'content': instance.content,
      'note': instance.note,
      'imageUri': instance.imageUri,
      'aiResponse': instance.aiResponse,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'temperature': instance.temperature,
      'weatherIcon': instance.weatherIcon,
      'weatherDescription': instance.weatherDescription,
      'tagNames': instance.tagNames,
    };
