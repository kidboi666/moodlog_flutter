import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_analysis_report.freezed.dart';
part 'ai_analysis_report.g.dart';

@freezed
abstract class AiAnalysisReport with _$AiAnalysisReport {
  const factory AiAnalysisReport({
    required String summary,
    required List<String> positiveKeywords,
    required List<String> negativeKeywords,
    required String emotionalPattern,
    required String tagCorrelation,
  }) = _AiAnalysisReport;

  factory AiAnalysisReport.fromJson(Map<String, dynamic> json) =>
      _$AiAnalysisReportFromJson(json);
}
