import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/domain/entities/journal/check_in.dart';
import 'package:moodlog/presentation/screens/statistics/statistics_view_model.dart';
import 'package:moodlog/presentation/widgets/base_card.dart';
import 'package:provider/provider.dart';

class MonthlyCalendarHeatmap extends StatelessWidget {
  const MonthlyCalendarHeatmap({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final checkIns = context.select<StatisticsViewModel, List<CheckIn>>(
      (vm) => vm.monthlyCheckInsList,
    );

    final dailyData = _calculateDailyData(checkIns);
    final maxCount = dailyData.values.isEmpty
        ? 0
        : dailyData.values.map((e) => e.count).reduce((a, b) => a > b ? a : b);

    return BaseCard(
      title: t.statistics_monthly_calendar,
      icon: Icons.calendar_month,
      child: Column(
        children: [
          _buildWeekdayHeader(context),
          CommonSizedBox.heightSm,
          _buildCalendarGrid(context, dailyData, maxCount),
          CommonSizedBox.heightMd,
          _buildLegend(context),
        ],
      ),
    );
  }

  Map<int, ({int count, double avgMood})> _calculateDailyData(List<CheckIn> checkIns) {
    final Map<int, List<CheckIn>> dailyCheckIns = {};

    for (var checkIn in checkIns) {
      final day = checkIn.createdAt.day;
      dailyCheckIns.putIfAbsent(day, () => []).add(checkIn);
    }

    final Map<int, ({int count, double avgMood})> dailyData = {};
    dailyCheckIns.forEach((day, checkInsForDay) {
      final count = checkInsForDay.length;
      final avgMood = checkInsForDay
              .map((c) => c.moodType.score)
              .reduce((a, b) => a + b) /
          checkInsForDay.length;
      dailyData[day] = (count: count, avgMood: avgMood);
    });

    return dailyData;
  }

  Widget _buildWeekdayHeader(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final weekdays = [
      t.calendar_weekday_mon,
      t.calendar_weekday_tue,
      t.calendar_weekday_wed,
      t.calendar_weekday_thu,
      t.calendar_weekday_fri,
      t.calendar_weekday_sat,
      t.calendar_weekday_sun,
    ];

    return Row(
      children: weekdays.map((weekday) {
        return Expanded(
          child: Center(
            child: Text(
              weekday,
              style: textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCalendarGrid(
    BuildContext context,
    Map<int, ({int count, double avgMood})> dailyData,
    int maxCount,
  ) {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    final daysInMonth = lastDayOfMonth.day;
    final firstWeekday = firstDayOfMonth.weekday;

    final List<Widget> dayWidgets = [];

    for (int i = 1; i < firstWeekday; i++) {
      dayWidgets.add(const SizedBox());
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final data = dailyData[day];
      dayWidgets.add(
        _CalendarDay(
          day: day,
          count: data?.count ?? 0,
          avgMood: data?.avgMood ?? 0,
          maxCount: maxCount,
        ),
      );
    }

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 7,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: dayWidgets,
    );
  }

  Widget _buildLegend(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          t.common_less,
          style: textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        CommonSizedBox.widthSm,
        ...List.generate(5, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.2 + (index * 0.2)),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
        CommonSizedBox.widthSm,
        Text(
          t.common_more,
          style: textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _CalendarDay extends StatelessWidget {
  final int day;
  final int count;
  final double avgMood;
  final int maxCount;

  const _CalendarDay({
    required this.day,
    required this.count,
    required this.avgMood,
    required this.maxCount,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final intensity = maxCount > 0 ? (count / maxCount).clamp(0.0, 1.0) : 0.0;
    final alpha = count == 0 ? 0.1 : 0.2 + (intensity * 0.8);

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: alpha),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          day.toString(),
          style: textTheme.bodySmall?.copyWith(
            fontWeight: count > 0 ? FontWeight.w600 : FontWeight.normal,
            color: count > 0
                ? colorScheme.onPrimary
                : colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
