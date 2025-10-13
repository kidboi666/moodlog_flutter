import 'package:flutter/material.dart';
import 'package:moodlog/domain/entities/ai_analysis_report.dart';

abstract interface class AiAnalysisRepository {
  Future<AiAnalysisReport> getAnalysisReport(BuildContext context);
}
