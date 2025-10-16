import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/extensions/date_time.dart';
import 'package:moodlog/presentation/providers/app_state_provider.dart';
import 'package:provider/provider.dart';

class TimelineItem extends StatelessWidget {
  final DateTime time;
  final Widget child;
  final bool isFirst;
  final bool isLast;

  const TimelineItem({
    super.key,
    required this.time,
    required this.child,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final timeFormat = context.select(
      (AppStateProvider asp) => asp.appState.timeFormat,
    );

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time label (left)
          SizedBox(
            width: 60,
            child: Padding(
              padding: const EdgeInsets.only(top: Spacing.lg + 4),
              child: Text(
                time.formattedTime(timeFormat),
                style: textTheme.labelMedium?.copyWith(
                  color: colorScheme.outline,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          const SizedBox(width: Spacing.md),

          // Timeline (center)
          SizedBox(
            width: 24,
            child: Column(
              children: [
                // Top line
                if (!isFirst)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: colorScheme.outlineVariant,
                    ),
                  ),
                if (isFirst) const SizedBox(height: Spacing.lg + 4),

                // Dot
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colorScheme.surface,
                      width: 2,
                    ),
                  ),
                ),

                // Bottom line
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: colorScheme.outlineVariant,
                    ),
                  ),
                if (isLast) const SizedBox(height: Spacing.lg),
              ],
            ),
          ),
          const SizedBox(width: Spacing.md),

          // Content (right)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: isLast ? 0 : Spacing.xl,
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
