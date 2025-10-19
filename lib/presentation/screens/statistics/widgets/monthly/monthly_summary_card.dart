import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/statistics/statistics_view_model.dart';
import 'package:moodlog/presentation/widgets/base_card.dart';
import 'package:provider/provider.dart';

class MonthlySummaryCard extends StatelessWidget {
  const MonthlySummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    final checkInDays = context.select<StatisticsViewModel, int>(
      (vm) => vm.monthlyCheckInDays,
    );
    final avgMood = context.select<StatisticsViewModel, double>(
      (vm) => vm.monthlyAverageMood,
    );
    final currentStreak = context.select<StatisticsViewModel, int>(
      (vm) => vm.monthlyCurrentStreak,
    );
    final vsLastMonth = context.select<StatisticsViewModel, double>(
      (vm) => vm.monthlyVsLastMonth,
    );

    return BaseCard(
      title: t.statistics_monthly_summary,
      icon: Icons.calendar_month,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _SummaryItem(
                  label: t.statistics_monthly_checkin_days,
                  value: checkInDays.toString(),
                  unit: t.common_unit_day,
                  icon: Icons.event_available,
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
                  label: t.statistics_monthly_avg_mood,
                  value: avgMood > 0 ? avgMood.toStringAsFixed(1) : '-',
                  icon: Icons.sentiment_satisfied,
                  color: colorScheme.secondary,
                ),
              ),
            ],
          ),
          CommonSizedBox.heightMd,
          Container(
            height: 1,
            color: colorScheme.outlineVariant,
          ),
          CommonSizedBox.heightMd,
          Row(
            children: [
              Expanded(
                child: _SummaryItem(
                  label: t.statistics_monthly_current_streak,
                  value: currentStreak.toString(),
                  unit: t.common_unit_day,
                  icon: Icons.local_fire_department,
                  color: colorScheme.tertiary,
                ),
              ),
              Container(
                width: 1,
                height: 60,
                color: colorScheme.outlineVariant,
              ),
              Expanded(
                child: _SummaryItem(
                  label: t.statistics_monthly_vs_last_month,
                  value: vsLastMonth == 0
                      ? '-'
                      : '${vsLastMonth > 0 ? '+' : ''}${vsLastMonth.toStringAsFixed(1)}',
                  icon: vsLastMonth > 0 ? Icons.trending_up : Icons.trending_down,
                  color: vsLastMonth > 0
                      ? colorScheme.tertiary
                      : vsLastMonth < 0
                          ? colorScheme.error
                          : colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final String? unit;
  final IconData icon;
  final Color color;

  const _SummaryItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        CommonSizedBox.heightSm,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            if (unit != null) ...[
              const SizedBox(width: 2),
              Text(
                unit!,
                style: textTheme.bodySmall?.copyWith(
                  color: color.withValues(alpha: 0.7),
                ),
              ),
            ],
          ],
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
