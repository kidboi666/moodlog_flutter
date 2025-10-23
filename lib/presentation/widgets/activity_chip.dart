import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/domain/entities/journal/activity.dart';

class ActivityChip extends StatelessWidget {
  final Activity activity;
  final bool isCompact;

  const ActivityChip({
    super.key,
    required this.activity,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? Spacing.sm : Spacing.md,
        vertical: isCompact ? Spacing.xs : Spacing.sm,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(Roundness.chip),
      ),
      child: Text(
        '#${activity.name}',
        style:
            (isCompact
                    ? Theme.of(context).textTheme.labelSmall
                    : Theme.of(context).textTheme.labelMedium)
                ?.copyWith(color: Theme.of(context).colorScheme.outline),
      ),
    );
  }
}
