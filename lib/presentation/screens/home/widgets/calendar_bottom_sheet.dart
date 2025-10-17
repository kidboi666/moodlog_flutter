import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/extensions/date_time.dart';
import 'package:moodlog/presentation/screens/home/home_view_model.dart';
import 'package:moodlog/presentation/widgets/timeline_list.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';

class CalendarBottomSheet extends StatefulWidget {
  const CalendarBottomSheet({super.key});

  @override
  State<CalendarBottomSheet> createState() => _CalendarBottomSheetState();
}

class _CalendarBottomSheetState extends State<CalendarBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final t = AppLocalizations.of(context)!;
    final selectedDate = viewModel.selectedDate;
    final timelineEntries = viewModel.timelineEntries;
    final isSelectedDateInFuture = viewModel.isSelectedDateInFuture;

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: Padding(
        padding: const EdgeInsets.all(Spacing.md),
        child: Column(
          children: [
            // Drag Handle
            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: ColorScheme.of(context).onSurface,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            CommonSizedBox.heightXl,
            const _CalendarHeader(),
            CommonSizedBox.heightXl,
            TableCalendar(
              locale: t.localeName,
              focusedDay: viewModel.displayMonth,
              firstDay: DateTime.utc(2010, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              selectedDayPredicate: (day) => isSameDay(selectedDate, day),
              enabledDayPredicate: (day) => !day.isAfter(DateTime.now()),
              onDaySelected: (selectedDay, focusedDay) {
                if (!selectedDay.isAfter(DateTime.now())) {
                  viewModel.selectDate(selectedDay);
                }
              },
              onPageChanged: (focusedDay) {
                viewModel.selectMonth(focusedDay);
              },
              headerVisible: false,
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                weekendStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              calendarStyle: CalendarStyle(
                defaultTextStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
                weekendTextStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
                outsideTextStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(102),
                  fontWeight: FontWeight.bold,
                ),
                disabledTextStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(102),
                  fontWeight: FontWeight.bold,
                ),
                todayDecoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onSurface,
                    width: 1,
                  ),
                  shape: BoxShape.circle,
                ),
                todayTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ).copyWith(color: Theme.of(context).colorScheme.onSurface),
                selectedDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurface,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ).copyWith(color: Theme.of(context).colorScheme.surface),
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, events) {
                  final journalsForDay = viewModel
                      .yearlyJournals[DateTime(day.year, day.month, day.day)];
                  if (journalsForDay != null && journalsForDay.isNotEmpty) {
                    final isSelected = isSameDay(selectedDate, day);
                    return Positioned(
                      bottom: 10,
                      child: Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(context).colorScheme.surface
                              : Theme.of(context).colorScheme.onSurface,
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  }
                  return null;
                },
              ),
            ),
            CommonSizedBox.heightLg,
            Expanded(
              child: SafeArea(
                child: TimelineList(
                  entries: timelineEntries,
                  selectedDate: selectedDate,
                  isSelectedDateInFuture: isSelectedDateInFuture,
                  isCompact: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CalendarHeader extends StatelessWidget {
  const _CalendarHeader();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final viewModel = context.read<HomeViewModel>();
    final displayMonth = context.select((HomeViewModel vm) => vm.displayMonth);
    final selectedDate = context.select((HomeViewModel vm) => vm.selectedDate);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Theme.of(context).colorScheme.onSurface,
            ),
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
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: Spacing.xs),
                Text(
                  '${selectedDate.getLocalizedWeekdayName(t)}, ${selectedDate.day}${t.common_unit_day}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(204),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.chevron_right,
              color: Theme.of(context).colorScheme.onSurface,
            ),
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
