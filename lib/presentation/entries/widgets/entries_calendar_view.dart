import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../common/constants/common.dart';
import '../../../domain/entities/journal.dart';
import '../viewmodel/entries_viewmodel.dart';
import 'bottom_sheet/journals_for_day_bottom_sheet.dart';
import 'legend_card.dart';

class EntriesCalendarView extends StatelessWidget {
  const EntriesCalendarView({super.key});

  List<Journal> _getEventsForDay(List<Journal> entries, DateTime day) {
    return entries
        .where((journal) => isSameDay(journal.createdAt, day))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Consumer<EntriesViewModel>(
      builder: (context, viewModel, child) {
        return Column(
          children: [
            const LegendCard(),
            const SizedBox(height: Spacing.lg),
            TableCalendar<Journal>(
              firstDay: DateTime(2020),
              lastDay: DateTime(2030),
              focusedDay: viewModel.selectedMonth,
              currentDay: DateTime.now(),
              selectedDayPredicate: (day) {
                return viewModel.selectedDay != null &&
                    isSameDay(viewModel.selectedDay!, day);
              },
              calendarFormat: CalendarFormat.month,
              headerVisible: false,
              daysOfWeekVisible: true,
              eventLoader: (day) => _getEventsForDay(viewModel.entries, day),
              startingDayOfWeek: StartingDayOfWeek.sunday,
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                weekendTextStyle: TextStyle(color: colorScheme.error),
                holidayTextStyle: TextStyle(color: colorScheme.error),
                defaultTextStyle: TextStyle(color: colorScheme.onSurface),
                todayDecoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(
                  color: colorScheme.secondary,
                  shape: BoxShape.circle,
                ),
                markersMaxCount: 3,
                canMarkersOverflow: true,
              ),
              onDaySelected: (selectedDay, focusedDay) {
                viewModel.selectDay(selectedDay);
                final journalsForDay = _getEventsForDay(
                  viewModel.entries,
                  selectedDay,
                );
                if (journalsForDay.isNotEmpty) {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    useRootNavigator: true,
                    builder: (context) => JournalsForDayBottomSheet(
                      day: selectedDay,
                      journals: journalsForDay,
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
