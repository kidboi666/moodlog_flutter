// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_journal_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AddJournalRequest _$AddJournalRequestFromJson(Map<String, dynamic> json) =>
    _AddJournalRequest(
      content: json['content'] as String?,
      moodType: $enumDecode(_$MoodTypeEnumMap, json['moodType']),
      imageUri: (json['imageUri'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      aiResponseEnabled: json['aiResponseEnabled'] as bool,
      aiResponse: json['aiResponse'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$AddJournalRequestToJson(_AddJournalRequest instance) =>
    <String, dynamic>{
      'content': instance.content,
      'moodType': _$MoodTypeEnumMap[instance.moodType]!,
      'imageUri': instance.imageUri,
      'aiResponseEnabled': instance.aiResponseEnabled,
      'aiResponse': instance.aiResponse,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$MoodTypeEnumMap = {
  MoodType.veryHappy: 'veryHappy',
  MoodType.happy: 'happy',
  MoodType.neutral: 'neutral',
  MoodType.sad: 'sad',
  MoodType.verySad: 'verySad',
};
