import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/extensions/date_time.dart';
import 'package:moodlog/core/extensions/widget.dart';
import 'package:moodlog/domain/entities/journal/emotion.dart';
import 'package:moodlog/domain/entities/journal/tag.dart';
import 'package:moodlog/presentation/providers/app_state_provider.dart';
import 'package:provider/provider.dart';

class CheckInCard extends StatelessWidget {
  final int id;
  final MoodType moodType;
  final DateTime createdAt;
  final int? sleepQuality;
  final String? memo;
  final List<Tag>? tags;
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
    this.tags,
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
    final timeFormat = context.select(
      (AppStateProvider asp) => asp.appState.timeFormat,
    );

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
                  const SizedBox(width: Spacing.md),

                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              createdAt.formattedTime(timeFormat),
                              style: textTheme.labelLarge?.copyWith(
                                color: colorScheme.outline,
                              ),
                            ),
                            if (sleepQuality != null) ...[
                              const SizedBox(width: Spacing.sm),
                              Text(
                                _getSleepEmoji(sleepQuality!),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ],
                        ),

                        // Activities
                        if (tags != null && tags!.isNotEmpty) ...[
                          const SizedBox(height: Spacing.xs),
                          Wrap(
                            spacing: Spacing.xs,
                            runSpacing: Spacing.xs,
                            children: tags!.take(3).map((tag) {
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
                          ),
                        ],

                        // Emotions
                        if (emotions != null && emotions!.isNotEmpty) ...[
                          const SizedBox(height: Spacing.xs),
                          Text(
                            emotions!.take(3).map((e) => e.name).join(', '),
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],

                        // Memo preview
                        if (memo != null && memo!.isNotEmpty) ...[
                          const SizedBox(height: Spacing.xs),
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
