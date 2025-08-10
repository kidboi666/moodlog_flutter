import 'package:flutter/material.dart';

import '../../../../core/constants/common.dart';
import '../../../../core/constants/enum.dart';
import '../../../../core/l10n/app_localizations.dart';

class YearlyTrackerLegend extends StatelessWidget {
  const YearlyTrackerLegend({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final t = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          t.home_monthly_tracker_legend_less,
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: Spacing.xs),

        // 범례 색상 박스들
        Row(
          children: [
            _LegendBox(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
            ),
            const SizedBox(width: 2),
            _LegendBox(
              color: Color(MoodType.verySad.colorValue).withValues(alpha: 0.8),
            ),
            const SizedBox(width: 2),
            _LegendBox(
              color: Color(MoodType.sad.colorValue).withValues(alpha: 0.8),
            ),
            const SizedBox(width: 2),
            _LegendBox(
              color: Color(MoodType.neutral.colorValue).withValues(alpha: 0.8),
            ),
            const SizedBox(width: 2),
            _LegendBox(
              color: Color(MoodType.happy.colorValue).withValues(alpha: 0.8),
            ),
            const SizedBox(width: 2),
            _LegendBox(
              color: Color(
                MoodType.veryHappy.colorValue,
              ).withValues(alpha: 0.8),
            ),
          ],
        ),

        const SizedBox(width: Spacing.xs),
        Text(
          t.home_monthly_tracker_legend_more,
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
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
