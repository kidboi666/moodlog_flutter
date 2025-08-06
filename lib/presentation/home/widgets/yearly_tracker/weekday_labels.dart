import 'package:flutter/material.dart';

import '../../../../common/l10n/app_localizations.dart';

class WeekdayLabels extends StatelessWidget {
  const WeekdayLabels({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final t = AppLocalizations.of(context)!;
    final weekdays = [
      t.calendar_weekday_sun,
      t.calendar_weekday_mon,
      t.calendar_weekday_tue,
      t.calendar_weekday_wed,
      t.calendar_weekday_thu,
      t.calendar_weekday_fri,
      t.calendar_weekday_sat,
    ];

    return SizedBox(
      width: 28.8, // 24 * 1.2
      child: Column(
        children: weekdays
            .map(
              (weekday) => Container(
                height: 16.8, // 14 * 1.2
                alignment: Alignment.center,
                child: Text(
                  weekday,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 12, // 10 * 1.2
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
