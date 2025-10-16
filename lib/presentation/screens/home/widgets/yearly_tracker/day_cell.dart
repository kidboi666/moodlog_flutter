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
    final colorScheme = Theme.of(context).colorScheme;

    final hasJournal = journals.isNotEmpty;

    // 미래 날짜인지 확인 (올해 날짜만 들어오므로 isCurrentYear 체크 불필요)
    final isFuture = date.isAfter(DateTime(now.year, now.month, now.day));
    final isToday = DateTime(
      date.year,
      date.month,
      date.day,
    ).isAtSameMomentAs(DateTime(now.year, now.month, now.day));

    // 색상 결정
    Color backgroundColor;

    if (isFuture) {
      // 미래 날짜는 연하게 표시
      backgroundColor = colorScheme.surfaceContainerHighest.withValues(
        alpha: 0.2,
      );
    } else if (hasJournal) {
      // 일기가 있는 경우 - 단일 색상 표시
      backgroundColor = colorScheme.primary.withValues(alpha: 0.8);
    } else {
      // 일기가 없는 과거/현재 날짜
      backgroundColor = colorScheme.surfaceContainerHighest.withValues(
        alpha: 0.4,
      );
    }

    return Container(
      width: 14.4, // 12 * 1.2
      height: 14.4, // 12 * 1.2
      margin: const EdgeInsets.only(bottom: 2.4), // 2 * 1.2
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(2.4), // 2 * 1.2
        border: isToday
            ? Border.all(color: colorScheme.primary, width: 1.2) // 1 * 1.2
            : null,
      ),
    );
  }

}
