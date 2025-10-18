import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/statistics/statistics_view_model.dart';
import 'package:moodlog/presentation/widgets/base_card.dart';
import 'package:provider/provider.dart';

class WeeklySummaryCard extends StatelessWidget {
  const WeeklySummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final totalCheckIns = context.select<StatisticsViewModel, int>(
      (vm) => vm.weeklyCheckInsList.length,
    );
    final avgMood = context.select<StatisticsViewModel, double>(
      (vm) => vm.weeklyAverageMood,
    );
    final mostFrequentMood = context.select<StatisticsViewModel, MoodType?>(
      (vm) => vm.weeklyMostFrequentMood,
    );

    return BaseCard(
      title: t.statistics_weekly_summary,
      icon: Icons.calendar_view_week,
      child: Row(
        children: [
          Expanded(
            child: _SummaryItem(
              label: t.statistics_weekly_total_checkins,
              value: totalCheckIns.toString(),
              icon: Icons.check_circle_outline,
              color: colorScheme.primary,
            ),
          ),
          Container(
            width: 1,
            height: 60,
            color: colorScheme.outlineVariant,
          ),
          Expanded(
            child: _SummaryItem(
              label: t.statistics_weekly_avg_mood,
              value: avgMood > 0 ? avgMood.toStringAsFixed(1) : '-',
              icon: Icons.sentiment_satisfied_alt,
              color: colorScheme.secondary,
            ),
          ),
          Container(
            width: 1,
            height: 60,
            color: colorScheme.outlineVariant,
          ),
          Expanded(
            child: _SummaryItem(
              label: t.statistics_weekly_most_frequent_mood,
              value: mostFrequentMood?.emoji ?? '-',
              valueStyle: textTheme.headlineLarge,
              icon: Icons.trending_up,
              color: mostFrequentMood != null
                  ? Color(mostFrequentMood.colorValue)
                  : colorScheme.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final TextStyle? valueStyle;

  const _SummaryItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        CommonSizedBox.heightSm,
        Text(
          value,
          style:
              valueStyle ??
              textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
        ),
        CommonSizedBox.heightXs,
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            color: color.withValues(alpha: 0.7),
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
