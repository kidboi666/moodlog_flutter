import 'package:flutter/material.dart';

import '../../../../core/constants/enum.dart';
import '../../../../domain/entities/journal.dart';

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

    // 올해가 아니거나 미래 날짜인지 확인
    final isCurrentYear = date.year == now.year;
    final isFuture = date.isAfter(now);
    final isToday = DateTime(
      date.year,
      date.month,
      date.day,
    ).isAtSameMomentAs(DateTime(now.year, now.month, now.day));

    // 색상 결정
    Color backgroundColor;

    if (!isCurrentYear || isFuture) {
      backgroundColor = colorScheme.surfaceContainerHighest.withValues(
        alpha: 0.2,
      );
    } else if (hasJournal) {
      // 일기가 있는 경우 - 기분에 따른 색상 적용
      final primaryMood = _getPrimaryMood(journals);
      backgroundColor = Color(primaryMood.colorValue).withValues(alpha: 0.8);
    } else {
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

  // 여러 일기가 있을 때 대표 기분 선택 (가장 좋은 기분 우선)
  MoodType _getPrimaryMood(List<Journal> journals) {
    if (journals.isEmpty) return MoodType.neutral;

    // 기분 우선순위: 매우좋음 > 좋음 > 보통 > 안좋음 > 매우안좋음
    final moodPriority = {
      MoodType.veryHappy: 5,
      MoodType.happy: 4,
      MoodType.neutral: 3,
      MoodType.sad: 2,
      MoodType.verySad: 1,
    };

    return journals
        .map((j) => j.moodType)
        .reduce(
          (a, b) => (moodPriority[a] ?? 0) > (moodPriority[b] ?? 0) ? a : b,
        );
  }
}
