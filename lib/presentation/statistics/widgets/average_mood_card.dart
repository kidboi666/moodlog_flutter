import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/constants/enum.dart';
import '../../../core/extensions/enum.dart';
import '../../../core/l10n/app_localizations.dart';
import '../statistics_viewmodel.dart';
import 'base_card.dart';

class AverageMoodCard extends StatelessWidget {
  const AverageMoodCard({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<StatisticsViewModel>();
    final allJournals = viewModel.allJournals;
    final moodCounts = viewModel.moodCounts;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;

    if (allJournals.isEmpty) {
      return const SizedBox.shrink();
    }

    final totalScore = allJournals.fold<double>(
      0.0,
      (sum, journal) => sum + journal.moodType.score,
    );
    final averageScore = totalScore / allJournals.length;

    MoodType dominantMood = MoodType.neutral;
    String averageMoodText = '';
    Color averageMoodColor = colorScheme.primary;

    if (averageScore >= 4.5) {
      dominantMood = MoodType.veryHappy;
      averageMoodText = MoodType.veryHappy.getDisplayName(context);
      averageMoodColor = MoodType.veryHappy.color;
    } else if (averageScore >= 3.5) {
      dominantMood = MoodType.happy;
      averageMoodText = MoodType.happy.getDisplayName(context);
      averageMoodColor = MoodType.happy.color;
    } else if (averageScore >= 2.5) {
      dominantMood = MoodType.neutral;
      averageMoodText = MoodType.neutral.getDisplayName(context);
      averageMoodColor = MoodType.neutral.color;
    } else if (averageScore >= 1.5) {
      dominantMood = MoodType.sad;
      averageMoodText = MoodType.sad.getDisplayName(context);
      averageMoodColor = MoodType.sad.color;
    } else {
      dominantMood = MoodType.verySad;
      averageMoodText = MoodType.verySad.getDisplayName(context);
      averageMoodColor = MoodType.verySad.color;
    }

    final mostFrequentMood = moodCounts.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;

    final recentMoods = allJournals
        .map((j) => j.moodType.score)
        .take(7)
        .toList()
        .reversed
        .toList();

    final recentAverage = recentMoods.isNotEmpty
        ? recentMoods.reduce((a, b) => a + b) / recentMoods.length
        : averageScore;

    final trendIndicator = recentAverage > averageScore
        ? t.statistics_trend_rising
        : recentAverage < averageScore
        ? t.statistics_trend_falling
        : t.statistics_trend_stable;

    final trendIcon = recentAverage > averageScore
        ? Icons.trending_up
        : recentAverage < averageScore
        ? Icons.trending_down
        : Icons.trending_flat;

    final trendColor = recentAverage > averageScore
        ? Colors.green
        : recentAverage < averageScore
        ? Colors.red
        : colorScheme.onSurfaceVariant;

    return BaseCard(
      title: t.statistics_average_mood_title,
      icon: Icons.mood,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Text(dominantMood.emoji, style: const TextStyle(fontSize: 48)),
                const SizedBox(height: Spacing.sm),
                Text(
                  averageMoodText,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: averageMoodColor,
                  ),
                ),
                Text(
                  t.statistics_average_mood_score(
                    averageScore.toStringAsFixed(1),
                  ),
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: Spacing.lg),
          Container(
            padding: const EdgeInsets.all(Spacing.lg),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(Roundness.cardInner),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      t.statistics_average_mood_most_frequent,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          mostFrequentMood.emoji,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: Spacing.xs),
                        Text(
                          mostFrequentMood.getDisplayName(context),
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: Spacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      t.statistics_average_mood_recent_trend,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(trendIcon, color: trendColor, size: 16),
                        const SizedBox(width: Spacing.xs),
                        Text(
                          trendIndicator,
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: trendColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (averageScore >= 4.0) ...[
            const SizedBox(height: Spacing.md),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(Spacing.lg),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(Roundness.cardInner),
                border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.sentiment_very_satisfied,
                    color: Colors.green,
                    size: 20,
                  ),
                  const SizedBox(width: Spacing.sm),
                  Expanded(
                    child: Text(
                      t.statistics_mood_positive_message,
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ] else if (averageScore < 2.5) ...[
            const SizedBox(height: Spacing.md),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(Spacing.lg),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(Roundness.cardInner),
                border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.sentiment_dissatisfied,
                    color: Colors.orange,
                    size: 20,
                  ),
                  const SizedBox(width: Spacing.sm),
                  Expanded(
                    child: Text(
                      t.statistics_mood_negative_message,
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.orange,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
