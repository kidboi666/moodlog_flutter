import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/statistics/statistics_view_model.dart';
import 'package:moodlog/presentation/widgets/base_card.dart';
import 'package:provider/provider.dart';

class YearlyMonthlyTrendChart extends StatelessWidget {
  const YearlyMonthlyTrendChart({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final monthlyAverages = context.select<StatisticsViewModel, Map<int, double>>(
      (vm) => vm.yearlyMonthlyAverages,
    );

    final hasData = monthlyAverages.values.any((avg) => avg > 0);

    return BaseCard(
      title: t.statistics_yearly_trend,
      icon: Icons.trending_up,
      child: !hasData
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.xl),
                child: Text(
                  t.statistics_mood_trend_empty,
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
                  child: CustomPaint(
                    painter: _MonthlyTrendPainter(
                      monthlyAverages: monthlyAverages,
                      colorScheme: colorScheme,
                    ),
                    child: Container(),
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

    final monthLabels = [
      t.calendar_month_jan,
      t.calendar_month_feb,
      t.calendar_month_mar,
      t.calendar_month_apr,
      t.calendar_month_may,
      t.calendar_month_jun,
      t.calendar_month_jul,
      t.calendar_month_aug,
      t.calendar_month_sep,
      t.calendar_month_oct,
      t.calendar_month_nov,
      t.calendar_month_dec,
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 4,
      alignment: WrapAlignment.center,
      children: List.generate(12, (index) {
        return Text(
          monthLabels[index],
          style: textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        );
      }),
    );
  }
}

class _MonthlyTrendPainter extends CustomPainter {
  final Map<int, double> monthlyAverages;
  final ColorScheme colorScheme;

  _MonthlyTrendPainter({
    required this.monthlyAverages,
    required this.colorScheme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = colorScheme.primary
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    final gridPaint = Paint()
      ..color = colorScheme.outlineVariant.withValues(alpha: 0.3)
      ..strokeWidth = 1.0;

    final dotPaint = Paint()
      ..color = colorScheme.primary
      ..style = PaintingStyle.fill;

    const maxY = 5.0;
    const minY = 1.0;
    const rangeY = maxY - minY;

    final stepX = size.width / 11;

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
    final List<Offset> points = [];

    for (int month = 1; month <= 12; month++) {
      final value = monthlyAverages[month] ?? 0.0;
      if (value == 0) continue;

      final x = (month - 1) * stepX;
      final y = size.height * (1 - (value - minY) / rangeY);

      points.add(Offset(x, y));

      if (!pathStarted) {
        path.moveTo(x, y);
        pathStarted = true;
      } else {
        path.lineTo(x, y);
      }
    }

    if (pathStarted) {
      canvas.drawPath(path, paint);

      for (var point in points) {
        canvas.drawCircle(point, 4, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(_MonthlyTrendPainter oldDelegate) {
    return oldDelegate.monthlyAverages != monthlyAverages;
  }
}
