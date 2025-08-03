import 'package:flutter/material.dart';

import '../../common/constants/common.dart';
import '../../common/constants/enum.dart';
import '../../domain/entities/tag.dart';
import 'tag_chip.dart';

class TagSection extends StatelessWidget {
  final List<Tag> tags;
  final String? title;
  final SimpleTextAlign? textAlign;
  final int? maxTags;
  final double? spacing;
  final double? runSpacing;
  final double? chipFontSize;
  final EdgeInsets? chipPadding;
  final double? chipBorderRadius;

  const TagSection({
    super.key,
    required this.tags,
    this.title,
    this.textAlign,
    this.maxTags,
    this.spacing,
    this.runSpacing,
    this.chipFontSize,
    this.chipPadding,
    this.chipBorderRadius,
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
            return TagChip(
              tag: tag,
              fontSize: chipFontSize,
              padding: chipPadding,
              borderRadius: chipBorderRadius,
            );
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
