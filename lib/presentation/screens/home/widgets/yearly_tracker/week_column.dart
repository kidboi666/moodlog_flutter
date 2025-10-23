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
      width: 16.8,
      margin: const EdgeInsets.only(right: 2),
      child: Column(
        children: week.map((date) {
          if (date == null) {
            return Container(
              width: 14.4,
              height: 14.4,
              margin: const EdgeInsets.only(bottom: 2.4),
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
