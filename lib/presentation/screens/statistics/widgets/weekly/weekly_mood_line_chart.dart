import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/domain/entities/journal/check_in.dart';
import 'package:moodlog/presentation/screens/statistics/statistics_view_model.dart';
import 'package:moodlog/presentation/widgets/base_card.dart';
import 'package:provider/provider.dart';

class WeeklyMoodLineChart extends StatelessWidget {
  const WeeklyMoodLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final checkIns = context.select<StatisticsViewModel, List<CheckIn>>(
      (vm) => vm.weeklyCheckInsList,
    );

    final dailyMoods = _calculateDailyAverageMoods(checkIns);

    return BaseCard(
      title: t.statistics_weekly_mood_trend,
      icon: Icons.show_chart,
      child: checkIns.isEmpty
          ? _buildEmptyState(context)
          : _MoodLineChart(dailyMoods: dailyMoods),
    );
  }

  Map<DateTime, double> _calculateDailyAverageMoods(List<CheckIn> checkIns) {
    final Map<DateTime, List<int>> dailyScores = {};

    for (var checkIn in checkIns) {
      final date = DateTime(
        checkIn.createdAt.year,
        checkIn.createdAt.month,
        checkIn.createdAt.day,
      );
      dailyScores.putIfAbsent(date, () => []).add(checkIn.moodType.score);
    }

    final Map<DateTime, double> dailyAverages = {};
    dailyScores.forEach((date, scores) {
      dailyAverages[date] = scores.reduce((a, b) => a + b) / scores.length;
    });

    return dailyAverages;
  }

  Widget _buildEmptyState(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.xl),
        child: Text(
          t.statistics_mood_trend_empty,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _MoodLineChart extends StatelessWidget {
  final Map<DateTime, double> dailyMoods;

  const _MoodLineChart({required this.dailyMoods});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 6));
    final startDate = DateTime(sevenDaysAgo.year, sevenDaysAgo.month, sevenDaysAgo.day);

    final dataPoints = List.generate(7, (index) {
      final date = startDate.add(Duration(days: index));
      final normalizedDate = DateTime(date.year, date.month, date.day);
      return dailyMoods[normalizedDate];
    });

    return Column(
      children: [
        SizedBox(
          height: 150,
          child: CustomPaint(
            painter: _LineChartPainter(dataPoints: dataPoints),
            child: Container(),
          ),
        ),
        CommonSizedBox.heightMd,
        _buildLegend(context, startDate),
      ],
    );
  }

  Widget _buildLegend(BuildContext context, DateTime startDate) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        final date = startDate.add(Duration(days: index));
        final dayLabel = _getDayLabel(t, date.weekday);

        return Text(
          dayLabel,
          style: textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        );
      }),
    );
  }

  String _getDayLabel(AppLocalizations t, int weekday) {
    switch (weekday) {
      case 1:
        return t.calendar_weekday_mon;
      case 2:
        return t.calendar_weekday_tue;
      case 3:
        return t.calendar_weekday_wed;
      case 4:
        return t.calendar_weekday_thu;
      case 5:
        return t.calendar_weekday_fri;
      case 6:
        return t.calendar_weekday_sat;
      case 7:
        return t.calendar_weekday_sun;
      default:
        return '';
    }
  }
}

class _LineChartPainter extends CustomPainter {
  final List<double?> dataPoints;

  _LineChartPainter({required this.dataPoints});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final gridPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.2)
      ..strokeWidth = 1.0;

    final availablePoints = dataPoints.where((p) => p != null).toList();
    if (availablePoints.isEmpty) return;

    final maxY = 5.0;
    final minY = 1.0;
    final rangeY = maxY - minY;

    final stepX = size.width / (dataPoints.length - 1);

    for (int i = 0; i <= 4; i++) {
      final y = size.height * (1 - i / 4);
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }

    final path = Path();
    bool pathStarted = false;

    for (int i = 0; i < dataPoints.length; i++) {
      final value = dataPoints[i];
      if (value == null) continue;

      final x = i * stepX;
      final y = size.height * (1 - (value - minY) / rangeY);

      if (!pathStarted) {
        path.moveTo(x, y);
        pathStarted = true;
      } else {
        path.lineTo(x, y);
      }

      final emoji = _getMoodEmoji(value);
      final textPainter = TextPainter(
        text: TextSpan(
          text: emoji,
          style: const TextStyle(fontSize: 16),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, y - textPainter.height / 2),
      );
    }

    canvas.drawPath(path, paint);
  }

  String _getMoodEmoji(double score) {
    if (score >= 4.5) return MoodType.veryHappy.emoji;
    if (score >= 3.5) return MoodType.happy.emoji;
    if (score >= 2.5) return MoodType.neutral.emoji;
    if (score >= 1.5) return MoodType.sad.emoji;
    return MoodType.verySad.emoji;
  }

  @override
  bool shouldRepaint(_LineChartPainter oldDelegate) {
    return oldDelegate.dataPoints != dataPoints;
  }
}
