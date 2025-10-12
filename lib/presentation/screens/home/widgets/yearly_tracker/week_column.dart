import 'package:flutter/material.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';
import 'package:moodlog/presentation/screens/home/widgets/yearly_tracker/day_cell.dart';

class WeekColumn extends StatelessWidget {
  final List<DateTime?> week;
  final Map<DateTime, List<Journal>> yearlyJournals;
  final DateTime now;

  const WeekColumn({
    super.key,
    required this.week,
    required this.yearlyJournals,
    required this.now,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16.8, // 14 * 1.2
      margin: const EdgeInsets.only(right: 2),
      child: Column(
        children: week.map((date) {
          if (date == null) {
            // 다른 년도 날짜는 투명한 빈 셀로 표시
            return Container(
              width: 14.4, // 12 * 1.2
              height: 14.4, // 12 * 1.2
              margin: const EdgeInsets.only(bottom: 2.4), // 2 * 1.2
            );
          }

          final dateKey = DateTime(date.year, date.month, date.day);
          final journals = yearlyJournals[dateKey] ?? [];

          return DayCell(date: date, journals: journals, now: now);
        }).toList(),
      ),
    );
  }
}
