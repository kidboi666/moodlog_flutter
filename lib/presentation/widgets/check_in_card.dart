import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/extensions/widget.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/domain/entities/journal/emotion.dart';
import 'package:moodlog/domain/entities/journal/activity.dart';

class CheckInCard extends StatelessWidget {
  final int id;
  final MoodType moodType;
  final DateTime createdAt;
  final int? sleepQuality;
  final String? memo;
  final List<Activity>? activities;
  final List<Emotion>? emotions;
  final void Function() onTap;
  final void Function()? onLongPress;
  final bool isSelectable;
  final bool isSelected;

  const CheckInCard({
    super.key,
    required this.id,
    required this.moodType,
    required this.createdAt,
    this.sleepQuality,
    this.memo,
    this.activities,
    this.emotions,
    required this.onTap,
    this.onLongPress,
    this.isSelectable = false,
    this.isSelected = false,
  });

  String _getSleepEmoji(int quality) {
    switch (quality) {
      case 1:
        return '🌕';
      case 2:
        return '🌖';
      case 3:
        return '🌗';
      case 4:
        return '🌘';
      case 5:
        return '🌑';
      default:
        return '🌗';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(Roundness.card),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(Roundness.card),
          border: isSelected
              ? Border.all(color: colorScheme.primary, width: 2)
              : null,
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(Spacing.lg),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mood emoji
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Color(moodType.colorValue).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(Roundness.md),
                    ),
                    child: Center(
                      child: Text(
                        moodType.emoji,
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                  ),
                  CommonSizedBox.widthMd,

                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Sleep quality indicator
                        if (sleepQuality != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: Spacing.xs),
                            child: Row(
                              children: [
                                Text(
                                  _getSleepEmoji(sleepQuality!),
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),

                        // Activities
                        CommonSizedBox.heightXs,
                        if (activities != null && activities!.isNotEmpty)
                          Wrap(
                            spacing: Spacing.xs,
                            runSpacing: Spacing.xs,
                            children: activities!.take(3).map((tag) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: Spacing.sm,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: colorScheme.surfaceContainerHighest,
                                  borderRadius: BorderRadius.circular(Roundness.xs),
                                ),
                                child: Text(
                                  tag.name,
                                  style: textTheme.labelSmall,
                                ),
                              );
                            }).toList(),
                          )
                        else
                          Text(
                            l10n.check_in_activities_empty,
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                            ),
                          ),

                        // Emotions
                        CommonSizedBox.heightXs,
                        if (emotions != null && emotions!.isNotEmpty)
                          Text(
                            emotions!.take(3).map((e) => e.name).join(', '),
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        else
                          Text(
                            l10n.check_in_emotions_empty,
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                            ),
                          ),

                        // Memo preview
                        if (memo != null && memo!.isNotEmpty) ...[
                          CommonSizedBox.heightXs,
                          Text(
                            memo!,
                            style: textTheme.bodySmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (isSelectable)
              Positioned(
                top: Spacing.sm,
                right: Spacing.sm,
                child: IgnorePointer(
                  child: Checkbox(value: isSelected, onChanged: null),
                ),
              ),
          ],
        ),
      ),
    ).scale();
  }
}
