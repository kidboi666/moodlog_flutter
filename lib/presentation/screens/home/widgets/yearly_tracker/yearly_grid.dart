import 'dart:math';

import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';
import 'package:moodlog/presentation/screens/home/widgets/yearly_tracker/week_column.dart';
import 'package:moodlog/presentation/screens/home/widgets/yearly_tracker/weekday_labels.dart';

class MonthPosition {
  final String monthName;
  final double left;
  final double top;
  final int weekday;

  MonthPosition({
    required this.monthName,
    required this.left,
    required this.top,
    required this.weekday,
  });
}

class YearlyGrid extends StatelessWidget {
  final DateTime now;
  final Map<DateTime, List<Journal>> yearlyJournals;

  const YearlyGrid({
    super.key,
    required this.now,
    required this.yearlyJournals,
  });

  @override
  Widget build(BuildContext context) {
    final (weeks, monthPositions) = _generateGithubStyleGrid(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const SizedBox(height: 24),
            const SizedBox(height: Spacing.xs),
            const WeekdayLabels(),
          ],
        ),
        const SizedBox(width: Spacing.xs),

        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 24),
                    const SizedBox(height: Spacing.xs),
                    SizedBox(
                      height: 144,
                      child: Row(
                        children: weeks
                            .map(
                              (week) => WeekColumn(
                                week: week,
                                yearlyJournals: yearlyJournals,
                                now: now,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),

                ...monthPositions.map(
                  (position) => _buildMonthLabel(context, position),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  (List<List<DateTime?>>, List<MonthPosition>) _generateGithubStyleGrid(
    BuildContext context,
  ) {
    final firstDayOfYear = DateTime(now.year, 1, 1);
    final lastDayOfYear = DateTime(now.year, 12, 31);

    final firstWeekday = firstDayOfYear.weekday == 7
        ? 0
        : firstDayOfYear.weekday;
    final startDate = firstDayOfYear.subtract(Duration(days: firstWeekday));

    final lastWeekday = lastDayOfYear.weekday == 7 ? 0 : lastDayOfYear.weekday;
    final endDate = lastDayOfYear.add(Duration(days: 6 - lastWeekday));

    final allDates = <DateTime>[];
    DateTime current = startDate;
    while (!current.isAfter(endDate)) {
      allDates.add(current);
      current = current.add(const Duration(days: 1));
    }

    final weeks = <List<DateTime?>>[];
    final monthPositions = <MonthPosition>[];

    for (int i = 0; i < allDates.length; i += 7) {
      final weekDates = allDates.skip(i).take(7).toList();
      if (weekDates.length == 7) {
        final processedWeek = weekDates.map((date) {
          return date.year == now.year ? date : null;
        }).toList();
        weeks.add(processedWeek);

        for (int dayIndex = 0; dayIndex < weekDates.length; dayIndex++) {
          final date = weekDates[dayIndex];
          if (date.year == now.year && date.day == 1) {
            final weekIndex = weeks.length - 1;
            final left = weekIndex * 18.8;

            final top = 4.0;

            monthPositions.add(
              MonthPosition(
                monthName: _getMonthName(date.month, context),
                left: left,
                top: top,
                weekday: dayIndex,
              ),
            );
            break;
          }
        }
      }
    }

    return (weeks, monthPositions);
  }

  Widget _buildMonthLabel(BuildContext context, MonthPosition position) {
    return Positioned(
      left: position.left,
      top: position.top,
      child: Text(
        position.monthName,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          fontSize: 10,
        ),
      ),
    );
  }

  String _getMonthName(int month, BuildContext context) {
    final t = AppLocalizations.of(context)!;
    switch (month) {
      case 1:
        return t.calendar_month_jan.substring(
          0,
          min(t.calendar_month_jan.length, 3),
        );
      case 2:
        return t.calendar_month_feb.substring(
          0,
          min(t.calendar_month_feb.length, 3),
        );
      case 3:
        return t.calendar_month_mar.substring(
          0,
          min(t.calendar_month_mar.length, 3),
        );
      case 4:
        return t.calendar_month_apr.substring(
          0,
          min(t.calendar_month_apr.length, 3),
        );
      case 5:
        return t.calendar_month_may.substring(
          0,
          min(t.calendar_month_may.length, 3),
        );
      case 6:
        return t.calendar_month_jun.substring(
          0,
          min(t.calendar_month_jun.length, 3),
        );
      case 7:
        return t.calendar_month_jul.substring(
          0,
          min(t.calendar_month_jul.length, 3),
        );
      case 8:
        return t.calendar_month_aug.substring(
          0,
          min(t.calendar_month_aug.length, 3),
        );
      case 9:
        return t.calendar_month_sep.substring(
          0,
          min(t.calendar_month_sep.length, 3),
        );
      case 10:
        return t.calendar_month_oct.substring(
          0,
          min(t.calendar_month_oct.length, 3),
        );
      case 11:
        return t.calendar_month_nov.substring(
          0,
          min(t.calendar_month_nov.length, 3),
        );
      case 12:
        return t.calendar_month_dec.substring(
          0,
          min(t.calendar_month_dec.length, 3),
        );
      default:
        return '';
    }
  }
}
