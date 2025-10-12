import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moodlog/core/ui/widgets/tag_chip.dart';
import 'package:moodlog/domain/entities/journal/tag.dart';

import '../../constants/common.dart';
import '../../constants/enum.dart';
import '../../extensions/date_time.dart';
import '../../extensions/widget.dart';
import '../../l10n/app_localizations.dart';

class JournalCard extends StatelessWidget {
  final int id;
  final String content;
  final MoodType moodType;
  final String? coverImg;
  final DateTime createdAt;
  final void Function() onTap;
  final void Function()? onLongPress;
  final bool isSelectable;
  final bool isSelected;
  final List<Tag>? tags;

  const JournalCard({
    super.key,
    required this.id,
    required this.content,
    required this.moodType,
    required this.createdAt,
    required this.onTap,
    this.onLongPress,
    this.coverImg,
    this.isSelectable = false,
    this.isSelected = false,
    this.tags,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.xl,
                    vertical: Spacing.xl,
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
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.outline,
                                ),
                              ),
                              const SizedBox(height: Spacing.xs),
                              _buildContentPreview(content.trim(), textTheme),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (tags != null && tags!.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: Spacing.xl,
                      right: Spacing.xl,
                      bottom: Spacing.lg,
                    ),
                    child: _buildTags(context, tags!),
                  ),
                ],
                if (coverImg != null && coverImg!.isNotEmpty) ...[
                  _buildCoverImage(context),
                ],
              ],
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

  Widget _buildTags(BuildContext context, List<Tag> tags) {
    return Wrap(
      spacing: Spacing.sm,
      runSpacing: Spacing.sm,
      children: tags.map((tag) => TagChip(tag: tag)).toList(),
    );
  }

  Widget _buildCoverImage(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Image.file(
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
                style: TextStyle(color: colorScheme.outline, fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContentPreview(String content, TextTheme textTheme) {
    if (content.isEmpty) {
      return const SizedBox.shrink();
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 0,
        maxHeight: 100, // 카드에서는 높이 제한
      ),
      child: Text(
        content,
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyMedium,
      ),
    );
  }
}
