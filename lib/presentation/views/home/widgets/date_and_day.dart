import 'package:flutter/material.dart';

import '../../../../core/constants/common.dart';

class DateAndDay extends StatelessWidget {
  final String date;
  final String day;
  final DateTime selectedDate;
  final Function(DateTime) onTap;

  const DateAndDay({
    super.key,
    required this.date,
    required this.day,
    required this.selectedDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateStyle = theme.textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.surface,
    );

    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: BoxBorder.all(
            width: 1,
            color: date == selectedDate
                ? theme.colorScheme.surface
                : Colors.transparent,
          ),
        ),
        width: Layout.calendarScrollSize,
        child: Column(
          children: [
            Text(day, style: dateStyle),
            Text(date.toString(), style: dateStyle),
          ],
        ),
      ),
    );
  }
}
