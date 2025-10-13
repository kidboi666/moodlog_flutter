import 'package:flutter/material.dart';
import 'package:moodlog/core/mixins/async_state_mixin.dart';
import 'package:moodlog/domain/entities/ai_analysis_report.dart';
import 'package:moodlog/domain/use_cases/get_ai_analysis_report_use_case.dart';

class AiAnalysisReportViewModel extends ChangeNotifier with AsyncStateMixin {
  final GetAiAnalysisReportUseCase _getAiAnalysisReportUseCase;

  AiAnalysisReportViewModel({
    required GetAiAnalysisReportUseCase getAiAnalysisReportUseCase,
  }) : _getAiAnalysisReportUseCase = getAiAnalysisReportUseCase {
    fetchReport();
  }

  AiAnalysisReport? _report;
  AiAnalysisReport? get report => _report;

  Future<void> fetchReport() async {
    setLoading();
    try {
      _report = await _getAiAnalysisReportUseCase();
      setSuccess();
    } catch (e) {
      setError(e);
    }
  }
}
