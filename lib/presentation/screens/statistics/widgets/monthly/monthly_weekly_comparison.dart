import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/domain/entities/journal/check_in.dart';
import 'package:moodlog/presentation/screens/statistics/statistics_view_model.dart';
import 'package:moodlog/presentation/widgets/base_card.dart';
import 'package:provider/provider.dart';

class MonthlyWeeklyComparison extends StatelessWidget {
  const MonthlyWeeklyComparison({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final weeklyGroups = context.select<StatisticsViewModel, Map<int, List<CheckIn>>>(
      (vm) => vm.monthlyWeeklyGroups,
    );

    final weeklyStats = _calculateWeeklyStats(weeklyGroups);
    final maxAvgMood = weeklyStats.values.isEmpty
        ? 5.0
        : weeklyStats.values.map((e) => e.avgMood).reduce((a, b) => a > b ? a : b);

    return BaseCard(
      title: t.statistics_monthly_weekly_comparison,
      icon: Icons.bar_chart,
      child: weeklyStats.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.xl),
                child: Text(
                  t.statistics_mood_distribution_empty,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            )
          : Column(
              children: [
                SizedBox(
                  height: 180,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(5, (index) {
                      final weekNumber = index + 1;
                      final stats = weeklyStats[weekNumber];
                      return _WeekBar(
                        weekNumber: weekNumber,
                        count: stats?.count ?? 0,
                        avgMood: stats?.avgMood ?? 0,
                        maxAvgMood: maxAvgMood,
                      );
                    }),
                  ),
                ),
                CommonSizedBox.heightMd,
                _buildLegend(context),
              ],
            ),
    );
  }

  Map<int, ({int count, double avgMood})> _calculateWeeklyStats(
    Map<int, List<CheckIn>> weeklyGroups,
  ) {
    final Map<int, ({int count, double avgMood})> stats = {};

    weeklyGroups.forEach((weekNumber, checkIns) {
      if (checkIns.isEmpty) return;

      final count = checkIns.length;
      final avgMood = checkIns.map((c) => c.moodType.score).reduce((a, b) => a + b) / count;

      stats[weekNumber] = (count: count, avgMood: avgMood);
    });

    return stats;
  }

  Widget _buildLegend(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _LegendItem(
          color: colorScheme.primary,
          label: t.statistics_monthly_avg_mood,
        ),
        CommonSizedBox.widthMd,
        _LegendItem(
          color: colorScheme.secondary,
          label: t.statistics_monthly_checkin_count,
        ),
      ],
    );
  }
}

class _WeekBar extends StatelessWidget {
  final int weekNumber;
  final int count;
  final double avgMood;
  final double maxAvgMood;

  const _WeekBar({
    required this.weekNumber,
    required this.count,
    required this.avgMood,
    required this.maxAvgMood,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final heightRatio = maxAvgMood > 0 ? (avgMood / maxAvgMood).clamp(0.0, 1.0) : 0.0;
    final barHeight = count > 0 ? (140 * heightRatio).clamp(20.0, 140.0) : 8.0;

    Color getBarColor() {
      if (count == 0) return colorScheme.surfaceContainerHighest;
      if (avgMood >= 4.0) return colorScheme.tertiary;
      if (avgMood >= 3.0) return colorScheme.primary;
      if (avgMood >= 2.0) return colorScheme.secondary;
      return colorScheme.error;
    }

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (count > 0) ...[
            Text(
              avgMood.toStringAsFixed(1),
              style: textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: getBarColor(),
              ),
            ),
            CommonSizedBox.heightXs,
          ],
          Container(
            height: barHeight,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: getBarColor(),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(4),
              ),
            ),
            child: count > 0
                ? Center(
                    child: Text(
                      count.toString(),
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : null,
          ),
          CommonSizedBox.heightSm,
          Text(
            '$weekNumber${t.statistics_monthly_week_suffix}',
            style: textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        CommonSizedBox.widthXs,
        Text(
          label,
          style: textTheme.labelSmall,
        ),
      ],
    );
  }
}
