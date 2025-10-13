import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/domain/entities/journal/tag.dart';
import 'package:moodlog/presentation/widgets/tag_chip.dart';

class TagSection extends StatelessWidget {
  final List<Tag> tags;
  final String? title;
  final SimpleTextAlign? textAlign;
  final int? maxTags;
  final double? spacing;
  final double? runSpacing;
  final bool isCompact;

  const TagSection({
    super.key,
    required this.tags,
    this.title,
    this.textAlign,
    this.maxTags,
    this.spacing,
    this.runSpacing,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) return const SizedBox.shrink();

    final displayTags = maxTags != null ? tags.take(maxTags!).toList() : tags;

    return Column(
      crossAxisAlignment:
          textAlign?.crossAxisAlignment ?? CrossAxisAlignment.start,
      children: [
        Wrap(
          alignment: _getWrapAlignment(
            textAlign?.crossAxisAlignment ?? CrossAxisAlignment.start,
          ),
          spacing: spacing ?? Spacing.sm,
          runSpacing: runSpacing ?? Spacing.sm,
          children: displayTags.map((tag) {
            return TagChip(tag: tag, isCompact: isCompact);
          }).toList(),
        ),
      ],
    );
  }

  WrapAlignment _getWrapAlignment(CrossAxisAlignment crossAlignment) {
    switch (crossAlignment) {
      case CrossAxisAlignment.start:
        return WrapAlignment.start;
      case CrossAxisAlignment.center:
        return WrapAlignment.center;
      case CrossAxisAlignment.end:
        return WrapAlignment.end;
      default:
        return WrapAlignment.start;
    }
  }
}
