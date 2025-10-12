import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/extensions/date_time.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/ui/widgets/gradient_box.dart';
import 'package:moodlog/presentation/home/home_view_model.dart';
import 'package:moodlog/presentation/home/widgets/date_and_day.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class UnifiedCalendarWidget extends StatefulWidget {
  const UnifiedCalendarWidget({super.key});

  @override
  State<UnifiedCalendarWidget> createState() => _UnifiedCalendarWidgetState();
}

class _UnifiedCalendarWidgetState extends State<UnifiedCalendarWidget> {
  @override
  Widget build(BuildContext context) {
    final calendarViewMode = context.watch<HomeViewModel>().calendarViewMode;

    return GradientBox(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return SizeTransition(sizeFactor: animation, child: child);
        },
        child: calendarViewMode == CalendarViewMode.horizontal
            ? _HorizontalView()
            : _GridView(),
      ),
    );
  }
}

// 가로 스크롤 뷰

class _HorizontalView extends StatefulWidget {
  const _HorizontalView();

  @override
  State<_HorizontalView> createState() => _HorizontalViewState();
}

class _HorizontalViewState extends State<_HorizontalView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<HomeViewModel>();

      final selectedDay = viewModel.selectedDate.day;

      // Center the selected day

      final targetOffset =
          (selectedDay - 1) * Spacing.calendarScrollSize -
          (context.size!.width / 2) +
          Spacing.calendarScrollSize / 2;

      _scrollController.jumpTo(targetOffset);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();

    return Column(
      children: [
        _CalendarHeader(),

        const SizedBox(height: Spacing.md),

        SizedBox(
          height: Spacing.horCalendarDateHeight,

          child: ListView.builder(
            controller: _scrollController,

            scrollDirection: Axis.horizontal,

            itemCount: viewModel.dateItems?.length ?? 0,

            itemBuilder: (context, index) {
              final date = viewModel.dateItems![index];

              return DateAndDay(
                date: date,

                todayDate: DateTime.now(),

                selectedDate: viewModel.selectedDate,

                selectDate: viewModel.selectDate,

                isFuture: date.isAfter(DateTime.now()),
              );
            },
          ),
        ),
      ],
    );
  }
}

// 그리드 뷰 (월 단위)

class _GridView extends StatelessWidget {
  const _GridView();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final theme = Theme.of(context);
    final t = AppLocalizations.of(context)!;

    return Column(
      children: [
        _CalendarHeader(),
        TableCalendar(
          locale: t.localeName,
          focusedDay: viewModel.selectedDate,
          firstDay: DateTime.utc(2010, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          selectedDayPredicate: (day) => isSameDay(viewModel.selectedDate, day),
          onDaySelected: (selectedDay, focusedDay) =>
              viewModel.selectDate(selectedDay),
          onPageChanged: (focusedDay) => viewModel.selectMonth(focusedDay),
          headerVisible: false,
          // Use custom header
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
                  bottom: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: journalsForDay
                        .take(3)
                        .map(
                          (journal) => Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.symmetric(horizontal: 1.5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(journal.moodType.colorValue),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                );
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}

// 공통 헤더
class _CalendarHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HomeViewModel>();
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final t = AppLocalizations.of(context)!;
    final displayMonth = context.select((HomeViewModel vm) => vm.displayMonth);
    final currentViewMode = context.select(
      (HomeViewModel vm) => vm.calendarViewMode,
    );

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
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  currentViewMode == CalendarViewMode.horizontal
                      ? Icons.calendar_view_month_outlined
                      : Icons.view_week_outlined,
                  color: colorScheme.surface,
                ),
                onPressed: () {
                  viewModel.toggleCalendarView();
                },
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
        ],
      ),
    );
  }
}
