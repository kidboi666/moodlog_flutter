import 'package:flutter/material.dart';
import 'package:moodlog/core/extensions/date_time.dart';

import '../../../../core/constants/common.dart';
import '../../../view_models/home/home_viewmodel.dart';
import '../../../widgets/fade_in.dart';
import '../../../widgets/gradient_box.dart';
import 'date_and_day.dart';

class HorizontalCalendar extends StatefulWidget {
  final HomeViewModel viewModel;

  const HorizontalCalendar({super.key, required this.viewModel});

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
    return FadeIn(
      delay: DelayMs.medium * 4,
      child: GradientBox(
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.viewModel.now.monthName,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            ListenableBuilder(
              listenable: widget.viewModel,
              builder: (context, _) {
                return SizedBox(
                  height: Spacing.horCalendarDateHeight,
                  child: ListView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    children: widget.viewModel.dateItems!
                        .map(
                          (date) => DateAndDay(
                            date: date,
                            todayDate: widget.viewModel.now,
                            selectedDate: widget.viewModel.selectedDate,
                            selectDate: widget.viewModel.selectDate,
                          ),
                        )
                        .toList(),
                  ),
                );
              },
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
