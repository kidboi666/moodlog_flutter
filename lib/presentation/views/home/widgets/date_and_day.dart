import 'package:flutter/material.dart';
import 'package:moodlog/core/extensions/date_time.dart';

import '../../../../core/constants/common.dart';

class DateAndDay extends StatelessWidget {
  final DateTime date;
  final DateTime todayDate;
  final DateTime selectedDate;
  final Function selectDate;

  const DateAndDay({
    super.key,
    required this.date,
    required this.todayDate,
    required this.selectedDate,
    required this.selectDate,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(Spacing.md),
      onTap: () => selectDate(date),
      child: AnimatedContainer(
        duration: DurationMs.quick,
        curve: Curves.easeInOutQuad,
        height: Spacing.horCalendarDateHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Spacing.md),
          color: date.isSameDay(selectedDate)
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          border: BoxBorder.all(
            width: 1,
            color: date.isSameDay(todayDate)
                ? Theme.of(context).colorScheme.outline
                : Colors.transparent,
          ),
        ),
        width: Spacing.calendarScrollSize,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              date.weekdayName,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            Text(
              date.day.toString(),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
