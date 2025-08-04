import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/common.dart';
import '../../../common/l10n/app_localizations.dart';
import '../viewmodel/statistics_viewmodel.dart';
import 'base_card.dart';

class MaxStreakCard extends StatelessWidget {
  const MaxStreakCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;

    return Selector<StatisticsViewModel, ({int maxStreak, int currentStreak})>(
      selector: (_, viewModel) => (
        maxStreak: viewModel.maxStreak,
        currentStreak: viewModel.currentStreak,
      ),
      builder: (_, data, __) {
        final maxStreak = data.maxStreak;
        final currentStreak = data.currentStreak;

        final isPersonalRecord = currentStreak == maxStreak && maxStreak > 0;
        final progressPercentage = maxStreak > 0
            ? (currentStreak / maxStreak)
            : 0.0;

        return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.emoji_events, color: colorScheme.tertiary, size: 24),
              const SizedBox(width: Spacing.sm),
              Text(
                t.statistics_total_streak_max_description,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.lg),
          Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      maxStreak.toString(),
                      style: textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.tertiary,
                      ),
                    ),
                    const SizedBox(width: Spacing.xs),
                    Text(
                      '일',
                      style: textTheme.titleLarge?.copyWith(
                        color: colorScheme.tertiary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                if (isPersonalRecord) ...[
                  const SizedBox(height: Spacing.xs),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Spacing.sm,
                      vertical: Spacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.tertiary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, size: 16, color: colorScheme.tertiary),
                        const SizedBox(width: Spacing.xs),
                        Text(
                          t.statistics_max_streak_new_record,
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.tertiary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (maxStreak > 0) ...[
            const SizedBox(height: Spacing.lg),
            Container(
              padding: const EdgeInsets.all(Spacing.md),
              decoration: BoxDecoration(
                color: colorScheme.surfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        t.statistics_max_streak_progress,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        '${(progressPercentage * 100).round()}%',
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Spacing.sm),
                  LinearProgressIndicator(
                    value: progressPercentage,
                    backgroundColor: colorScheme.surfaceVariant,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      colorScheme.tertiary,
                    ),
                  ),
                  const SizedBox(height: Spacing.sm),
                  if (!isPersonalRecord) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          t.statistics_max_streak_remaining,
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          t.statistics_max_streak_remaining_days(
                            maxStreak - currentStreak,
                          ),
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: colorScheme.tertiary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
          if (maxStreak >= 7) ...[
            const SizedBox(height: Spacing.md),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(Spacing.md),
              decoration: BoxDecoration(
                color: colorScheme.tertiary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: colorScheme.tertiary.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.military_tech,
                    color: colorScheme.tertiary,
                    size: 20,
                  ),
                  const SizedBox(width: Spacing.sm),
                  Expanded(
                    child: Text(
                      maxStreak >= 30
                          ? t.statistics_max_streak_achievement_month
                          : maxStreak >= 14
                          ? t.statistics_max_streak_achievement_two_weeks
                          : t.statistics_max_streak_achievement_week,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.tertiary,
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
      },
    );
  }
}
