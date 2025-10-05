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

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    final selectedDateDay = context.read<HomeViewModel>().selectedDate.day;

    Future.delayed(DelayMS.oneSecond * 3, () {
      if (context.mounted) {
        _scrollController.animateTo(
          Spacing.calendarScrollSize * (selectedDateDay - 3),
          duration: DurationMS.lazy,
          curve: Curves.easeInOut,
        );
      }
    });
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
    final dateItems = context.select<HomeViewModel, List<DateTime>>(
      (vm) => vm.dateItems!,
    );
    return FadeIn(
      delay: DelayMS.medium * 4,
      child: GradientBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: Spacing.md),
              child: Text(
                now.getLocalizedMonthName(t),
                style: textTheme.displayMedium?.copyWith(
                  color: colorScheme.surface,
                ),
              ),
            ),
            const SizedBox(height: Spacing.sm),
            SizedBox(
              height: Spacing.horCalendarDateHeight,
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
                      isFuture: date.day > now.day,
                    ),
                  ),
                  const SizedBox(width: Spacing.md),
                ],
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
    super.dispose();
  }
}
