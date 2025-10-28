import 'dart:convert';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/journal/check_in.dart';
import 'package:moodlog/domain/repositories/gemini_repository.dart';

class GeminiRepositoryImpl implements GeminiRepository {
  late final GenerativeModel _model;

  GeminiRepositoryImpl() {
    _model = FirebaseAI.googleAI().generativeModel(model: 'gemini-2.0-flash');
  }

  @override
  Future<Result<Map<String, String>>> generateMoodSummary({
    required List<CheckIn> checkIns,
    required MoodSummaryPeriod period,
    required DateTime startDate,
    required DateTime endDate,
    required String languageCode,
  }) async {
    try {
      final prompt = _buildPrompt(
        checkIns: checkIns,
        period: period,
        startDate: startDate,
        endDate: endDate,
        languageCode: languageCode,
      );

      final response = await _model.generateContent([Content.text(prompt)]);
      final text = response.text;

      if (text == null || text.isEmpty) {
        return Result.error(Exception('Generated content is empty'));
      }

      final parsedResult = _parseResponse(text);
      return Result.ok(parsedResult);
    } catch (e) {
      return Result.error(Exception('Failed to generate mood summary: $e'));
    }
  }

  String _buildPrompt({
    required List<CheckIn> checkIns,
    required MoodSummaryPeriod period,
    required DateTime startDate,
    required DateTime endDate,
    required String languageCode,
  }) {
    final periodText = _getPeriodText(period, languageCode);
    final checkInSummary = _summarizeCheckIns(checkIns, languageCode);
    final languageInstruction = _getLanguageInstruction(languageCode);

    return '''
${_getExpertIntro(languageCode)} ${_getAnalysisRequest(languageCode, periodText)}

${_getPeriodLabel(languageCode)}: ${_formatDate(startDate)} ~ ${_formatDate(endDate)}
${_getCheckInCountLabel(languageCode)}: ${checkIns.length}${_getTimesLabel(languageCode)}

${_getCheckInDataLabel(languageCode)}:
$checkInSummary

${_getAnalysisInstruction(languageCode)}

1. emotionalFlow: ${_getEmotionalFlowDesc(languageCode)}
2. dominantMoods: ${_getDominantMoodsDesc(languageCode)}
3. activityPatterns: ${_getActivityPatternsDesc(languageCode)}
4. personalAdvice: ${_getPersonalAdviceDesc(languageCode)}
5. keyPoints: ${_getKeyPointsDesc(languageCode)}

${_getResponseFormatLabel(languageCode)} (JSON):
{
  "emotionalFlow": "...",
  "dominantMoods": "...",
  "activityPatterns": "...",
  "personalAdvice": "...",
  "keyPoints": "..."
}

${_getNotesLabel(languageCode)}:
- $languageInstruction
- ${_getEmpathyNote(languageCode)}
- ${_getDataNote(languageCode)}
- ${_getJsonOnlyNote(languageCode)}
''';
  }

  String _getPeriodText(MoodSummaryPeriod period, String languageCode) {
    return switch ((period, languageCode)) {
      (MoodSummaryPeriod.daily, 'ko') => '일간',
      (MoodSummaryPeriod.weekly, 'ko') => '주간',
      (MoodSummaryPeriod.monthly, 'ko') => '월간',
      (MoodSummaryPeriod.daily, 'en') => 'daily',
      (MoodSummaryPeriod.weekly, 'en') => 'weekly',
      (MoodSummaryPeriod.monthly, 'en') => 'monthly',
      (MoodSummaryPeriod.daily, 'ja') => '日次',
      (MoodSummaryPeriod.weekly, 'ja') => '週次',
      (MoodSummaryPeriod.monthly, 'ja') => '月次',
      (_, _) => '일간',
    };
  }

  String _getLanguageInstruction(String languageCode) {
    return switch (languageCode) {
      'ko' => '한국어로 작성',
      'en' => 'Please write in English',
      'ja' => '日本語で作成してください',
      _ => '한국어로 작성',
    };
  }

  String _getExpertIntro(String languageCode) {
    return switch (languageCode) {
      'ko' => '당신은 감정 분석 전문가입니다.',
      'en' => 'You are an emotional analysis expert.',
      'ja' => 'あなたは感情分析の専門家です。',
      _ => '당신은 감정 분석 전문가입니다.',
    };
  }

  String _getAnalysisRequest(String languageCode, String periodText) {
    return switch (languageCode) {
      'ko' => '사용자의 체크인 데이터를 분석하여 $periodText 감정 결산을 작성해주세요.',
      'en' =>
        'Please analyze the user\'s check-in data and create a $periodText emotional summary.',
      'ja' => 'ユーザーのチェックインデータを分析し、$periodText感情まとめを作成してください。',
      _ => '사용자의 체크인 데이터를 분석하여 $periodText 감정 결산을 작성해주세요.',
    };
  }

  String _getPeriodLabel(String languageCode) {
    return switch (languageCode) {
      'ko' => '기간',
      'en' => 'Period',
      'ja' => '期間',
      _ => '기간',
    };
  }

  String _getCheckInCountLabel(String languageCode) {
    return switch (languageCode) {
      'ko' => '총 체크인 횟수',
      'en' => 'Total check-ins',
      'ja' => '総チェックイン回数',
      _ => '총 체크인 횟수',
    };
  }

  String _getTimesLabel(String languageCode) {
    return switch (languageCode) {
      'ko' => '회',
      'en' => ' times',
      'ja' => '回',
      _ => '회',
    };
  }

  String _getCheckInDataLabel(String languageCode) {
    return switch (languageCode) {
      'ko' => '체크인 데이터',
      'en' => 'Check-in data',
      'ja' => 'チェックインデータ',
      _ => '체크인 데이터',
    };
  }

  String _getAnalysisInstruction(String languageCode) {
    return switch (languageCode) {
      'ko' => '다음 5가지 항목으로 분석 결과를 JSON 형식으로 작성해주세요:',
      'en' =>
        'Please write the analysis results in JSON format with the following 5 items:',
      'ja' => '次の5つの項目で分析結果をJSON形式で作成してください：',
      _ => '다음 5가지 항목으로 분석 결과를 JSON 형식으로 작성해주세요:',
    };
  }

  String _getEmotionalFlowDesc(String languageCode) {
    return switch (languageCode) {
      'ko' => '기간 동안의 감정 변화 흐름과 트렌드 (2-3문장)',
      'en' => 'Emotional change flow and trends during the period (2-3 sentences)',
      'ja' => '期間中の感情の変化の流れとトレンド（2-3文）',
      _ => '기간 동안의 감정 변화 흐름과 트렌드 (2-3문장)',
    };
  }

  String _getDominantMoodsDesc(String languageCode) {
    return switch (languageCode) {
      'ko' => '가장 많이 느낀 감정과 그 의미 (2-3문장)',
      'en' => 'Most frequently felt emotions and their meaning (2-3 sentences)',
      'ja' => '最も多く感じた感情とその意味（2-3文）',
      _ => '가장 많이 느낀 감정과 그 의미 (2-3문장)',
    };
  }

  String _getActivityPatternsDesc(String languageCode) {
    return switch (languageCode) {
      'ko' => '활동과 감정의 상관관계 분석 (2-3문장)',
      'en' => 'Analysis of correlation between activities and emotions (2-3 sentences)',
      'ja' => '活動と感情の相関関係の分析（2-3文）',
      _ => '활동과 감정의 상관관계 분석 (2-3문장)',
    };
  }

  String _getPersonalAdviceDesc(String languageCode) {
    return switch (languageCode) {
      'ko' => '데이터 기반 개인화된 조언과 격려 (2-3문장)',
      'en' => 'Data-based personalized advice and encouragement (2-3 sentences)',
      'ja' => 'データに基づいた個別のアドバイスと励まし（2-3文）',
      _ => '데이터 기반 개인화된 조언과 격려 (2-3문장)',
    };
  }

  String _getKeyPointsDesc(String languageCode) {
    return switch (languageCode) {
      'ko' => '주목할 만한 특이사항이나 패턴 (2-3문장)',
      'en' => 'Notable findings or patterns (2-3 sentences)',
      'ja' => '注目すべき特徴やパターン（2-3文）',
      _ => '주목할 만한 특이사항이나 패턴 (2-3문장)',
    };
  }

  String _getResponseFormatLabel(String languageCode) {
    return switch (languageCode) {
      'ko' => '응답 형식',
      'en' => 'Response format',
      'ja' => '応答形式',
      _ => '응답 형식',
    };
  }

  String _getNotesLabel(String languageCode) {
    return switch (languageCode) {
      'ko' => '주의사항',
      'en' => 'Notes',
      'ja' => '注意事項',
      _ => '주의사항',
    };
  }

  String _getEmpathyNote(String languageCode) {
    return switch (languageCode) {
      'ko' => '공감적이고 따뜻한 톤 사용',
      'en' => 'Use empathetic and warm tone',
      'ja' => '共感的で温かいトーンを使用',
      _ => '공감적이고 따뜻한 톤 사용',
    };
  }

  String _getDataNote(String languageCode) {
    return switch (languageCode) {
      'ko' => '구체적인 데이터를 언급하며 분석',
      'en' => 'Analyze by mentioning specific data',
      'ja' => '具体的なデータを言及しながら分析',
      _ => '구체적인 데이터를 언급하며 분석',
    };
  }

  String _getJsonOnlyNote(String languageCode) {
    return switch (languageCode) {
      'ko' => 'JSON 형식만 반환 (다른 텍스트 포함하지 않음)',
      'en' => 'Return only JSON format (do not include other text)',
      'ja' => 'JSON形式のみを返す（他のテキストを含めない）',
      _ => 'JSON 형식만 반환 (다른 텍스트 포함하지 않음)',
    };
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _summarizeCheckIns(List<CheckIn> checkIns, String languageCode) {
    final buffer = StringBuffer();

    for (var i = 0; i < checkIns.length; i++) {
      final checkIn = checkIns[i];
      buffer.writeln('${i + 1}. ${_formatDate(checkIn.createdAt)}');
      buffer.writeln(
        '   - ${_getMoodLabel(languageCode)}: ${_getMoodText(checkIn.moodType, languageCode)} (${checkIn.moodType.score}/5)',
      );

      if (checkIn.emotionNames != null && checkIn.emotionNames!.isNotEmpty) {
        buffer.writeln(
          '   - ${_getEmotionLabel(languageCode)}: ${checkIn.emotionNames!.join(', ')}',
        );
      }

      if (checkIn.activityNames != null && checkIn.activityNames!.isNotEmpty) {
        buffer.writeln(
          '   - ${_getActivityLabel(languageCode)}: ${checkIn.activityNames!.join(', ')}',
        );
      }

      if (checkIn.memo != null && checkIn.memo!.isNotEmpty) {
        buffer.writeln('   - ${_getMemoLabel(languageCode)}: ${checkIn.memo}');
      }

      buffer.writeln();
    }

    return buffer.toString();
  }

  String _getMoodLabel(String languageCode) {
    return switch (languageCode) {
      'ko' => '기분',
      'en' => 'Mood',
      'ja' => '気分',
      _ => '기분',
    };
  }

  String _getEmotionLabel(String languageCode) {
    return switch (languageCode) {
      'ko' => '감정',
      'en' => 'Emotion',
      'ja' => '感情',
      _ => '감정',
    };
  }

  String _getActivityLabel(String languageCode) {
    return switch (languageCode) {
      'ko' => '활동',
      'en' => 'Activity',
      'ja' => '活動',
      _ => '활동',
    };
  }

  String _getMemoLabel(String languageCode) {
    return switch (languageCode) {
      'ko' => '메모',
      'en' => 'Memo',
      'ja' => 'メモ',
      _ => '메모',
    };
  }

  String _getMoodText(MoodType mood, String languageCode) {
    return switch ((mood, languageCode)) {
      (MoodType.veryHappy, 'ko') => '매우 좋음',
      (MoodType.happy, 'ko') => '좋음',
      (MoodType.neutral, 'ko') => '보통',
      (MoodType.sad, 'ko') => '나쁨',
      (MoodType.verySad, 'ko') => '매우 나쁨',
      (MoodType.veryHappy, 'en') => 'Very Good',
      (MoodType.happy, 'en') => 'Good',
      (MoodType.neutral, 'en') => 'Neutral',
      (MoodType.sad, 'en') => 'Bad',
      (MoodType.verySad, 'en') => 'Very Bad',
      (MoodType.veryHappy, 'ja') => 'とても良い',
      (MoodType.happy, 'ja') => '良い',
      (MoodType.neutral, 'ja') => '普通',
      (MoodType.sad, 'ja') => '悪い',
      (MoodType.verySad, 'ja') => 'とても悪い',
      (_, _) => '보통',
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
