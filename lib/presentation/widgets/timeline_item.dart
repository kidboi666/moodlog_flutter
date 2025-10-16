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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline (left)
          SizedBox(
            width: 40,
            child: Column(
              children: [
                // Top line
                if (!isFirst)
                  Container(
                    width: 2,
                    height: 24,
                    color: colorScheme.outlineVariant,
                  ),
                if (isFirst) const SizedBox(height: 24),

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

                // Time label (below dot)
                Padding(
                  padding: const EdgeInsets.only(top: Spacing.xs),
                  child: Text(
                    time.formattedTime(timeFormat),
                    style: textTheme.labelSmall?.copyWith(
                      color: colorScheme.outline,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                // Bottom line
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: colorScheme.outlineVariant,
                      margin: const EdgeInsets.only(top: Spacing.xs),
                    ),
                  ),
              ],
            ),
          ),
          CommonSizedBox.widthMd,

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
