import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/extensions/localization.dart';
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
              : ColorScheme.of(context).surfaceContainer,
          borderRadius: BorderRadius.circular(Roundness.card),
          border: isSelected
              ? Border.all(color: ColorScheme.of(context).primary, width: 2)
              : null,
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(Spacing.xl),
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

  Widget _buildCheckInContent(BuildContext context) {
    final checkIn = entry.checkIn!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.check_circle_outline,
              color: colorScheme.onSurfaceVariant,
              size: 20,
            ),
            const SizedBox(width: Spacing.sm),
            Text(
              t.timeline_check_in,
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: Spacing.sm),
        Row(
          children: [
            Text(checkIn.moodType.emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: Spacing.sm),
            Text(
              checkIn.moodType.getDisplayName(context),
              style: textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Color(checkIn.moodType.colorValue),
              ),
            ),
          ],
        ),
        if (checkIn.tagNames != null && checkIn.tagNames!.isNotEmpty) ...[
          const SizedBox(height: Spacing.sm),
          Text(
            '${t.check_in_activities}: ${checkIn.tagNames!.join(', ')}',
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
          ),
        ],
        if (checkIn.emotionNames != null &&
            checkIn.emotionNames!.isNotEmpty) ...[
          const SizedBox(height: Spacing.xs),
          Text(
            '${t.check_in_emotions}: ${checkIn.emotionNames!.join(', ')}',
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
          ),
        ],
        if (checkIn.sleepQuality != null) ...[
          const SizedBox(height: Spacing.xs),
          Text(
            '${t.check_in_sleep_quality}: ${'⭐' * checkIn.sleepQuality!}',
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
          ),
        ],
        if (checkIn.memo != null && checkIn.memo!.isNotEmpty) ...[
          const SizedBox(height: Spacing.sm),
          Text(
            checkIn.memo!,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }

  Widget _buildJournalContent(BuildContext context) {
    final journal = entry.journal!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Journal icon
        Row(
          children: [
            Icon(Icons.edit_note, color: colorScheme.primary, size: 20),
            const SizedBox(width: Spacing.sm),
            Text(
              t.timeline_journal,
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: Spacing.sm),
        // Content preview
        Text(
          journal.content,
          style: textTheme.bodyMedium,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        if (journal.imageUri != null && journal.imageUri!.isNotEmpty) ...[
          const SizedBox(height: Spacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.sm,
              vertical: Spacing.xs,
            ),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(Roundness.xs),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.image,
                  size: 14,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: Spacing.xs),
                Text(
                  '${journal.imageUri!.length}',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
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
