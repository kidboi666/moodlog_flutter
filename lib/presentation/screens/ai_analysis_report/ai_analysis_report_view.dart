import 'package:flutter/material.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/data/repositories/ai_analysis_repository_impl.dart';
import 'package:moodlog/domain/use_cases/get_ai_analysis_report_use_case.dart';
import 'package:moodlog/presentation/screens/ai_analysis_report/ai_analysis_report_view_model.dart';
import 'package:provider/provider.dart';

part 'ai_analysis_report_content.dart';

class AiAnalysisReportScreen extends StatelessWidget {
  const AiAnalysisReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AiAnalysisReportViewModel(
        getAiAnalysisReportUseCase: GetAiAnalysisReportUseCase(
          AiAnalysisRepositoryImpl(),
        ),
      ),
      child: const _AiAnalysisReportContent(),
    );
  }
}
