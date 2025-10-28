import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/extensions/widget.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/domain/entities/timeline_entry.dart';

class TimelineCard extends StatelessWidget {
  final TimelineEntry entry;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final bool isSelectable;
  final bool isSelected;

  const TimelineCard({
    super.key,
    required this.entry,
    required this.onTap,
    this.onLongPress,
    this.isSelectable = false,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final isCheckIn = entry.type.isCheckIn;

    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(Roundness.card),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: isCheckIn
              ? Colors.transparent
              : Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(Roundness.card),
          border: isSelected
              ? Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                )
              : null,
        ),
        child: Stack(
          children: [
            Padding(
              padding: CommonPadding.xl,
              child: entry.type.isCheckIn
                  ? _buildCheckInContent(context)
                  : _buildJournalContent(context),
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

  String _getSleepQualityText(BuildContext context, int quality) {
    final t = AppLocalizations.of(context)!;
    switch (quality) {
      case 1:
        return t.quick_check_in_sleep_quality_1;
      case 2:
        return t.quick_check_in_sleep_quality_2;
      case 3:
        return t.quick_check_in_sleep_quality_3;
      case 4:
        return t.quick_check_in_sleep_quality_4;
      case 5:
        return t.quick_check_in_sleep_quality_5;
      default:
        return '';
    }
  }

  Widget _buildCheckInContent(BuildContext context) {
    final checkIn = entry.checkIn!;
    final t = AppLocalizations.of(context)!;
    final items = <Widget>[];

    final hasActivities =
        checkIn.activityNames != null && checkIn.activityNames!.isNotEmpty;
    items.add(
      Text(
        hasActivities
            ? '${t.check_in_activities}: ${checkIn.activityNames!.join(', ')}'
            : '${t.check_in_activities}: ${t.check_in_activities_empty}',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: hasActivities
              ? Theme.of(context).colorScheme.onSurface
              : Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );

    final hasEmotions =
        checkIn.emotionNames != null && checkIn.emotionNames!.isNotEmpty;
    items.add(
      Text(
        hasEmotions
            ? '${t.check_in_emotions}: ${checkIn.emotionNames!.join(', ')}'
            : '${t.check_in_emotions}: ${t.check_in_emotions_empty}',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: hasEmotions
              ? Theme.of(context).colorScheme.onSurface
              : Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );

    if (checkIn.sleepQuality != null) {
      items.add(
        Text(
          '${t.check_in_sleep_quality}: ${_getSleepQualityText(context, checkIn.sleepQuality!)}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      );
    }

    if (checkIn.memo != null && checkIn.memo!.isNotEmpty) {
      items.add(
        Text(
          checkIn.memo!,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              size: 20,
            ),
            CommonSizedBox.widthSm,
            Text(
              t.timeline_check_in,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        if (items.isNotEmpty) ...[
          CommonSizedBox.heightSm,
          for (int i = 0; i < items.length; i++) ...[
            items[i],
            if (i < items.length - 1) CommonSizedBox.heightXs,
          ],
        ],
      ],
    );
  }

  Widget _buildJournalContent(BuildContext context) {
    final journal = entry.journal!;
    final t = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.edit_note,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            ),
            CommonSizedBox.widthSm,
            Text(
              t.timeline_journal,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        CommonSizedBox.heightSm,
        Text(
          journal.content,
          style: Theme.of(context).textTheme.bodyMedium,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        if (journal.imageUri != null && journal.imageUri!.isNotEmpty) ...[
          CommonSizedBox.heightSm,
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.sm,
              vertical: Spacing.xs,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(Roundness.xs),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.image,
                  size: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                CommonSizedBox.widthXs,
                Text(
                  '${journal.imageUri!.length}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
