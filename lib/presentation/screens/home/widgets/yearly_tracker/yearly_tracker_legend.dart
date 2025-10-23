import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';

class YearlyTrackerLegend extends StatelessWidget {
  const YearlyTrackerLegend({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          t.home_monthly_tracker_legend_less,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        CommonSizedBox.widthXs,
        Row(
          children: [
            _LegendBox(
              color: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
            ),
            CommonSizedBox.widthXs,
            _LegendBox(
              color: Color(MoodType.verySad.colorValue).withValues(alpha: 0.8),
            ),
            CommonSizedBox.widthXs,
            _LegendBox(
              color: Color(MoodType.sad.colorValue).withValues(alpha: 0.8),
            ),
            CommonSizedBox.widthXs,
            _LegendBox(
              color: Color(MoodType.neutral.colorValue).withValues(alpha: 0.8),
            ),
            CommonSizedBox.widthXs,
            _LegendBox(
              color: Color(MoodType.happy.colorValue).withValues(alpha: 0.8),
            ),
            CommonSizedBox.widthXs,
            _LegendBox(
              color: Color(
                MoodType.veryHappy.colorValue,
              ).withValues(alpha: 0.8),
            ),
          ],
        ),
        CommonSizedBox.widthXs,
        Text(
          t.home_monthly_tracker_legend_more,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _LegendBox extends StatelessWidget {
  final Color color;

  const _LegendBox({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
