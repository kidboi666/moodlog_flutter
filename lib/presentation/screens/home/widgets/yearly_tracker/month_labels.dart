import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';

class MonthLabels extends StatelessWidget {
  final List<List<DateTime>> weeks;
  final DateTime now;

  const MonthLabels({super.key, required this.weeks, required this.now});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    // 각 주의 첫 번째 날을 기준으로 월 라벨 생성
    final monthLabels = <Widget>[];
    String? currentMonth;

    for (int i = 0; i < weeks.length; i++) {
      final week = weeks[i];
      final firstDay = week.first;
      final monthName = _getMonthName(firstDay.month);

      if (currentMonth != monthName && firstDay.year == now.year) {
        currentMonth = monthName;
        monthLabels.add(
          SizedBox(
            width: 14, // 각 주 열의 너비와 동일
            child: Text(
              monthName,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        monthLabels.add(const SizedBox(width: 14));
      }
    }

    return Row(
      children: [
        const SizedBox(width: 24), // 요일 라벨 공간
        const SizedBox(width: Spacing.xs),
        ...monthLabels,
      ],
    );
  }

  String _getMonthName(int month) {
    const monthNames = [
      '',
      '1월',
      '2월',
      '3월',
      '4월',
      '5월',
      '6월',
      '7월',
      '8월',
      '9월',
      '10월',
      '11월',
      '12월',
    ];
    return monthNames[month];
  }
}
