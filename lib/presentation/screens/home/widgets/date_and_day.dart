import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/extensions/date_time.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';

class DateAndDay extends StatelessWidget {
  final DateTime date;
  final DateTime todayDate;
  final DateTime selectedDate;
  final Function(DateTime) selectDate;
  final bool isFuture;
  final List<Journal>? journals;

  const DateAndDay({
    super.key,
    required this.date,
    required this.todayDate,
    required this.selectedDate,
    required this.selectDate,
    required this.isFuture,
    this.journals,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = date.isSameDay(selectedDate);
    final bool isToday = date.isSameDay(todayDate);
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    final Color textColor = isSelected
        ? colorScheme.onSurface
        : isFuture
        ? colorScheme.surface.withAlpha(51)
        : colorScheme.surface;
    final Color weekdayColor = isSelected
        ? colorScheme.onSurface.withAlpha(153)
        : isFuture
        ? colorScheme.surface.withAlpha(51)
        : colorScheme.surface.withAlpha(153);
    final Color backgroundColor = isSelected
        ? colorScheme.surface
        : Colors.transparent;
    final Color dotColor = isSelected
        ? colorScheme.onSurface
        : colorScheme.surface;

    return InkWell(
      onTap: isFuture ? null : () => selectDate(date),
      borderRadius: BorderRadius.circular(Roundness.lg),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: Spacing.calendarScrollSize,
        padding: CommonPadding.verticalSm,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(Roundness.lg),
          border: isToday && !isSelected
              ? Border.all(color: colorScheme.surface, width: 1)
              : null,
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    date.getLocalizedWeekdayShortName(t),
                    style: TextStyle(
                      color: weekdayColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${date.day}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
            if (journals != null && journals!.isNotEmpty)
              Positioned(
                bottom: 4,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: dotColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
