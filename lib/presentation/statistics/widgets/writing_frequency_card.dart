import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/common.dart';
import '../../../common/l10n/app_localizations.dart';
import '../viewmodel/statistics_viewmodel.dart';
import 'base_card.dart';

class WritingFrequencyCard extends StatelessWidget {
  const WritingFrequencyCard({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<StatisticsViewModel>();
    final allJournals = viewModel.allJournals;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;

    if (allJournals.isEmpty) {
      return const SizedBox.shrink();
    }

    final now = DateTime.now();
    final oneWeekAgo = now.subtract(const Duration(days: 7));
    final oneMonthAgo = now.subtract(const Duration(days: 30));

    final weeklyEntries = allJournals
        .where((journal) => journal.createdAt.isAfter(oneWeekAgo))
        .length;

    final monthlyEntries = allJournals
        .where((journal) => journal.createdAt.isAfter(oneMonthAgo))
        .length;

    final firstEntry = allJournals.isNotEmpty
        ? allJournals
              .map((j) => j.createdAt)
              .reduce((a, b) => a.isBefore(b) ? a : b)
        : now;

    final totalDays = now.difference(firstEntry).inDays + 1;
    final weeklyAverage = totalDays >= 7
        ? (allJournals.length / totalDays * 7)
        : weeklyEntries.toDouble();
    final monthlyAverage = totalDays >= 30
        ? (allJournals.length / totalDays * 30)
        : monthlyEntries.toDouble();

    final weeklyFrequencyText = weeklyEntries >= 7
        ? t.statistics_writing_frequency_daily
        : weeklyEntries >= 5
        ? t.statistics_writing_frequency_often
        : weeklyEntries >= 3
        ? t.statistics_writing_frequency_normal
        : weeklyEntries >= 1
        ? t.statistics_writing_frequency_sometimes
        : t.statistics_writing_frequency_none;

    final weeklyFrequencyColor = weeklyEntries >= 7
        ? Colors.green
        : weeklyEntries >= 5
        ? Colors.blue
        : weeklyEntries >= 3
        ? colorScheme.primary
        : weeklyEntries >= 1
        ? Colors.orange
        : Colors.red;

    final Map<int, int> hourlyDistribution = {};
    for (var journal in allJournals) {
      final hour = journal.createdAt.hour;
      hourlyDistribution[hour] = (hourlyDistribution[hour] ?? 0) + 1;
    }

    final mostActiveHour = hourlyDistribution.isNotEmpty
        ? hourlyDistribution.entries
              .reduce((a, b) => a.value > b.value ? a : b)
              .key
        : 12;

    String getTimeOfDayText(int hour) {
      if (hour >= 6 && hour < 12) {
        return t.statistics_time_with_hour(t.statistics_time_morning, hour);
      } else if (hour >= 12 && hour < 18) {
        return t.statistics_time_with_hour(t.statistics_time_afternoon, hour);
      } else if (hour >= 18 && hour < 22) {
        return t.statistics_time_with_hour(t.statistics_time_evening, hour);
      } else {
        return t.statistics_time_with_hour(t.statistics_time_night, hour);
      }
    }

    final Map<int, int> weekdayDistribution = {};
    for (var journal in allJournals) {
      final weekday = journal.createdAt.weekday;
      weekdayDistribution[weekday] = (weekdayDistribution[weekday] ?? 0) + 1;
    }

    final mostActiveWeekday = weekdayDistribution.isNotEmpty
        ? weekdayDistribution.entries
              .reduce((a, b) => a.value > b.value ? a : b)
              .key
        : 1;

    final weekdayNames = [
      t.common_weekday_mon,
      t.common_weekday_tue,
      t.common_weekday_wed,
      t.common_weekday_thu,
      t.common_weekday_fri,
      t.common_weekday_sat,
      t.common_weekday_sun,
    ];

    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.schedule, color: colorScheme.secondary, size: 24),
              const SizedBox(width: Spacing.sm),
              Text(
                t.statistics_writing_frequency_title,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.lg),
          Container(
            padding: const EdgeInsets.all(Spacing.md),
            decoration: BoxDecoration(
              color: weeklyFrequencyColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: weeklyFrequencyColor.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.statistics_writing_frequency_this_week,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          weeklyEntries.toString(),
                          style: textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: weeklyFrequencyColor,
                          ),
                        ),
                        Text(
                          t.statistics_writing_frequency_count_unit,
                          style: textTheme.bodyLarge?.copyWith(
                            color: weeklyFrequencyColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.sm,
                    vertical: Spacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: weeklyFrequencyColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    weeklyFrequencyText,
                    style: textTheme.bodySmall?.copyWith(
                      color: weeklyFrequencyColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: Spacing.lg),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(Spacing.md),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest.withValues(
                      alpha: 0.3,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        t.statistics_writing_frequency_weekly_avg,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: Spacing.xs),
                      Text(
                        t.statistics_writing_frequency_weekly_count(
                          weeklyAverage.toStringAsFixed(1),
                        ),
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: Spacing.md),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(Spacing.md),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest.withValues(
                      alpha: 0.3,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        t.statistics_writing_frequency_monthly_avg,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: Spacing.xs),
                      Text(
                        t.statistics_writing_frequency_monthly_count(
                          monthlyAverage.toStringAsFixed(1),
                        ),
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.lg),
          Container(
            padding: const EdgeInsets.all(Spacing.md),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      t.statistics_writing_frequency_most_active_time,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      getTimeOfDayText(mostActiveHour),
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Spacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      t.statistics_writing_frequency_most_active_day,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      weekdayNames[mostActiveWeekday - 1],
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (weeklyEntries >= 5) ...[
            const SizedBox(height: Spacing.md),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(Spacing.md),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.green, size: 20),
                  const SizedBox(width: Spacing.sm),
                  Expanded(
                    child: Text(
                      t.statistics_writing_frequency_good_habit,
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ] else if (weeklyEntries < 2) ...[
            const SizedBox(height: Spacing.md),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(Spacing.md),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.lightbulb_outline,
                    color: Colors.blue,
                    size: 20,
                  ),
                  const SizedBox(width: Spacing.sm),
                  Expanded(
                    child: Text(
                      t.statistics_writing_frequency_encouragement,
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.blue,
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
