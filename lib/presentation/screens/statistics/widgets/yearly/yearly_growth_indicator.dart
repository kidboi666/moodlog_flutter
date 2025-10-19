import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/statistics/statistics_view_model.dart';
import 'package:moodlog/presentation/widgets/base_card.dart';
import 'package:provider/provider.dart';

class YearlyGrowthIndicator extends StatelessWidget {
  const YearlyGrowthIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final monthlyAverages = context
        .select<StatisticsViewModel, Map<int, double>>(
          (vm) => vm.yearlyMonthlyAverages,
        );

    final firstHalfMonths = [1, 2, 3, 4, 5, 6];
    final secondHalfMonths = [7, 8, 9, 10, 11, 12];

    final firstHalfValues = firstHalfMonths
        .map((m) => monthlyAverages[m] ?? 0.0)
        .where((v) => v > 0)
        .toList();
    final secondHalfValues = secondHalfMonths
        .map((m) => monthlyAverages[m] ?? 0.0)
        .where((v) => v > 0)
        .toList();

    final firstHalfAvg = firstHalfValues.isNotEmpty
        ? firstHalfValues.reduce((a, b) => a + b) / firstHalfValues.length
        : 0.0;
    final secondHalfAvg = secondHalfValues.isNotEmpty
        ? secondHalfValues.reduce((a, b) => a + b) / secondHalfValues.length
        : 0.0;

    final hasData = firstHalfAvg > 0 || secondHalfAvg > 0;
    final growth = hasData && firstHalfAvg > 0
        ? ((secondHalfAvg - firstHalfAvg) / firstHalfAvg * 100)
        : 0.0;

    return BaseCard(
      title: t.statistics_yearly_growth,
      icon: Icons.show_chart,
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
                Row(
                  children: [
                    Expanded(
                      child: _HalfYearCard(
                        label: t.statistics_yearly_first_half,
                        average: firstHalfAvg,
                        color: colorScheme.primary,
                      ),
                    ),
                    CommonSizedBox.widthMd,
                    Expanded(
                      child: _HalfYearCard(
                        label: t.statistics_yearly_second_half,
                        average: secondHalfAvg,
                        color: colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
                CommonSizedBox.heightMd,
                Container(
                  padding: const EdgeInsets.all(Spacing.md),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        growth > 0 ? Icons.trending_up : Icons.trending_down,
                        color: growth > 0
                            ? colorScheme.tertiary
                            : colorScheme.secondary,
                        size: 20,
                      ),
                      CommonSizedBox.widthSm,
                      Text(
                        growth > 0
                            ? '+${growth.toStringAsFixed(1)}%'
                            : '${growth.toStringAsFixed(1)}%',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: growth > 0
                              ? colorScheme.tertiary
                              : colorScheme.secondary,
                        ),
                      ),
                      CommonSizedBox.widthSm,
                      Text(
                        growth > 0
                            ? t.statistics_yearly_growth_label
                            : t.statistics_yearly_change_label,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class _HalfYearCard extends StatelessWidget {
  final String label;
  final double average;
  final Color color;

  const _HalfYearCard({
    required this.label,
    required this.average,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(Spacing.md),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          CommonSizedBox.heightSm,
          Text(
            average > 0 ? average.toStringAsFixed(1) : '-',
            style: textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            t.statistics_yearly_avg_mood,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
