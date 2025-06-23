// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Journal _$JournalFromJson(Map<String, dynamic> json) => _Journal(
  id: (json['id'] as num).toInt(),
  content: json['content'] as String?,
  moodName: json['moodName'] as String,
  imageUri: json['imageUri'] as String?,
  aiResponseEnabled: json['aiResponseEnabled'] as bool,
  aiResponse: json['aiResponse'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$JournalToJson(_Journal instance) => <String, dynamic>{
  'id': instance.id,
  'content': instance.content,
  'moodName': instance.moodName,
  'imageUri': instance.imageUri,
  'aiResponseEnabled': instance.aiResponseEnabled,
  'aiResponse': instance.aiResponse,
  'createdAt': instance.createdAt.toIso8601String(),
};
