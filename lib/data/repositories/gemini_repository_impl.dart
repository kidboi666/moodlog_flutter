import 'dart:convert';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/journal/check_in.dart';
import 'package:moodlog/domain/repositories/gemini_repository.dart';

class GeminiRepositoryImpl implements GeminiRepository {
  late final GenerativeModel _model;

  GeminiRepositoryImpl() {
    _model = FirebaseAI.googleAI().generativeModel(
      model: 'gemini-1.5-flash',
    );
  }

  @override
  Future<Result<Map<String, String>>> generateMoodSummary({
    required List<CheckIn> checkIns,
    required MoodSummaryPeriod period,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final prompt = _buildPrompt(
        checkIns: checkIns,
        period: period,
        startDate: startDate,
        endDate: endDate,
      );

      final response = await _model.generateContent([Content.text(prompt)]);
      final text = response.text;

      if (text == null || text.isEmpty) {
        return Result.error(
          Exception('Generated content is empty'),
        );
      }

      final parsedResult = _parseResponse(text);
      return Result.ok(parsedResult);
    } catch (e) {
      return Result.error(
        Exception('Failed to generate mood summary: $e'),
      );
    }
  }

  String _buildPrompt({
    required List<CheckIn> checkIns,
    required MoodSummaryPeriod period,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    final periodText = _getPeriodText(period);
    final checkInSummary = _summarizeCheckIns(checkIns);

    return '''
당신은 감정 분석 전문가입니다. 사용자의 체크인 데이터를 분석하여 $periodText 감정 결산을 작성해주세요.

기간: ${_formatDate(startDate)} ~ ${_formatDate(endDate)}
총 체크인 횟수: ${checkIns.length}회

체크인 데이터:
$checkInSummary

다음 5가지 항목으로 분석 결과를 JSON 형식으로 작성해주세요:

1. emotionalFlow: 기간 동안의 감정 변화 흐름과 트렌드 (2-3문장)
2. dominantMoods: 가장 많이 느낀 감정과 그 의미 (2-3문장)
3. activityPatterns: 활동과 감정의 상관관계 분석 (2-3문장)
4. personalAdvice: 데이터 기반 개인화된 조언과 격려 (2-3문장)
5. keyPoints: 주목할 만한 특이사항이나 패턴 (2-3문장)

응답 형식 (JSON):
{
  "emotionalFlow": "...",
  "dominantMoods": "...",
  "activityPatterns": "...",
  "personalAdvice": "...",
  "keyPoints": "..."
}

주의사항:
- 한국어로 작성
- 공감적이고 따뜻한 톤 사용
- 구체적인 데이터를 언급하며 분석
- JSON 형식만 반환 (다른 텍스트 포함하지 않음)
''';
  }

  String _getPeriodText(MoodSummaryPeriod period) {
    return switch (period) {
      MoodSummaryPeriod.daily => '일간',
      MoodSummaryPeriod.weekly => '주간',
      MoodSummaryPeriod.monthly => '월간',
    };
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _summarizeCheckIns(List<CheckIn> checkIns) {
    final buffer = StringBuffer();

    for (var i = 0; i < checkIns.length; i++) {
      final checkIn = checkIns[i];
      buffer.writeln('${i + 1}. ${_formatDate(checkIn.createdAt)}');
      buffer.writeln('   - 기분: ${_getMoodText(checkIn.moodType)} (${checkIn.moodType.score}/5)');

      if (checkIn.emotionNames != null && checkIn.emotionNames!.isNotEmpty) {
        buffer.writeln('   - 감정: ${checkIn.emotionNames!.join(', ')}');
      }

      if (checkIn.activityNames != null && checkIn.activityNames!.isNotEmpty) {
        buffer.writeln('   - 활동: ${checkIn.activityNames!.join(', ')}');
      }

      if (checkIn.memo != null && checkIn.memo!.isNotEmpty) {
        buffer.writeln('   - 메모: ${checkIn.memo}');
      }

      buffer.writeln();
    }

    return buffer.toString();
  }

  String _getMoodText(MoodType mood) {
    return switch (mood) {
      MoodType.veryHappy => '매우 좋음',
      MoodType.happy => '좋음',
      MoodType.neutral => '보통',
      MoodType.sad => '나쁨',
      MoodType.verySad => '매우 나쁨',
    };
  }

  Map<String, String> _parseResponse(String text) {
    try {
      final cleanedText = text.trim();
      final jsonStart = cleanedText.indexOf('{');
      final jsonEnd = cleanedText.lastIndexOf('}') + 1;

      if (jsonStart == -1 || jsonEnd == 0) {
        throw Exception('Invalid JSON format in response');
      }

      final jsonText = cleanedText.substring(jsonStart, jsonEnd);
      final Map<String, dynamic> parsed = json.decode(jsonText);

      return {
        'emotionalFlow': parsed['emotionalFlow']?.toString() ?? '',
        'dominantMoods': parsed['dominantMoods']?.toString() ?? '',
        'activityPatterns': parsed['activityPatterns']?.toString() ?? '',
        'personalAdvice': parsed['personalAdvice']?.toString() ?? '',
        'keyPoints': parsed['keyPoints']?.toString() ?? '',
      };
    } catch (e) {
      return {
        'emotionalFlow': '분석 결과를 파싱하는데 실패했습니다.',
        'dominantMoods': '분석 결과를 파싱하는데 실패했습니다.',
        'activityPatterns': '분석 결과를 파싱하는데 실패했습니다.',
        'personalAdvice': '다시 시도해주세요.',
        'keyPoints': '분석 결과를 파싱하는데 실패했습니다.',
      };
    }
  }
}
