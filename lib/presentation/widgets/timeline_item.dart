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
    final timeFormat = context.select(
      (AppStateProvider asp) => asp.appState.timeFormat,
    );

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 60,
            child: Column(
              children: [
                // Top line
                if (!isFirst)
                  Container(
                    width: 2,
                    height: 24,
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                if (isFirst) const SizedBox(height: 24),

                // Dot
                Container(
                  width: moodType != null ? 16 : 12,
                  height: moodType != null ? 16 : 12,
                  decoration: BoxDecoration(
                    color: moodType != null
                        ? Color(moodType!.colorValue)
                        : Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.6),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.surface,
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
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Color(moodType!.colorValue),
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
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                // Bottom line
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: Theme.of(context).colorScheme.outlineVariant,
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
              padding: EdgeInsets.only(bottom: isLast ? 0 : Spacing.xl),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
