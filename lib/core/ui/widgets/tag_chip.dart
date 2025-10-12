import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/domain/entities/journal/tag.dart';

class TagChip extends StatelessWidget {
  final Tag tag;
  final double? fontSize;
  final EdgeInsets? padding;
  final double? borderRadius;

  const TagChip({
    super.key,
    required this.tag,
    this.fontSize,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(tag.name, style: TextStyle(fontSize: fontSize)),
      padding: padding ?? EdgeInsets.zero,
      labelPadding: const EdgeInsets.symmetric(horizontal: Spacing.md),
      visualDensity: VisualDensity.compact,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 16.0),
      ),
    );
  }
}
