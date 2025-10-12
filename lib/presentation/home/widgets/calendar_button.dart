import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/home/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarButton extends StatelessWidget {
  const CalendarButton({super.key});

  void _showCalendarSheet(BuildContext context) {
    final viewModel = context.read<HomeViewModel>();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: const _CalendarSheetContent(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FloatingActionButton.small(
      heroTag: 'calendar_button',
      onPressed: () => _showCalendarSheet(context),
      backgroundColor: theme.colorScheme.surface,
      foregroundColor: theme.colorScheme.onSurface.withAlpha(178),
      elevation: 2,
      child: const Icon(Icons.calendar_today_outlined),
    );
  }
}

class _CalendarSheetContent extends StatefulWidget {
  const _CalendarSheetContent();

  @override
  State<_CalendarSheetContent> createState() => _CalendarSheetContentState();
}

class _CalendarSheetContentState extends State<_CalendarSheetContent> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final theme = Theme.of(context);
    final t = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TableCalendar(
        locale: t.localeName,
        focusedDay: viewModel.selectedDate,
        firstDay: DateTime.utc(2010, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        selectedDayPredicate: (day) {
          return isSameDay(viewModel.selectedDate, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          viewModel.selectDate(selectedDay);
          Navigator.pop(context); // Close the sheet after selection
        },
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: theme.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: theme.textTheme.bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
          weekendStyle: theme.textTheme.bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
                calendarStyle: CalendarStyle(
                  defaultTextStyle: const TextStyle(fontWeight: FontWeight.bold),
                  weekendTextStyle: const TextStyle(fontWeight: FontWeight.bold)
                      .copyWith(color: theme.colorScheme.secondary),
                  todayDecoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  todayTextStyle:
                      const TextStyle(fontWeight: FontWeight.bold).copyWith(color: theme.colorScheme.onPrimary),
                  selectedDecoration: BoxDecoration(
                    color: theme.colorScheme.secondary,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  selectedTextStyle:
                      const TextStyle(fontWeight: FontWeight.bold).copyWith(color: theme.colorScheme.onSecondary),
                ),
        calendarBuilders: CalendarBuilders(
          headerTitleBuilder: (context, date) {
            return Column(
              children: [
                Text(
                  DateFormat.yMMMM(t.localeName).format(date),
                  style: theme.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 16.0), // Add spacing here
              ],
            );
          },
          markerBuilder: (context, day, events) {
            final journalsForDay = viewModel.yearlyJournals[DateTime(day.year, day.month, day.day)];
            if (journalsForDay != null && journalsForDay.isNotEmpty) {
              return Positioned(
                bottom: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: journalsForDay
                      .take(3)
                      .map((journal) => Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.symmetric(horizontal: 1.5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(journal.moodType.colorValue),
                            ),
                          ))
                      .toList(),
                ),
              );
            }
            return null;
          },
        ),
      ),
    );
  }
}
