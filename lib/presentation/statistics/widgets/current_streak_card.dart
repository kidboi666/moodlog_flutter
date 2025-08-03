import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/common.dart';
import '../../../common/l10n/app_localizations.dart';
import '../viewmodel/statistics_viewmodel.dart';
import 'base_card.dart';

class CurrentStreakCard extends StatelessWidget {
  const CurrentStreakCard({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<StatisticsViewModel>();
    final currentStreak = viewModel.currentStreak;
    final allJournals = viewModel.allJournals;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;

    final lastRecordDate = allJournals.isNotEmpty
        ? allJournals
            .map((j) => j.createdAt)
            .reduce((a, b) => a.isAfter(b) ? a : b)
        : null;

    final daysSinceLastRecord = lastRecordDate != null
        ? DateTime.now().difference(lastRecordDate).inDays
        : 0;

    final isStreakActive = daysSinceLastRecord <= 1;
    final streakStatus = isStreakActive ? t.statistics_streak_status_active : t.statistics_streak_status_inactive;
    final streakColor = isStreakActive ? colorScheme.primary : colorScheme.error;

    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.local_fire_department,
                color: streakColor,
                size: 24,
              ),
              const SizedBox(width: Spacing.sm),
              Text(
                t.statistics_total_streak_description,
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
                      currentStreak.toString(),
                      style: textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: streakColor,
                      ),
                    ),
                    const SizedBox(width: Spacing.xs),
                    Text(
                      '일',
                      style: textTheme.titleLarge?.copyWith(
                        color: streakColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Spacing.xs),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.sm,
                    vertical: Spacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: streakColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    streakStatus,
                    style: textTheme.bodySmall?.copyWith(
                      color: streakColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (lastRecordDate != null) ...[
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
                        t.statistics_streak_last_record,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        daysSinceLastRecord == 0
                            ? t.statistics_streak_today
                            : daysSinceLastRecord == 1
                                ? t.statistics_streak_yesterday
                                : t.statistics_streak_days_ago(daysSinceLastRecord),
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  if (!isStreakActive && currentStreak > 0) ...[
                    const SizedBox(height: Spacing.sm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          t.statistics_streak_stopped,
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.error,
                          ),
                        ),
                        Text(
                          t.statistics_streak_stopped_days(daysSinceLastRecord - 1),
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: colorScheme.error,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
          if (isStreakActive && currentStreak > 0) ...[
            const SizedBox(height: Spacing.md),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(Spacing.md),
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: colorScheme.primary.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.emoji_events,
                    color: colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: Spacing.sm),
                  Expanded(
                    child: Text(
                      t.statistics_streak_encouragement,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.primary,
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