import 'package:flutter/material.dart';

import '../../../core/constants/common.dart';
import '../../../core/extensions/date_time.dart';
import '../../widgets/fade_in.dart';
import '../../widgets/gradient_box.dart';
import 'home_horizontal_calendar.dart';

class CalendarBox extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onSelectedDateChange;
  final DateTime now = DateTime.now();

  CalendarBox({
    super.key,
    required this.selectedDate,
    required this.onSelectedDateChange,
  });

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
            HorizontalCalendar(
              selectedDate: selectedDate,
              onSelectedDateChange: onSelectedDateChange,
            ),
          ],
        ),
      ),
    );
  }
}
