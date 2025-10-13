import 'package:moodlog/domain/entities/ai_analysis_report.dart';
import 'package:moodlog/domain/repositories/ai_analysis_repository.dart';

class GetAiAnalysisReportUseCase {
  final AiAnalysisRepository _repository;

  GetAiAnalysisReportUseCase(this._repository);

  Future<AiAnalysisReport> call() {
    return _repository.getAnalysisReport();
  }
}
