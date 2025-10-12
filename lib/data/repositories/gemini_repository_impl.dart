import 'dart:async';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/constants/prompt.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/repositories/gemini_repository.dart';

class GeminiRepositoryImpl implements GeminiRepository {
  static GeminiRepositoryImpl? _instance;

  GeminiRepositoryImpl._();

  static GeminiRepositoryImpl get instance {
    return _instance ??= GeminiRepositoryImpl._();
  }

  AiPersonality? _aiPersonality;
  GenerativeModel? _model;
  bool _isInitialized = false;

  @override
  bool get isInitialized => _isInitialized && _model != null;

  @override
  Future<void> init(AiPersonality aiPersonality) async {
    if (_isInitialized && _aiPersonality == aiPersonality) return;

    _aiPersonality = aiPersonality;

    _model = FirebaseAI.googleAI().generativeModel(
      model: 'gemini-2.5-flash',
      systemInstruction: Content.system(
        Prompt.generateSystemContext(aiPersonality),
      ),
    );

    _isInitialized = true;
  }

  @override
  Future<Result<String>> generateResponse({
    required String prompt,
    required MoodType moodType,
  }) async {
    if (!isInitialized) {
      return Result.error(Exception('Gemini model is not initialized'));
    }
    final response = await _model!.generateContent([
      Content.text(Prompt.generateAnswerPrompt(prompt, moodType)),
    ]);
    return Result.ok(response.text ?? '');
  }

  @override
  void updatePersonality(AiPersonality personality) {
    if (_aiPersonality == personality) return;

    _aiPersonality = personality;
    _isInitialized = false;
    _model = null;
  }
}
