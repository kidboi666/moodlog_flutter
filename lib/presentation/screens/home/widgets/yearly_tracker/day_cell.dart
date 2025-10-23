import 'package:flutter/material.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';

class DayCell extends StatelessWidget {
  final DateTime date;
  final List<Journal> journals;
  final DateTime now;

  const DayCell({
    super.key,
    required this.date,
    required this.journals,
    required this.now,
  });

  @override
  Widget build(BuildContext context) {
    final hasJournal = journals.isNotEmpty;
    final isFuture = date.isAfter(DateTime(now.year, now.month, now.day));
    final isToday = DateTime(
      date.year,
      date.month,
      date.day,
    ).isAtSameMomentAs(DateTime(now.year, now.month, now.day));
    Color backgroundColor;

    if (isFuture) {
      backgroundColor = Theme.of(
        context,
      ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.2);
    } else if (hasJournal) {
      backgroundColor = Theme.of(
        context,
      ).colorScheme.primary.withValues(alpha: 0.8);
    } else {
      backgroundColor = Theme.of(
        context,
      ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.4);
    }

    return Container(
      width: 14.4, // 12 * 1.2
      height: 14.4, // 12 * 1.2
      margin: const EdgeInsets.only(bottom: 2.4), // 2 * 1.2
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(2.4), // 2 * 1.2
        border: isToday
            ? Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 1.2,
              ) // 1 * 1.2
            : null,
      ),
    );
  }
}
