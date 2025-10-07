import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/constants/enum.dart';
import '../../../core/extensions/localization.dart';
import '../../../core/l10n/app_localizations.dart';
import '../statistics_view_model.dart';
import 'base_card.dart';
import 'mood_distribution_item.dart';

class MoodDistributionCard extends StatelessWidget {
  const MoodDistributionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<StatisticsViewModel>(context);
    final t = AppLocalizations.of(context)!;
    final totalCount = viewModel.moodCounts.values.fold(
      0,
      (sum, count) => sum + count,
    );

    if (totalCount == 0) {
      return _buildFallback(context);
    }

    final List<PieChartSectionData> sections = MoodType.values.map((moodType) {
      final count = viewModel.moodCounts[moodType] ?? 0;
      final double percentage = totalCount > 0 ? (count / totalCount) * 100 : 0;
      return _buildPieChartSection(context, moodType, count, percentage);
    }).toList();

    return BaseCard(
      title: t.statistics_mood_distribution_title,
      icon: Icons.pie_chart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTotalResult(context, viewModel),
          const SizedBox(height: Spacing.lg),
          _buildChart(context, sections),
          const SizedBox(height: Spacing.lg),
          _buildDistribution(context, viewModel),
        ],
      ),
    );
  }

  PieChartSectionData _buildPieChartSection(
    BuildContext context,
    MoodType moodType,
    int count,
    double percentage,
  ) {
    final textTheme = Theme.of(context).textTheme;
    return PieChartSectionData(
      color: Color(moodType.colorValue),
      value: count.toDouble(),
      title: '${percentage.toStringAsFixed(1)}%',
      radius: 50,
      titleStyle: textTheme.bodyMedium?.copyWith(color: Colors.black87),
      badgeWidget: Text(moodType.emoji, style: const TextStyle(fontSize: 20)),
      badgePositionPercentageOffset: .98,
    );
  }

  Widget _buildDistribution(
    BuildContext context,
    StatisticsViewModel viewModel,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(Spacing.lg),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(Roundness.cardInner),
      ),
      child: Column(
        children: MoodType.values.map((moodType) {
          final count = viewModel.moodCounts[moodType] ?? 0;
          return MoodDistributionItem(
            mood: moodType.getDisplayName(context),
            count: count,
            color: Color(moodType.colorValue),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildChart(BuildContext context, List<PieChartSectionData> sections) {
    return SizedBox(
      height: 200,
      child: PieChart(
        PieChartData(
          sections: sections,
          borderData: FlBorderData(show: false),
          sectionsSpace: 0,
          centerSpaceRadius: 40,
          pieTouchData: PieTouchData(enabled: false),
        ),
      ),
    );
  }

  Widget _buildTotalResult(
    BuildContext context,
    StatisticsViewModel viewModel,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final t = AppLocalizations.of(context)!;
    final totalCount = viewModel.moodCounts.values.fold(
      0,
      (sum, count) => sum + count,
    );

    return Center(
      child: Column(
        children: [
          Text(
            totalCount.toString(),
            style: textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
          Text(
            t.statistics_total_records_count_unit,
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFallback(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final t = AppLocalizations.of(context)!;

    return BaseCard(
      title: t.statistics_mood_distribution_description,
      icon: Icons.pie_chart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.pie_chart_outline,
                  size: 64,
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                ),
                const SizedBox(height: Spacing.md),
                Text(
                  t.statistics_mood_distribution_empty,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
