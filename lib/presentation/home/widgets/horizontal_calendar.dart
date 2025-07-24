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
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
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
            Text(
              viewModel.now.getLocalizedMonthName(t),
              style: textTheme.displayMedium?.copyWith(
                color: colorScheme.surface,
              ),
            ),
            SizedBox(
              height: Spacing.horCalendarDateHeight,
              child: ListView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                children: viewModel.dateItems!
                    .map(
                      (date) => DateAndDay(
                        date: date,
                        todayDate: viewModel.now,
                        selectedDate: viewModel.selectedDate,
                        selectDate: viewModel.selectDate,
                      ),
                    )
                    .toList(),
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
