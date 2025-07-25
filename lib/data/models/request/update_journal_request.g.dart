// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_journal_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateJournalRequest _$UpdateJournalRequestFromJson(
  Map<String, dynamic> json,
) => _UpdateJournalRequest(
  id: (json['id'] as num).toInt(),
  content: json['content'] as String?,
  imageUri: (json['imageUri'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  aiResponse: json['aiResponse'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  address: json['address'] as String?,
);

Map<String, dynamic> _$UpdateJournalRequestToJson(
  _UpdateJournalRequest instance,
) => <String, dynamic>{
  'id': instance.id,
  'content': instance.content,
  'imageUri': instance.imageUri,
  'aiResponse': instance.aiResponse,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'address': instance.address,
};
