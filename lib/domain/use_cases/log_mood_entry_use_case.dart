import 'package:moodlog/domain/entities/analytics/mood_analytics.dart';
import 'package:moodlog/domain/repositories/analytics_repository.dart';

class LogMoodEntryUseCase {
  final AnalyticsRepository analyticsRepository;

  LogMoodEntryUseCase({required this.analyticsRepository});

  Future<void> call({
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

    await analyticsRepository.logMoodEntry(moodAnalytics);
  }
}
