// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_analysis_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AiAnalysisReport _$AiAnalysisReportFromJson(Map<String, dynamic> json) =>
    _AiAnalysisReport(
      summary: json['summary'] as String,
      positiveKeywords: (json['positiveKeywords'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      negativeKeywords: (json['negativeKeywords'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      emotionalPattern: json['emotionalPattern'] as String,
      activityCorrelation: json['activityCorrelation'] as String,
    );

Map<String, dynamic> _$AiAnalysisReportToJson(_AiAnalysisReport instance) =>
    <String, dynamic>{
      'summary': instance.summary,
      'positiveKeywords': instance.positiveKeywords,
      'negativeKeywords': instance.negativeKeywords,
      'emotionalPattern': instance.emotionalPattern,
      'activityCorrelation': instance.activityCorrelation,
    };
