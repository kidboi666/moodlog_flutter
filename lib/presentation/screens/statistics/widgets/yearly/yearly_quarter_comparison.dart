import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/statistics/statistics_view_model.dart';
import 'package:moodlog/presentation/widgets/base_card.dart';
import 'package:provider/provider.dart';

class YearlyQuarterComparison extends StatelessWidget {
  const YearlyQuarterComparison({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final quarterAverages = context.select<StatisticsViewModel, Map<int, double>>(
      (vm) => vm.yearlyQuarterAverages,
    );

    final hasData = quarterAverages.values.any((avg) => avg > 0);
    final maxAverage = hasData
        ? quarterAverages.values.where((v) => v > 0).reduce((a, b) => a > b ? a : b)
        : 5.0;

    return BaseCard(
      title: t.statistics_yearly_quarter_comparison,
      icon: Icons.bar_chart,
      child: !hasData
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
                    children: List.generate(4, (index) {
                      final quarter = index + 1;
                      final average = quarterAverages[quarter] ?? 0.0;
                      return _QuarterBar(
                        quarter: quarter,
                        average: average,
                        maxAverage: maxAverage,
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

  Widget _buildLegend(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final quarterLabels = [
      t.statistics_yearly_q1,
      t.statistics_yearly_q2,
      t.statistics_yearly_q3,
      t.statistics_yearly_q4,
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: quarterLabels.map((label) {
        return Text(
          label,
          style: textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        );
      }).toList(),
    );
  }
}

class _QuarterBar extends StatelessWidget {
  final int quarter;
  final double average;
  final double maxAverage;

  const _QuarterBar({
    required this.quarter,
    required this.average,
    required this.maxAverage,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final heightRatio = maxAverage > 0 ? (average / maxAverage).clamp(0.0, 1.0) : 0.0;
    final barHeight = average > 0 ? (140 * heightRatio).clamp(20.0, 140.0) : 8.0;

    final quarterColors = [
      colorScheme.primary,
      colorScheme.secondary,
      colorScheme.tertiary,
      colorScheme.primaryContainer,
    ];

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (average > 0) ...[
            Text(
              average.toStringAsFixed(1),
              style: textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: quarterColors[quarter - 1],
              ),
            ),
            CommonSizedBox.heightXs,
          ],
          Container(
            height: barHeight,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  quarterColors[quarter - 1],
                  quarterColors[quarter - 1].withValues(alpha: 0.6),
                ],
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
