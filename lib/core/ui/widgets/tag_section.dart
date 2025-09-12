import 'package:flutter/material.dart';

import '../../../core/ui/widgets/tag_chip.dart';
import '../../constants/common.dart';
import '../../constants/enum.dart';

class TagSection extends StatelessWidget {
  final List<String> tagNames;
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
    required this.tagNames,
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
    if (tagNames.isEmpty) return const SizedBox.shrink();

    final displayTags = maxTags != null
        ? tagNames.take(maxTags!).toList()
        : tagNames;

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
          children: displayTags.map((tagName) {
            return TagChip(
              tagName: tagName,
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
