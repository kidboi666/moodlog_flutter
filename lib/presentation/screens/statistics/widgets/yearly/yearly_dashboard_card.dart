import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/statistics/statistics_view_model.dart';
import 'package:moodlog/presentation/widgets/base_card.dart';
import 'package:provider/provider.dart';

class YearlyDashboardCard extends StatelessWidget {
  const YearlyDashboardCard({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    final totalCheckIns = context.select<StatisticsViewModel, int>(
      (vm) => vm.yearlyTotalCheckIns,
    );
    final avgMood = context.select<StatisticsViewModel, double>(
      (vm) => vm.yearlyAverageMood,
    );
    final bestMonth = context.select<StatisticsViewModel, String>(
      (vm) => vm.yearlyBestMonth,
    );
    final worstMonth = context.select<StatisticsViewModel, String>(
      (vm) => vm.yearlyWorstMonth,
    );

    return BaseCard(
      title: t.statistics_yearly_dashboard,
      icon: Icons.dashboard,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _DashboardItem(
                  label: t.statistics_yearly_total_checkins,
                  value: totalCheckIns.toString(),
                  unit: t.common_unit_day,
                  icon: Icons.event_note,
                  color: colorScheme.primary,
                ),
              ),
              Container(
                width: 1,
                height: 60,
                color: colorScheme.outlineVariant,
              ),
              Expanded(
                child: _DashboardItem(
                  label: t.statistics_yearly_avg_mood,
                  value: avgMood > 0 ? avgMood.toStringAsFixed(1) : '-',
                  icon: Icons.mood,
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
                child: _DashboardItem(
                  label: t.statistics_yearly_best_month,
                  value: bestMonth.isNotEmpty ? bestMonth : '-',
                  icon: Icons.trending_up,
                  color: colorScheme.tertiary,
                ),
              ),
              Container(
                width: 1,
                height: 60,
                color: colorScheme.outlineVariant,
              ),
              Expanded(
                child: _DashboardItem(
                  label: t.statistics_yearly_worst_month,
                  value: worstMonth.isNotEmpty ? worstMonth : '-',
                  icon: Icons.trending_down,
                  color: colorScheme.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DashboardItem extends StatelessWidget {
  final String label;
  final String value;
  final String? unit;
  final IconData icon;
  final Color color;

  const _DashboardItem({
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
