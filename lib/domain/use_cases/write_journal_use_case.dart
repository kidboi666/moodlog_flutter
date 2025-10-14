import 'dart:io';

import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/ai/ai_usage.dart';
import 'package:moodlog/domain/entities/analytics/mood_analytics.dart';
import 'package:moodlog/domain/repositories/analytics_repository.dart';
import 'package:moodlog/domain/repositories/gemini_repository.dart';
import 'package:moodlog/domain/repositories/image_repository.dart';
import 'package:moodlog/domain/repositories/settings_repository.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class WriteJournalUseCase {
  final GeminiRepository _geminiRepository;
  final SettingsRepository _settingsRepository;
  final ImageRepository _imageRepository;
  final AnalyticsRepository _analyticsRepository;

  WriteJournalUseCase({
    required GeminiRepository geminiRepository,
    required SettingsRepository settingsRepository,
    required ImageRepository imageRepository,
    required AnalyticsRepository analyticsRepository,
  }) : _geminiRepository = geminiRepository,
       _settingsRepository = settingsRepository,
       _imageRepository = imageRepository,
       _analyticsRepository = analyticsRepository;

  Future<void> initializeAi(AiPersonality aiPersonality) {
    return _geminiRepository.init(aiPersonality);
  }

  Future<Result<String>> generateAiResponse({
    required String prompt,
    required MoodType moodType,
    List<String>? imagePaths,
  }) {
    return _geminiRepository.generateResponse(
      prompt: prompt,
      moodType: moodType,
      imagePaths: imagePaths,
    );
  }

  Future<bool> canUseAiToday() async {
    final usage = await _settingsRepository.getAiUsage();
    final now = DateTime.now();

    if (usage == null) {
      return true;
    }

    final isSameDay = usage.date.year == now.year &&
                      usage.date.month == now.month &&
                      usage.date.day == now.day;

    if (isSameDay) {
      return usage.count < 3;
    } else {
      return true;
    }
  }

  Future<AiUsage?> getAiUsage() {
    return _settingsRepository.getAiUsage();
  }

  Future<void> recordAiUsage() async {
    final now = DateTime.now();
    final usage = await _settingsRepository.getAiUsage();

    if (usage != null) {
      final isSameDay = usage.date.year == now.year &&
                        usage.date.month == now.month &&
                        usage.date.day == now.day;

      if (isSameDay) {
        await _settingsRepository.updateAiUsage(
          AiUsage(date: now, count: usage.count + 1),
        );
      } else {
        await _settingsRepository.updateAiUsage(
          AiUsage(date: now, count: 1),
        );
      }
    } else {
      await _settingsRepository.updateAiUsage(
        AiUsage(date: now, count: 1),
      );
    }
  }

  Future<Result<String?>> pickAndSaveImage() async {
    final result = await _imageRepository.pickImageFromGallery();

    switch (result) {
      case Ok<String?>():
        final pickedImagePath = result.value;
        if (pickedImagePath == null) {
          return Result.ok(null);
        }

        try {
          final appDocDir = await getApplicationDocumentsDirectory();
          final fileName = p.basename(pickedImagePath);
          final savedImagePath = '${appDocDir.path}/images/$fileName';

          final imagesDir = Directory('${appDocDir.path}/images');
          if (!await imagesDir.exists()) {
            await imagesDir.create(recursive: true);
          }

          final pickedImageFile = File(pickedImagePath);
          await pickedImageFile.copy(savedImagePath);

          return Result.ok(savedImagePath);
        } catch (e) {
          return Result.error(Exception('Failed to save image: $e'));
        }
      case Error<String?>():
        return Result.error(result.error);
    }
  }

  Future<void> logMoodEntry({
    required String moodType,
    required String entryType,
    bool hasImage = false,
    bool hasTag = false,
  }) async {
    final moodAnalytics = MoodAnalytics(
      moodType: moodType,
      entryType: entryType,
      hasImage: hasImage,
      hasTag: hasTag,
    );

    await _analyticsRepository.logMoodEntry(moodAnalytics);
  }
}
