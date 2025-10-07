import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/constants/common.dart';
import '../../../domain/entities/journal/journal.dart';
import '../entries_view_model.dart';
import 'bottom_sheet/journals_for_day_bottom_sheet.dart';

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
    final textTheme = Theme.of(context).textTheme;
    final (:selectedMonth, :entries, :selectedDay) = context.select(
      (EntriesViewModel vm) => (
        selectedMonth: vm.selectedMonth,
        entries: vm.entries,
        selectedDay: vm.selectedDay,
      ),
    );

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(Spacing.lg),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(Roundness.card),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Roundness.card),
            child: TableCalendar<Journal>(
              firstDay: DateTime(2020),
              lastDay: DateTime(2030),
              focusedDay: selectedMonth,
              currentDay: DateTime.now(),
              selectedDayPredicate: (day) {
                return selectedDay != null && isSameDay(selectedDay, day);
              },
              calendarFormat: CalendarFormat.month,
              headerVisible: false,
              daysOfWeekVisible: true,
              eventLoader: (day) => _getEventsForDay(entries, day),
              startingDayOfWeek: StartingDayOfWeek.sunday,
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle:
                    textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w600,
                    ) ??
                    const TextStyle(),
                weekendStyle:
                    textTheme.bodySmall?.copyWith(
                      color: colorScheme.error.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w600,
                    ) ??
                    const TextStyle(),
              ),
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                weekendTextStyle: TextStyle(
                  color: colorScheme.error,
                  fontWeight: FontWeight.w500,
                ),
                holidayTextStyle: TextStyle(
                  color: colorScheme.error,
                  fontWeight: FontWeight.w500,
                ),
                defaultTextStyle: TextStyle(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
                todayDecoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: colorScheme.primary, width: 2),
                ),
                todayTextStyle: TextStyle(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
                selectedDecoration: BoxDecoration(
                  color: colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
                markerDecoration: BoxDecoration(
                  color: colorScheme.secondary,
                  shape: BoxShape.circle,
                ),
                markersMaxCount: 1,
                markerSize: 6,
                markerMargin: const EdgeInsets.symmetric(horizontal: 1),
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, events) {
                  if (events.isEmpty) return null;

                  // 해당 날짜의 첫 번째 저널의 감정으로 표시
                  final journal = events.first;
                  return Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Color(journal.moodType.colorValue),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.surface,
                          width: 1,
                        ),
                      ),
                    ),
                  );
                },
              ),
              onDaySelected: (selectedDay, focusedDay) {
                context.read<EntriesViewModel>().selectDay(selectedDay);
                final journalsForDay = _getEventsForDay(
                  entries,
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
          ),
        ),
      ],
    );
  }
}
