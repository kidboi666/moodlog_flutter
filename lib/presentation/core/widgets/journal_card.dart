import 'dart:io';
import 'package:flutter/material.dart';

import '../../../common/constants/common.dart';
import '../../../common/constants/enum.dart';
import '../../../common/extensions/date_time.dart';
import '../../../common/extensions/widget_scale.dart';
import '../../../common/l10n/app_localizations.dart';

class JournalCard extends StatelessWidget {
  final int id;
  final String content;
  final MoodType moodType;
  final String? coverImg;
  final DateTime createdAt;
  final void Function() onTap;
  final void Function() onDismissed;

  const JournalCard({
    super.key,
    required this.id,
    required this.content,
    required this.moodType,
    required this.createdAt,
    required this.onTap,
    required this.onDismissed,
    this.coverImg,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Roundness.card),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(Roundness.card),
          border: Border.all(color: colorScheme.surfaceContainerHighest),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.xxl,
            vertical: Spacing.md,
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Mood color indicator
                Container(
                  width: Spacing.sm,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Roundness.card),
                    color: Color(moodType.colorValue),
                  ),
                  ),
                const SizedBox(width: Spacing.lg),
                
                // Content section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        createdAt.formatted(t),
                        style: textTheme.bodyMedium?.copyWith(color: colorScheme.outline),
                      ),
                      const SizedBox(height: Spacing.xs),
                      Text(
                        content.trim(),
                        style: textTheme.bodyLarge,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (coverImg != null && coverImg!.isNotEmpty) ...[
                        const SizedBox(height: Spacing.md),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(Roundness.xs),
                          child: Image.file(
                            File(coverImg!),
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 120,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: colorScheme.surfaceContainerHighest,
                                  borderRadius: BorderRadius.circular(Roundness.xs),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image_not_supported_outlined,
                                      color: colorScheme.outline,
                                      size: 32,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Image not found',
                                      style: TextStyle(
                                        color: colorScheme.outline,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                
                // Arrow icon
                const Icon(Icons.keyboard_arrow_left),
              ],
            ),
          ),
        ),
      ),
    ).scale();
  }
}
