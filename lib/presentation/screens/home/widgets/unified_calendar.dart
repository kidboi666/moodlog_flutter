import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/extensions/date_time.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/home/home_view_model.dart';
import 'package:moodlog/presentation/screens/home/widgets/date_and_day.dart';
import 'package:moodlog/presentation/widgets/gradient_box.dart';
import 'package:provider/provider.dart';

class UnifiedCalendarWidget extends StatelessWidget {
  const UnifiedCalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBox(child: _HorizontalView());
  }
}

// 가로 스크롤 뷰

class _HorizontalView extends StatefulWidget {
  const _HorizontalView();

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
