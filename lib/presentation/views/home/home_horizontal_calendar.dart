import 'package:flutter/material.dart';

import '../../../core/constants/common.dart';
import '../../../core/extensions/date_time.dart';
import '../../view_models/home/home_viewmodel.dart';
import '../../widgets/fade_in.dart';
import '../../widgets/gradient_box.dart';
import 'home_date_and_day.dart';

class HorizontalCalendar extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime) onSelectedDateChange;
  final HomeViewModel homeViewModel;

  const HorizontalCalendar({
    super.key,
    required this.selectedDate,
    required this.onSelectedDateChange,
    required this.homeViewModel,
  });

  @override
  State<HorizontalCalendar> createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  final DateTime now = DateTime.now();
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final month = now.monthName;

    return FadeIn(
      delay: Duration(milliseconds: DelayMs.medium * 4),
      child: GradientBox(
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              month,
              style: theme.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.surface,
              ),
            ),
            SizedBox(
              height: 70,
              child: ListView(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                children: widget.homeViewModel.dateItems
                    .map(
                      (item) => DateAndDay(
                        day: item[DateItem.day] ?? '',
                        date: item[DateItem.date] ?? '',
                        selectedDate: widget.selectedDate,
                        onTap: widget.onSelectedDateChange,
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
    _controller.dispose();
    super.dispose();
  }
}
