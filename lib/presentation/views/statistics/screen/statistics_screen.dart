import 'package:fl_chart/fl_chart.dart'; // Import fl_chart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/view_models/statistics/statistics_viewmodel.dart';
import 'package:table_calendar/table_calendar.dart';

class StatisticsScreen extends StatelessWidget {
  final StatisticsViewModel viewModel;

  const StatisticsScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.tab_statistics)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: ListenableBuilder(
            listenable: viewModel,
            builder: (context, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildOverallStatsCard(context, viewModel),
                  SizedBox(height: 20),
                  _buildMoodCalendarCard(context, viewModel),
                  SizedBox(height: 20),
                  _buildMoodDistributionCard(context, viewModel), // Pie Chart
                  SizedBox(height: 20),
                  _buildMoodTrendCard(context, viewModel), // Line Chart
                  SizedBox(height: 20),
                  _buildRecentActivityCard(context, viewModel),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildOverallStatsCard(
    BuildContext context,
    StatisticsViewModel viewModel,
  ) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '전체 통계',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  context,
                  '총 기록',
                  viewModel.totalJournals.toString(),
                  Icons.edit_note,
                ),
                _buildStatItem(
                  context,
                  '연속 기록',
                  '${viewModel.currentStreak}일',
                  Icons.local_fire_department,
                ),
                _buildStatItem(
                  context,
                  '최대 연속 기록',
                  '${viewModel.maxStreak}일',
                  Icons.emoji_events,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
        SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _buildMoodCalendarCard(
    BuildContext context,
    StatisticsViewModel viewModel,
  ) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '감정 달력',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: DateTime.now(),
              calendarFormat: CalendarFormat.month,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  final mood = viewModel
                      .moodCalendar[DateTime(day.year, day.month, day.day)];
                  return GestureDetector(
                    onTap: () {
                      // 탭 이벤트 처리: 선택된 날짜에 대한 추가 동작 (예: 해당 날짜의 일기 목록 보기)
                      debugPrint('Selected day: $day');
                    },
                    child: Container(
                      margin: const EdgeInsets.all(6.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: mood != null
                            ? _getMoodColor(mood)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: mood != null
                          ? Text(
                              mood.emoji, // Use emoji here
                              style: TextStyle(
                                fontSize: 18,
                              ), // Adjust font size for emoji
                            )
                          : Text(
                              '${day.day}',
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.color,
                              ),
                            ),
                    ),
                  );
                },
              ),
              onDaySelected: (selectedDay, focusedDay) {
                // 선택된 날짜 처리 로직 (예: ViewModel에 선택된 날짜 전달)
                debugPrint('Selected day: $selectedDay');
              },
            ),
          ],
        ),
      ),
    );
  }

  Color _getMoodColor(MoodType mood) {
    switch (mood) {
      case MoodType.veryHappy:
        return Colors.green.shade700;
      case MoodType.happy:
        return Colors.lightGreen.shade500;
      case MoodType.neutral:
        return Colors.orange.shade400;
      case MoodType.sad:
        return Colors.red.shade500;
      case MoodType.verySad:
        return Colors.deepPurple.shade700;
    }
  }

  String _getMoodText(MoodType mood) {
    switch (mood) {
      case MoodType.veryHappy:
        return '매우 행복';
      case MoodType.happy:
        return '행복';
      case MoodType.neutral:
        return '보통';
      case MoodType.sad:
        return '슬픔';
      case MoodType.verySad:
        return '매우 슬픔';
    }
  }

  IconData _getMoodIcon(MoodType mood) {
    switch (mood) {
      case MoodType.veryHappy:
        return Icons.sentiment_very_satisfied;
      case MoodType.happy:
        return Icons.sentiment_satisfied;
      case MoodType.neutral:
        return Icons.sentiment_neutral;
      case MoodType.sad:
        return Icons.sentiment_dissatisfied;
      case MoodType.verySad:
        return Icons.sentiment_very_dissatisfied;
    }
  }

  Widget _buildMoodDistributionCard(
    BuildContext context,
    StatisticsViewModel viewModel,
  ) {
    final totalCount = viewModel.moodCounts.values.fold(
      0,
      (sum, count) => sum + count,
    );
    final List<PieChartSectionData> sections = MoodType.values.map((moodType) {
      final count = viewModel.moodCounts[moodType] ?? 0;
      final isTouched = false; // For interactivity, can be managed by state
      final double fontSize = isTouched ? 20 : 16;
      final double radius = isTouched ? 60 : 50;
      final double percentage = totalCount > 0 ? (count / totalCount) * 100 : 0;

      return PieChartSectionData(
        color: _getMoodColor(moodType),
        value: count.toDouble(),
        title: '${percentage.toStringAsFixed(1)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
          shadows: [Shadow(color: Colors.black, blurRadius: 2)],
        ),
        badgeWidget: Text(moodType.emoji, style: TextStyle(fontSize: 24)),
        // Emoji as badge
        badgePositionPercentageOffset: .98,
      );
    }).toList();

    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '기분 분포',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
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
            SizedBox(height: 16),
            Column(
              children: MoodType.values.map((moodType) {
                final count = viewModel.moodCounts[moodType] ?? 0;
                return _buildMoodDistributionItem(
                  context,
                  _getMoodText(moodType),
                  count,
                  _getMoodColor(moodType),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodDistributionItem(
    BuildContext context,
    String mood,
    int count,
    Color color,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(width: 12),
          Expanded(child: Text(mood)),
          Text(
            '$count회',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodTrendCard(
    BuildContext context,
    StatisticsViewModel viewModel,
  ) {
    // Filter out dates with no data or only one data point for a meaningful line chart
    final sortedMoodTrendData = viewModel.moodTrendData.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    if (sortedMoodTrendData.isEmpty) {
      return Card(
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '기분 추이',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text('기분 추이 데이터가 없습니다.'),
            ],
          ),
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

    // Create FlSpot for each data point
    final List<FlSpot> spots = sortedMoodTrendData.asMap().entries.map((entry) {
      final index = entry.key.toDouble();
      final value = entry.value.value;
      return FlSpot(index, value);
    }).toList();

    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '기분 추이',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
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
                            text = MoodType.verySad.displayName;
                          }
                          if (value == MoodType.sad.score.toDouble()) {
                            text = MoodType.sad.displayName;
                          }
                          if (value == MoodType.neutral.score.toDouble()) {
                            text = MoodType.neutral.displayName;
                          }
                          if (value == MoodType.happy.score.toDouble()) {
                            text = MoodType.happy.displayName;
                          }
                          if (value == MoodType.veryHappy.score.toDouble()) {
                            text = MoodType.veryHappy.displayName;
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
                      color: const Color(0xff37434d),
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
                            ).colorScheme.primary.withOpacity(0.3),
                            Theme.of(
                              context,
                            ).colorScheme.secondary.withOpacity(0.3),
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
      ),
    );
  }

  Widget _buildRecentActivityCard(
    BuildContext context,
    StatisticsViewModel viewModel,
  ) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '최근 일기',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            if (viewModel.recentJournals.isEmpty)
              Text('최근 일기가 없습니다.')
            else
              ...viewModel.recentJournals.map((journal) {
                return _buildActivityItem(
                  context,
                  DateFormat('yyyy.MM.dd').format(journal.createdAt),
                  journal.content ?? '',
                  _getMoodIcon(journal.moodType),
                  journal.moodType.emoji, // Pass emoji
                );
              }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(
    BuildContext context,
    String date,
    String note,
    IconData icon,
    String emoji, // New parameter for emoji
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Display emoji instead of icon
          Text(emoji, style: TextStyle(fontSize: 24)),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(note, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
