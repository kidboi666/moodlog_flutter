import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:moodlog/core/extensions/enum.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/constants/enum.dart';
import '../../../core/l10n/app_localizations.dart';
import '../viewmodel/statistics_viewmodel.dart';
import 'base_card.dart';
import 'mood_distribution_item.dart';

class MoodDistributionCard extends StatelessWidget {
  const MoodDistributionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<StatisticsViewModel>(context);
    final totalCount = viewModel.moodCounts.values.fold(
      0,
      (sum, count) => sum + count,
    );
    final List<PieChartSectionData> sections = MoodType.values.map((moodType) {
      final count = viewModel.moodCounts[moodType] ?? 0;
      final double percentage = totalCount > 0 ? (count / totalCount) * 100 : 0;

      return PieChartSectionData(
        color: Color(moodType.colorValue),
        value: count.toDouble(),
        title: '${percentage.toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: Colors.black87),
        badgeWidget: Text(moodType.emoji, style: const TextStyle(fontSize: 24)),
        // Emoji as badge
        badgePositionPercentageOffset: .98,
      );
    }).toList();

    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.statistics_mood_distribution_title,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: Spacing.lg),
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                sections: sections,
                borderData: FlBorderData(show: false),
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                pieTouchData: PieTouchData(
                  enabled: false,
                ), // Disable touch for simplicity
              ),
            ),
          ),
          const SizedBox(height: Spacing.lg),
          Column(
            children: MoodType.values.map((moodType) {
              final count = viewModel.moodCounts[moodType] ?? 0;
              return MoodDistributionItem(
                mood: moodType.getDisplayName(context),
                count: count,
                color: Color(moodType.colorValue),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
