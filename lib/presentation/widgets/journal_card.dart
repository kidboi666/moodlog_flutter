import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/extensions/date_time.dart';
import 'package:moodlog/core/extensions/widget.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/domain/entities/journal/tag.dart';
import 'package:moodlog/presentation/widgets/tag_chip.dart';

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
  final bool isCompact;

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
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    debugPrint(tags?[0].name);
    final double horizontalPadding = isCompact ? Spacing.lg : Spacing.xl;
    final double verticalPadding = isCompact ? Spacing.lg : Spacing.xl;
    final double imageHeight = isCompact ? 80 : 120;
    final TextStyle? titleStyle = isCompact
        ? TextTheme.of(context).bodySmall
        : TextTheme.of(context).bodyMedium;
    final TextStyle? contentStyle = isCompact
        ? TextTheme.of(context).bodySmall
        : TextTheme.of(context).bodyMedium;

    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(Roundness.card),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: ColorScheme.of(context).surfaceContainer,
          borderRadius: BorderRadius.circular(Roundness.card),
          border: isSelected
              ? Border.all(color: ColorScheme.of(context).primary, width: 2)
              : null,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: verticalPadding,
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
                                style: titleStyle?.copyWith(
                                  color: ColorScheme.of(context).outline,
                                ),
                              ),
                              const SizedBox(height: Spacing.xs),
                              _buildContentPreview(
                                content.trim(),
                                contentStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (tags != null && tags!.isNotEmpty) ...[
                  Padding(
                    padding: EdgeInsets.only(
                      left: horizontalPadding,
                      right: horizontalPadding,
                      bottom: Spacing.lg,
                    ),
                    child: _buildTags(context, tags!),
                  ),
                ],
                if (coverImg != null && coverImg!.isNotEmpty) ...[
                  _buildCoverImage(context, imageHeight),
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
      children: tags
          .map((tag) => TagChip(tag: tag, isCompact: isCompact))
          .toList(),
    );
  }

  Widget _buildCoverImage(BuildContext context, double height) {
    final colorScheme = Theme.of(context).colorScheme;

    return Image.file(
      File(coverImg!),
      height: height,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: height,
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
                size: isCompact ? 24 : 32,
              ),
              const SizedBox(height: 4),
              Text(
                'Image not found',
                style: TextStyle(
                  color: colorScheme.outline,
                  fontSize: isCompact ? 10 : 12,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContentPreview(String content, TextStyle? style) {
    if (content.isEmpty) {
      return const SizedBox.shrink();
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 0,
        maxHeight: isCompact ? 60 : 100, // 카드에서는 높이 제한
      ),
      child: Text(
        content,
        maxLines: isCompact ? 3 : 5,
        overflow: TextOverflow.ellipsis,
        style: style,
      ),
    );
  }
}
