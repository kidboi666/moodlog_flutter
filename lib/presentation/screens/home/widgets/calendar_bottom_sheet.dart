import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/extensions/date_time.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/ui/widgets/gradient_box.dart';
import 'package:moodlog/presentation/screens/home/home_view_model.dart';
import 'package:moodlog/presentation/screens/home/widgets/mood_markers.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarBottomSheet extends StatelessWidget {
  const CalendarBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final theme = Theme.of(context);
    final t = AppLocalizations.of(context)!;

    return GradientBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _CalendarHeader(),
          const SizedBox(height: Spacing.md),
          TableCalendar(
            locale: t.localeName,
            focusedDay: viewModel.selectedDate,
            firstDay: DateTime.utc(2010, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            selectedDayPredicate: (day) =>
                isSameDay(viewModel.selectedDate, day),
            onDaySelected: (selectedDay, focusedDay) {
              viewModel.selectDate(selectedDay);
            },
            onPageChanged: (focusedDay) => viewModel.selectMonth(focusedDay),
            headerVisible: false,
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: theme.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.surface,
              ),
              weekendStyle: theme.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.surface,
              ),
            ),
            calendarStyle: CalendarStyle(
              defaultTextStyle: TextStyle(
                color: theme.colorScheme.surface,
                fontWeight: FontWeight.bold,
              ),
              weekendTextStyle: TextStyle(
                color: theme.colorScheme.surface,
                fontWeight: FontWeight.bold,
              ),
              outsideTextStyle: TextStyle(
                color: theme.colorScheme.surface.withAlpha(102),
                fontWeight: FontWeight.bold,
              ),
              todayDecoration: BoxDecoration(
                color: theme.colorScheme.primary.withAlpha(204),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.0),
              ),
              todayTextStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ).copyWith(color: theme.colorScheme.onPrimary),
              selectedDecoration: BoxDecoration(
                color: theme.colorScheme.surface,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.0),
              ),
              selectedTextStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ).copyWith(color: theme.colorScheme.onSurface),
            ),
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, events) {
                final journalsForDay = viewModel
                    .yearlyJournals[DateTime(day.year, day.month, day.day)];
                if (journalsForDay != null && journalsForDay.isNotEmpty) {
                  return Positioned(
                    bottom: 8,
                    left: 0,
                    right: 0,
                    child: MoodMarkers(journals: journalsForDay),
                  );
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CalendarHeader extends StatelessWidget {
  const _CalendarHeader();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HomeViewModel>();
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final t = AppLocalizations.of(context)!;
    final displayMonth = context.select((HomeViewModel vm) => vm.displayMonth);
    final selectedDate = context.select((HomeViewModel vm) => vm.selectedDate);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.chevron_left, color: colorScheme.surface),
            onPressed: () {
              final newMonth = DateTime(
                displayMonth.year,
                displayMonth.month - 1,
                1,
              );
              viewModel.selectMonth(newMonth);
            },
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  '${displayMonth.getLocalizedMonthName(t)} ${displayMonth.year}',
                  style: textTheme.titleLarge?.copyWith(
                    color: colorScheme.surface,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: Spacing.xs),
                Text(
                  '${selectedDate.getLocalizedWeekdayName(t)}, ${selectedDate.day}${t.common_unit_day}',
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.surface.withAlpha(204),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.chevron_right, color: colorScheme.surface),
            onPressed: () {
              final newMonth = DateTime(
                displayMonth.year,
                displayMonth.month + 1,
                1,
              );
              viewModel.selectMonth(newMonth);
            },
          ),
        ],
      ),
    );
  }
}
