import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/extensions/date_time.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/ui/widgets/fade_in.dart';
import '../../../core/ui/widgets/gradient_box.dart';
import '../home_view_model.dart';
import 'date_and_day.dart';

class HorizontalCalendar extends StatefulWidget {
  const HorizontalCalendar({super.key});

  @override
  State<HorizontalCalendar> createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar>
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

    // 현재 날짜로 자동 스크롤
    final selectedDateDay = context.read<HomeViewModel>().selectedDate.day;
    Future.delayed(DelayMS.oneSecond * 3, () {
      if (context.mounted && _scrollController.hasClients) {
        _scrollController.animateTo(
          Spacing.calendarScrollSize * (selectedDateDay - 3),
          duration: DurationMS.lazy,
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Future<void> _goToPreviousMonth(HomeViewModel viewModel) async {
    if (_isAnimating) return;
    _isAnimating = true;

    // 오른쪽에서 왼쪽으로 슬라이드
    _slideAnimation =
        Tween<Offset>(begin: const Offset(-1.0, 0.0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );

    final currentMonth = viewModel.displayMonth;
    final previousMonth = DateTime(
      currentMonth.year,
      currentMonth.month - 1,
      1,
    );
    viewModel.selectMonth(previousMonth);

    await _animationController.forward(from: 0.0);

    // 스크롤을 처음으로 리셋
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }

    _isAnimating = false;
  }

  Future<void> _goToNextMonth(HomeViewModel viewModel) async {
    if (_isAnimating) return;
    _isAnimating = true;

    // 왼쪽에서 오른쪽으로 슬라이드
    _slideAnimation =
        Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );

    final currentMonth = viewModel.displayMonth;
    final nextMonth = DateTime(currentMonth.year, currentMonth.month + 1, 1);
    viewModel.selectMonth(nextMonth);

    await _animationController.forward(from: 0.0);

    // 스크롤을 처음으로 리셋
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }

    _isAnimating = false;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;
    final viewModel = context.read<HomeViewModel>();
    final selectedDate = context.select<HomeViewModel, DateTime>(
      (vm) => vm.selectedDate,
    );
    final displayMonth = context.select<HomeViewModel, DateTime>(
      (vm) => vm.displayMonth,
    );
    final dateItems = context.select<HomeViewModel, List<DateTime>>(
      (vm) => vm.dateItems!,
    );

    return FadeIn(
      delay: DelayMS.medium * 4,
      child: GradientBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 이전 달 버튼
                  IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      color: colorScheme.surface,
                    ),
                    onPressed: () => _goToPreviousMonth(viewModel),
                  ),
                  // 월과 날짜 정보
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
                        SizedBox(height: Spacing.xs),
                        Text(
                          '${selectedDate.getLocalizedWeekdayName(t)}, ${selectedDate.day}일',
                          style: textTheme.titleMedium?.copyWith(
                            color: colorScheme.surface.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 다음 달 버튼
                  IconButton(
                    icon: Icon(
                      Icons.chevron_right,
                      color: colorScheme.surface,
                    ),
                    onPressed: () => _goToNextMonth(viewModel),
                  ),
                ],
              ),
            ),
            SizedBox(height: Spacing.md),
            SizedBox(
              height: Spacing.horCalendarDateHeight,
              child: SlideTransition(
                position: _slideAnimation,
                child: ListView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(width: Spacing.md),
                    ...dateItems.map(
                      (date) => DateAndDay(
                        date: date,
                        todayDate: now,
                        selectedDate: selectedDate,
                        selectDate: viewModel.selectDate,
                        isFuture: date.isAfter(now),
                      ),
                    ),
                    const SizedBox(width: Spacing.md),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
