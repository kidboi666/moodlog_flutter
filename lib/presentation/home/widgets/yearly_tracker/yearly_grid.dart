import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/constants/common.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../domain/entities/journal.dart';
import 'week_column.dart';
import 'weekday_labels.dart';

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
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    // 올해 첫 날과 마지막 날
    final firstDayOfYear = DateTime(now.year, 1, 1);
    final lastDayOfYear = DateTime(now.year, 12, 31);

    // 1월 1일부터 시작 (이전 년도 날짜 포함하지 않음)
    final startDate = firstDayOfYear;

    // 올해 날짜만 생성 (12월 31일까지만)
    final allDates = <DateTime>[];
    var currentDate = startDate;

    while (currentDate.isBefore(lastDayOfYear) ||
        currentDate.isAtSameMomentAs(lastDayOfYear)) {
      allDates.add(currentDate);
      currentDate = currentDate.add(const Duration(days: 1));
    }

    // 주 단위로 그룹화 (7일씩)
    final weeks = <List<DateTime>>[];
    for (int i = 0; i < allDates.length; i += 7) {
      weeks.add(
        allDates.sublist(i, i + 7 > allDates.length ? allDates.length : i + 7),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 좌측 고정 요소들
        Column(
          children: [
            const SizedBox(height: 24), // 월 라벨 높이 (20 * 1.2)
            const SizedBox(height: Spacing.xs),
            const WeekdayLabels(),
          ],
        ),
        const SizedBox(width: Spacing.xs),

        // 스크롤 가능한 영역 (월 라벨 + 그리드)
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                // 월 라벨들
                Row(
                  children: weeks.asMap().entries.map((entry) {
                    final weekIndex = entry.key;
                    final week = entry.value;

                    String monthName = '';

                    // 첫 번째 주는 무조건 1월 표시
                    if (weekIndex == 0) {
                      monthName = _getMonthName(1, context);
                    } else {
                      // 다른 주들은 1일이 포함된 경우만 월 이름 표시
                      final firstOfMonthInWeek = week.firstWhere(
                        (day) => day.day == 1 && day.year == now.year,
                        orElse: () => DateTime(1900), // 기본값
                      );

                      if (firstOfMonthInWeek.year == now.year) {
                        monthName = _getMonthName(
                          firstOfMonthInWeek.month,
                          context,
                        );
                      }
                    }

                    return SizedBox(
                      width: 16.8, // 14 * 1.2
                      height: 24, // 20 * 1.2
                      child: monthName.isNotEmpty
                          ? Align(
                              alignment: Alignment.center,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  monthName,
                                  style: textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                    fontSize: 10,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            )
                          : null,
                    );
                  }).toList(),
                ),
                const SizedBox(height: Spacing.xs),

                // 주별 그리드
                SizedBox(
                  height: 144, // 120 * 1.2
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
          ),
        ),
      ],
    );
  }

  String _getMonthName(int month, BuildContext context) {
    // 짧은 형식의 월 이름 반환 (1~3글자)
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
