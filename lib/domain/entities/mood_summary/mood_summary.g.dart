// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MoodSummary _$MoodSummaryFromJson(Map<String, dynamic> json) => _MoodSummary(
  id: (json['id'] as num).toInt(),
  period: $enumDecode(_$MoodSummaryPeriodEnumMap, json['period']),
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  generatedAt: DateTime.parse(json['generatedAt'] as String),
  emotionalFlow: json['emotionalFlow'] as String,
  dominantMoods: json['dominantMoods'] as String,
  activityPatterns: json['activityPatterns'] as String,
  personalAdvice: json['personalAdvice'] as String,
  keyPoints: json['keyPoints'] as String,
  metadata: json['metadata'] as Map<String, dynamic>,
);

Map<String, dynamic> _$MoodSummaryToJson(_MoodSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'period': _$MoodSummaryPeriodEnumMap[instance.period]!,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'generatedAt': instance.generatedAt.toIso8601String(),
      'emotionalFlow': instance.emotionalFlow,
      'dominantMoods': instance.dominantMoods,
      'activityPatterns': instance.activityPatterns,
      'personalAdvice': instance.personalAdvice,
      'keyPoints': instance.keyPoints,
      'metadata': instance.metadata,
    };

const _$MoodSummaryPeriodEnumMap = {
  MoodSummaryPeriod.daily: 'daily',
  MoodSummaryPeriod.weekly: 'weekly',
  MoodSummaryPeriod.monthly: 'monthly',
};
