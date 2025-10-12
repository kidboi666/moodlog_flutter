import 'package:flutter/material.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';
import 'package:moodlog/presentation/home/widgets/mood_markers.dart';

import '../../../core/constants/common.dart';
import '../../../core/extensions/date_time.dart';
import '../../../core/l10n/app_localizations.dart';

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

    final Color weekdayColor = isSelected
        ? colorScheme.onSurface.withAlpha(153)
        : isFuture
            ? colorScheme.surface.withAlpha(51)
            : colorScheme.surface.withAlpha(153);
    final Color backgroundColor = isSelected
        ? colorScheme.surface
        : isToday
            ? colorScheme.primary.withAlpha(204)
            : Colors.transparent;

    return InkWell(
      onTap: isFuture ? null : () => selectDate(date),
      borderRadius: BorderRadius.circular(Roundness.lg),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: Spacing.calendarScrollSize,
        padding: const EdgeInsets.symmetric(vertical: Spacing.sm),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(Roundness.lg),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  date.getLocalizedWeekdayShortName(t),
                  style: TextStyle(color: weekdayColor, fontSize: 12),
                ),
                const SizedBox(height: Spacing.sm),
                Text(
                  '${date.day}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? colorScheme.onSurface
                        : isFuture
                            ? colorScheme.surface.withAlpha(51)
                            : colorScheme.surface,
                  ),
                ),
              ],
            ),
            if (journals != null && journals!.isNotEmpty)
              Positioned(
                bottom: 0,
                child: MoodMarkers(journals: journals!),
              ),
          ],
        ),
      ),
    );
  }
}
