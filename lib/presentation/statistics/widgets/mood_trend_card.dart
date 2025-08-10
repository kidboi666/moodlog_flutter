import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/constants/enum.dart';
import '../../../core/extensions/enum.dart';
import '../../../core/l10n/app_localizations.dart';
import '../viewmodel/statistics_viewmodel.dart';
import 'base_card.dart';

class MoodTrendCard extends StatelessWidget {
  const MoodTrendCard({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<StatisticsViewModel>(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;

    final sortedMoodTrendData = viewModel.moodTrendData.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    if (sortedMoodTrendData.isEmpty) {
      return BaseCard(
        title: t.statistics_mood_trend_description,
        icon: Icons.trending_up,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.trending_up,
                    size: 64,
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: Spacing.md),
                  Text(
                    t.statistics_mood_trend_empty,
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

    // 평균 점수 계산
    final averageScore = sortedMoodTrendData.isNotEmpty
        ? sortedMoodTrendData.map((e) => e.value).reduce((a, b) => a + b) /
              sortedMoodTrendData.length
        : 0.0;

    // 최근 7일 데이터 분석
    final recent7Days = sortedMoodTrendData.length > 7
        ? sortedMoodTrendData.sublist(sortedMoodTrendData.length - 7)
        : sortedMoodTrendData;

    final recent7DaysAvg = recent7Days.isNotEmpty
        ? recent7Days.map((e) => e.value).reduce((a, b) => a + b) /
              recent7Days.length
        : 0.0;

    return BaseCard(
      title: t.statistics_mood_trend_description,
      icon: Icons.trending_up,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  '${sortedMoodTrendData.length}',
                  style: textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
                Text(
                  t.statistics_mood_trend_daily_records,
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
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
                          return Text(
                            DateFormat('MM/dd').format(date),
                            style: TextStyle(fontSize: 10),
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
                  border: Border.all(
                    color: colorScheme.outline.withValues(alpha: 0.5),
                    width: 1,
                  ),
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
                      colors: [colorScheme.primary, colorScheme.secondary],
                    ),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          colorScheme.primary.withValues(alpha: 0.3),
                          colorScheme.secondary.withValues(alpha: 0.3),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: Spacing.lg),
          Container(
            padding: const EdgeInsets.all(Spacing.lg),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(Roundness.cardInner),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      t.statistics_mood_trend_overall_average,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      averageScore.toStringAsFixed(1),
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                if (recent7Days.isNotEmpty) ...[
                  const SizedBox(height: Spacing.sm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        t.statistics_mood_trend_recent_7days_average,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        recent7DaysAvg.toStringAsFixed(1),
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: recent7DaysAvg > averageScore
                              ? colorScheme.primary
                              : recent7DaysAvg < averageScore
                              ? colorScheme.error
                              : null,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
