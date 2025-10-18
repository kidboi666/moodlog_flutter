import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/extensions/date_time.dart';
import 'package:moodlog/core/extensions/localization.dart';
import 'package:moodlog/presentation/providers/app_state_provider.dart';
import 'package:provider/provider.dart';

class TimelineItem extends StatelessWidget {
  final DateTime time;
  final Widget child;
  final bool isFirst;
  final bool isLast;
  final MoodType? moodType;

  const TimelineItem({
    super.key,
    required this.time,
    required this.child,
    this.isFirst = false,
    this.isLast = false,
    this.moodType,
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
            width: 60,
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
                  width: moodType != null ? 16 : 12,
                  height: moodType != null ? 16 : 12,
                  decoration: BoxDecoration(
                    color: moodType != null
                        ? Color(moodType!.colorValue)
                        : colorScheme.primary.withValues(alpha: 0.6),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colorScheme.surface,
                      width: 2,
                    ),
                  ),
                ),

                // Mood label (for check-in)
                if (moodType != null)
                  Padding(
                    padding: const EdgeInsets.only(top: Spacing.xs),
                    child: Text(
                      moodType!.getDisplayName(context),
                      style: textTheme.labelSmall?.copyWith(
                        color: Color(moodType!.colorValue),
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                // Time label (below dot or mood)
                Padding(
                  padding: const EdgeInsets.only(top: Spacing.xs),
                  child: Text(
                    time.formattedTime(timeFormat),
                    style: textTheme.labelSmall?.copyWith(
                      color: colorScheme.outline,
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
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
