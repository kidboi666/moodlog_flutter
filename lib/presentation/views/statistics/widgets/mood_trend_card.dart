import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moodlog/core/extensions/enum.dart';
import 'package:moodlog/presentation/views/statistics/widgets/base_card.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/common.dart';
import '../../../../core/constants/enum.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../view_models/statistics/statistics_viewmodel.dart';

class MoodTrendCard extends StatelessWidget {
  const MoodTrendCard({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<StatisticsViewModel>(context);
    final sortedMoodTrendData = viewModel.moodTrendData.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    if (sortedMoodTrendData.isEmpty) {
      return BaseCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.statistics_mood_trend_title,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: Spacing.lg),
            Text(AppLocalizations.of(context)!.statistics_mood_trend_empty),
          ],
        ),
      );
    }

    // Determine min/max Y values for the chart
    final double minY =
        MoodType.values
            .map((e) => e.score)
            .reduce((a, b) => a < b ? a : b)
            .toDouble() -
        0.5;
    final double maxY =
        MoodType.values
            .map((e) => e.score)
            .reduce((a, b) => a > b ? a : b)
            .toDouble() +
        0.5;

    final List<FlSpot> spots = sortedMoodTrendData.asMap().entries.map((entry) {
      final index = entry.key.toDouble();
      final value = entry.value.value;
      return FlSpot(index, value);
    }).toList();

    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.statistics_mood_trend_title,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: Spacing.lg),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() < sortedMoodTrendData.length) {
                          final date = sortedMoodTrendData[value.toInt()].key;
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              DateFormat('MM/dd').format(date),
                              style: TextStyle(fontSize: 10),
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        // Map score back to mood text for Y-axis labels
                        String text = '';
                        if (value == MoodType.verySad.score.toDouble()) {
                          text = MoodType.verySad.getDisplayName(context);
                        }
                        if (value == MoodType.sad.score.toDouble()) {
                          text = MoodType.sad.getDisplayName(context);
                        }
                        if (value == MoodType.neutral.score.toDouble()) {
                          text = MoodType.neutral.getDisplayName(context);
                        }
                        if (value == MoodType.happy.score.toDouble()) {
                          text = MoodType.happy.getDisplayName(context);
                        }
                        if (value == MoodType.veryHappy.score.toDouble()) {
                          text = MoodType.veryHappy.getDisplayName(context);
                        }
                        return Text(text, style: TextStyle(fontSize: 10));
                      },
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: const Color(0xff37434d), width: 1),
                ),
                minX: 0,
                maxX: (sortedMoodTrendData.length - 1).toDouble(),
                minY: minY,
                maxY: maxY,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ],
                    ),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.3),
                          Theme.of(
                            context,
                          ).colorScheme.secondary.withValues(alpha: 0.3),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
