import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/extensions/date_time.dart';
import 'package:moodlog/core/extensions/routing.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/ui/widgets/empty_entries_box.dart';
import 'package:moodlog/core/ui/widgets/journal_card.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';
import 'package:moodlog/presentation/screens/home/home_view_model.dart';
import 'package:moodlog/presentation/screens/home/widgets/mood_markers.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarBottomSheet extends StatefulWidget {
  const CalendarBottomSheet({super.key});

  @override
  State<CalendarBottomSheet> createState() => _CalendarBottomSheetState();
}

class _CalendarBottomSheetState extends State<CalendarBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final theme = Theme.of(context);
    final t = AppLocalizations.of(context)!;
    final selectedDate = viewModel.selectedDate;
    final journalsForSelectedDay =
        viewModel.yearlyJournals[DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
        )] ??
        [];

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(color: theme.colorScheme.surface),
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
            const SizedBox(height: Spacing.md),
            const _CalendarHeader(),
            const SizedBox(height: Spacing.md),
            TableCalendar(
              locale: t.localeName,
              focusedDay: viewModel.displayMonth,
              firstDay: DateTime.utc(2010, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              selectedDayPredicate: (day) => isSameDay(selectedDate, day),
              onDaySelected: (selectedDay, focusedDay) {
                viewModel.selectDate(selectedDay);
              },
              onPageChanged: (focusedDay) {
                viewModel.selectMonth(focusedDay);
              },
              headerVisible: false,
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: theme.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
                weekendStyle: theme.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              calendarStyle: CalendarStyle(
                defaultDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                weekendDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                defaultTextStyle: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
                weekendTextStyle: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
                outsideTextStyle: TextStyle(
                  color: theme.colorScheme.onSurface.withAlpha(102),
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
                  color: theme.colorScheme.onSurface,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                selectedTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ).copyWith(color: theme.colorScheme.surface),
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, events) {
                  final journalsForDay = viewModel
                      .yearlyJournals[DateTime(day.year, day.month, day.day)];
                  if (journalsForDay != null && journalsForDay.isNotEmpty) {
                    return Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: MoodMarkers(journals: journalsForDay),
                    );
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: Spacing.lg),
            Expanded(child: _buildJournalList(journalsForSelectedDay)),
          ],
        ),
      ),
    );
  }

  Widget _buildJournalList(List<Journal> journals) {
    final viewModel = context.read<HomeViewModel>();
    if (journals.isEmpty) {
      return EmptyEntriesBox(
        isDisabled: false,
        selectedDate: viewModel.selectedDate,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
      itemCount: journals.length,
      itemBuilder: (context, index) {
        final journal = journals[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: Spacing.md),
          child: JournalCard(
            id: journal.id,
            content: journal.content ?? '',
            moodType: journal.moodType,
            coverImg: journal.imageUri?.isNotEmpty == true
                ? journal.imageUri!.first
                : null,
            createdAt: journal.createdAt,
            onTap: () => context.pushToJournalFromHome(journal.id),
            tags: journal.tags,
            isCompact: true,
          ),
        );
      },
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
            icon: Icon(Icons.chevron_left, color: colorScheme.onSurface),
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
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: Spacing.xs),
                Text(
                  '${selectedDate.getLocalizedWeekdayName(t)}, ${selectedDate.day}${t.common_unit_day}',
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurface.withAlpha(204),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.chevron_right, color: colorScheme.onSurface),
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
