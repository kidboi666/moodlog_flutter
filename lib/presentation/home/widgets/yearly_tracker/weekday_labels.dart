import 'package:flutter/material.dart';

class WeekdayLabels extends StatelessWidget {
  const WeekdayLabels({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    const weekdays = ['일', '월', '화', '수', '목', '금', '토'];

    return SizedBox(
      width: 24,
      child: Column(
        children: weekdays
            .map(
              (weekday) => Container(
                height: 14,
                alignment: Alignment.center,
                child: Text(
                  weekday,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 10,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}