import 'package:flutter/material.dart';

import '../../../../common/constants/common.dart';
import '../../../common/extensions/date_time.dart';
import '../../../common/l10n/app_localizations.dart';

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
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
              ? colorScheme.primary
              : Colors.transparent,
          border: BoxBorder.all(
            width: 1,
            color: date.isSameDay(todayDate)
                ? colorScheme.outline
                : Colors.transparent,
          ),
        ),
        width: Spacing.calendarScrollSize,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              date.getLocalizedWeekdayShortName(t),
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.surface,
              ),
            ),
            Text(
              date.day.toString(),
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.surface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
