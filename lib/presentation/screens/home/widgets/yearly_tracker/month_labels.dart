import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';

class MonthLabels extends StatelessWidget {
  final List<List<DateTime>> weeks;
  final DateTime now;

  const MonthLabels({super.key, required this.weeks, required this.now});

  @override
  Widget build(BuildContext context) {
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
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        monthLabels.add(CommonSizedBox.widthMd);
      }
    }

    return Row(
      children: [
        CommonSizedBox.widthXxl,
        CommonSizedBox.widthXs,
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
