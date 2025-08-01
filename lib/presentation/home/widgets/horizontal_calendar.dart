import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/extensions/date_time.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../widgets/fade_in.dart';
import '../../widgets/gradient_box.dart';
import '../viewmodel/home_viewmodel.dart';
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
          40.0 * selectedDateDay,
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
          spacing: Spacing.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: Spacing.md),
              child: Text(
                context.read<HomeViewModel>().now.getLocalizedMonthName(t),
                style: textTheme.displayMedium?.copyWith(
                  color: colorScheme.surface,
                ),
              ),
            ),
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
