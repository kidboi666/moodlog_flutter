import 'package:moodlog/domain/entities/ai_analysis_report.dart';
import 'package:moodlog/domain/repositories/ai_analysis_repository.dart';

class AiAnalysisRepositoryImpl implements AiAnalysisRepository {
  // TODO: Inject GeminiRepository or similar
  AiAnalysisRepositoryImpl();

  @override
  Future<AiAnalysisReport> getAnalysisReport() async {
    // Simulate network delay and return mock data
    await Future.delayed(const Duration(seconds: 2));

    return const AiAnalysisReport(
      summary: '지난 한 주간, 당신의 감정은 대체로 긍정적인 경향을 보였습니다. 특히 주말에 행복감이 높게 나타났습니다.',
      positiveKeywords: ['휴식', '친구', '산책'],
      negativeKeywords: ['업무', '스트레스', '피로'],
    );
  }
}
