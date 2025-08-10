import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/extensions/date_time.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../ui/widgets/fade_in.dart';
import '../../ui/widgets/gradient_box.dart';
import '../home_viewmodel.dart';
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

    Future.delayed(DelayMs.lazy * 3, () {
      if (context.mounted) {
        _scrollController.animateTo(
          40.0 * (selectedDateDay - 1),
          duration: DurationMs.medium,
          curve: Curves.easeInQuart,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;

    return FadeIn(
      delay: DelayMs.medium * 4,
      child: GradientBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: Spacing.md),
              child: Selector<HomeViewModel, DateTime>(
                selector: (context, viewModel) => viewModel.now,
                builder: (context, now, _) {
                  return Text(
                    now.getLocalizedMonthName(t),
                    style: textTheme.displayMedium?.copyWith(
                      color: colorScheme.surface,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: Spacing.sm),
            SizedBox(
              height: Spacing.horCalendarDateHeight,
              child: Consumer<HomeViewModel>(
                builder: (context, viewModel, _) {
                  return ListView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    children: [
                      const SizedBox(width: Spacing.md),
                      ...viewModel.dateItems!.map(
                        (date) => DateAndDay(
                          date: date,
                          todayDate: viewModel.now,
                          selectedDate: viewModel.selectedDate,
                          selectDate: viewModel.selectDate,
                          isFuture: date.day > viewModel.now.day,
                        ),
                      ),
                      const SizedBox(width: Spacing.md),
                    ],
                  );
                },
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
