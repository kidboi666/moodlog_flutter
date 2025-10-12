import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/extensions/date_time.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/ui/widgets/gradient_box.dart';
import 'package:moodlog/presentation/screens/home/home_view_model.dart';
import 'package:moodlog/presentation/screens/home/widgets/date_and_day.dart';
import 'package:moodlog/presentation/screens/home/widgets/mood_markers.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class UnifiedCalendarWidget extends StatefulWidget {
  const UnifiedCalendarWidget({super.key});

  @override
  State<UnifiedCalendarWidget> createState() => _UnifiedCalendarWidgetState();
}

class _UnifiedCalendarWidgetState extends State<UnifiedCalendarWidget> {
  final GlobalKey<_HorizontalViewState> _horizontalViewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final calendarViewMode = context.watch<HomeViewModel>().calendarViewMode;

    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: GradientBox(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            final isGridView = child.key == const ValueKey('grid');
            final slideTween = Tween<Offset>(
              begin: Offset(isGridView ? 1.0 : -1.0, 0.0),
              end: Offset.zero,
            );
            return ClipRect(
              child: SlideTransition(
                position: slideTween.animate(animation),
                child: child,
              ),
            );
          },
          child: calendarViewMode == CalendarViewMode.horizontal
              ? _HorizontalView(key: _horizontalViewKey)
              : const _GridView(key: ValueKey('grid')),
        ),
      ),
    );
  }
}

// 가로 스크롤 뷰

class _HorizontalView extends StatefulWidget {
  const _HorizontalView({super.key});

  @override
  State<_HorizontalView> createState() => _HorizontalViewState();
}

class _HorizontalViewState extends State<_HorizontalView>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(begin: Offset.zero, end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<HomeViewModel>();
      final selectedDay = viewModel.selectedDate.day;
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
    _animationController.dispose();
    super.dispose();
  }

  Future<void> goToPreviousMonth() async {
    if (_isAnimating) return;
    _isAnimating = true;

    _slideAnimation =
        Tween<Offset>(begin: const Offset(-1.0, 0.0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );
    await _animationController.forward(from: 0.0);
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
    _isAnimating = false;
  }

  Future<void> goToNextMonth() async {
    if (_isAnimating) return;
    _isAnimating = true;

    _slideAnimation =
        Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );
    await _animationController.forward(from: 0.0);
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
    _isAnimating = false;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    return Column(
      children: [
        _CalendarHeader(
          onGoToPreviousMonth: goToPreviousMonth,
          onGoToNextMonth: goToNextMonth,
        ),
        const SizedBox(height: Spacing.md),
        SizedBox(
          height: Spacing.horCalendarDateHeight,
          child: SlideTransition(
            position: _slideAnimation,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: viewModel.dateItems?.length ?? 0,
              itemBuilder: (context, index) {
                final date = viewModel.dateItems![index];
                final journalsForDay = viewModel
                    .yearlyJournals[DateTime(date.year, date.month, date.day)];
                return DateAndDay(
                  date: date,
                  todayDate: DateTime.now(),
                  selectedDate: viewModel.selectedDate,
                  selectDate: viewModel.selectDate,
                  isFuture: date.isAfter(DateTime.now()),
                  journals: journalsForDay,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _GridView extends StatelessWidget {
  const _GridView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final theme = Theme.of(context);
    final t = AppLocalizations.of(context)!;

    return Column(
      children: [
        _CalendarHeader(),
        const SizedBox(height: Spacing.md),
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
            defaultDecoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8.0),
            ),
            weekendDecoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8.0),
            ),
            outsideDecoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8.0),
            ),
            disabledDecoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8.0),
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
    );
  }
}

// 공통 헤더
class _CalendarHeader extends StatelessWidget {
  final VoidCallback? onGoToPreviousMonth;
  final VoidCallback? onGoToNextMonth;

  const _CalendarHeader({this.onGoToPreviousMonth, this.onGoToNextMonth});

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
              onGoToPreviousMonth?.call();
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
              onGoToNextMonth?.call();
            },
          ),
        ],
      ),
    );
  }
}
