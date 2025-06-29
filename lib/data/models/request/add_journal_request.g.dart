// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_journal_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AddJournalRequest _$AddJournalRequestFromJson(Map<String, dynamic> json) =>
    _AddJournalRequest(
      content: json['content'] as String?,
      moodName: json['moodName'] as String,
      imageUri: (json['imageUri'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      aiEnabled: json['aiEnabled'] as bool?,
    );

Map<String, dynamic> _$AddJournalRequestToJson(_AddJournalRequest instance) =>
    <String, dynamic>{
      'content': instance.content,
      'moodName': instance.moodName,
      'imageUri': instance.imageUri,
      'aiEnabled': instance.aiEnabled,
    };
