import 'dart:convert';

import 'package:moodlog/domain/entities/ai_analysis_report.dart';
import 'package:moodlog/domain/repositories/ai_analysis_repository.dart';
import 'package:moodlog/domain/repositories/gemini_repository.dart';
import 'package:moodlog/domain/repositories/journal_repository.dart';
import 'package:moodlog/core/utils/result.dart';

class AiAnalysisRepositoryImpl implements AiAnalysisRepository {
  final JournalRepository _journalRepository;
  final GeminiRepository _geminiRepository;

  AiAnalysisRepositoryImpl({
    required JournalRepository journalRepository,
    required GeminiRepository geminiRepository,
  })  : _journalRepository = journalRepository,
        _geminiRepository = geminiRepository;

  @override
  Future<AiAnalysisReport> getAnalysisReport() async {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    final journalsResult = await _journalRepository.getJournals();

    if (journalsResult is Error) {
      throw Exception('Failed to fetch journals for AI analysis.');
    }

    final journals = (journalsResult as Ok).value
        .where((j) => j.createdAt.isAfter(thirtyDaysAgo))
        .toList();

    if (journals.length < 10) {
      // Not enough data to analyze
      return const AiAnalysisReport(
        summary: '분석할 데이터가 충분하지 않습니다. 30일 동안 10개 이상의 일기를 작성해주세요.', // TODO: Localize
        positiveKeywords: [],
        negativeKeywords: [],
      );
    }

    final prompt = _buildPrompt(journals);
    final aiResult = await _geminiRepository.generateResponse(
      prompt: prompt,
      moodType: journals.first.moodType, // MoodType is required, but not critical for this prompt
    );

    switch (aiResult) {
      case Ok<String>():
        try {
          final jsonResponse = jsonDecode(aiResult.value);
          return AiAnalysisReport.fromJson(jsonResponse);
        } catch (e) {
          throw Exception('Failed to parse AI analysis response.');
        }
      case Error<String>():
        throw Exception('Failed to get AI analysis from repository.');
    }
  }

  String _buildPrompt(List<dynamic> journals) {
    final journalEntries = journals.map((j) {
      return {
        "date": j.createdAt.toIso8601String().substring(0, 10),
        "mood": j.moodType.name,
        "content": j.content ?? "",
      };
    }).toList();

    return """
    You are a professional psychological counselor. Based on the user's journal entries from the last 30 days provided below, please conduct an in-depth analysis of their emotional patterns.

    Journal Entries:
    ${jsonEncode(journalEntries)}

    Please provide your analysis in the following JSON format. Do not include any other text or explanations outside of the JSON structure.

    {
      "summary": "Provide a comprehensive but concise summary of the user's emotional state and patterns over the last 30 days. Analyze the overall flow of emotions, identify recurring themes, and offer warm, supportive insights. The summary must be in Korean.",
      "positiveKeywords": ["Extract 3-5 main positive keywords from the journals. Keywords must be in Korean."],
      "negativeKeywords": ["Extract 3-5 main negative keywords from the journals. Keywords must be in Korean."]
    }
    """;
  }
}
