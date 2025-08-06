import 'package:flutter/material.dart';

import '../../../../common/constants/common.dart';
import '../../../../domain/entities/journal.dart';
import 'month_labels.dart';
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
    // 올해 첫 날과 마지막 날
    final firstDayOfYear = DateTime(now.year, 1, 1);
    final lastDayOfYear = DateTime(now.year, 12, 31);

    // 첫 날이 속한 주의 일요일부터 시작
    final startDate = firstDayOfYear.subtract(
      Duration(days: firstDayOfYear.weekday % 7),
    );

    // 마지막 날까지의 모든 날짜 생성
    final allDates = <DateTime>[];
    var currentDate = startDate;

    while (currentDate.isBefore(lastDayOfYear) ||
        currentDate.isAtSameMomentAs(lastDayOfYear) ||
        currentDate.weekday != 7) {
      // 토요일까지 채우기
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

    return Column(
      children: [
        // 월 라벨 (상단)
        MonthLabels(weeks: weeks, now: now),
        const SizedBox(height: Spacing.xs),

        // 메인 그리드 (좌우 스크롤 가능)
        SizedBox(
          height: 120, // 7일 + 여백
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // 요일 라벨 (좌측 고정)
                const WeekdayLabels(),
                const SizedBox(width: Spacing.xs),

                // 주별 열들
                ...weeks.map(
                  (week) => WeekColumn(
                    week: week,
                    yearlyJournals: yearlyJournals,
                    now: now,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}