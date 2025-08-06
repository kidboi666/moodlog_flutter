import 'package:flutter/material.dart';

import '../../../../domain/entities/journal.dart';
import 'day_cell.dart';

class WeekColumn extends StatelessWidget {
  final List<DateTime> week;
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
      width: 14,
      margin: const EdgeInsets.only(right: 2),
      child: Column(
        children: week.map((date) {
          final dateKey = DateTime(date.year, date.month, date.day);
          final journals = yearlyJournals[dateKey] ?? [];
          
          return DayCell(
            date: date,
            journals: journals,
            now: now,
          );
        }).toList(),
      ),
    );
  }
}