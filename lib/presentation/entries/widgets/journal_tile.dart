import 'package:flutter/material.dart';

import '../../../common/constants/common.dart';
import '../../../common/extensions/routing.dart';
import '../../../common/extensions/widget_scale.dart';
import '../../../domain/entities/journal.dart';
import '../../widgets/tag_section.dart';

class JournalTile extends StatelessWidget {
  final Journal journal;

  const JournalTile({super.key, required this.journal});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          context.pushToJournalFromEntries(journal.id);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.md,
            vertical: Spacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: journal.moodType.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: Spacing.sm),
                  Text(
                    journal.moodType.displayName,
                    style: textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${journal.createdAt.hour.toString().padLeft(2, '0')}:${journal.createdAt.minute.toString().padLeft(2, '0')}',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.outline,
                    ),
                  ),
                ],
              ),
              if (journal.content != null && journal.content!.isNotEmpty) ...[
                const SizedBox(height: Spacing.sm),
                Text(
                  journal.content!,
                  style: textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              if (journal.tags != null && journal.tags!.isNotEmpty) ...[
                const SizedBox(height: Spacing.sm),
                TagSection(
                  tags: journal.tags!,
                  maxTags: 3,
                  spacing: Spacing.xs,
                  runSpacing: Spacing.xs,
                  chipFontSize: 10,
                  chipPadding: const EdgeInsets.symmetric(
                    horizontal: Spacing.xs,
                    vertical: 2,
                  ),
                  chipBorderRadius: 4,
                ),
              ],
            ],
          ),
        ),
      ),
    ).scale();
  }
}
