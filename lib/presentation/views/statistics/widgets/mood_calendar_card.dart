import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../view_models/statistics/statistics_viewmodel.dart';
import 'base_card.dart';

class MoodCalendarCard extends StatelessWidget {
  final StatisticsViewModel viewModel;

  const MoodCalendarCard({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.statistics_mood_calendar_title,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: Spacing.lg),
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: DateTime.now(),
            availableGestures: AvailableGestures.none,
            calendarFormat: CalendarFormat.month,
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                final mood = viewModel
                    .moodCalendar[DateTime(day.year, day.month, day.day)];
                return Container(
                  margin: const EdgeInsets.all(Spacing.sm),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: mood != null
                        ? Color(mood.colorValue)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: mood != null
                      ? Text(
                          mood.emoji, // Use emoji here
                          style: const TextStyle(
                            fontSize: 18,
                          ), // Adjust font size for emoji
                        )
                      : Text(
                          '${day.day}',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                );
              },
            ),
            onDaySelected: (selectedDay, focusedDay) {
              // 선택된 날짜 처리 로직 (예: ViewModel에 선택된 날짜 전달)
              debugPrint('Selected day: $selectedDay');
            },
          ),
        ],
      ),
    );
  }
}
