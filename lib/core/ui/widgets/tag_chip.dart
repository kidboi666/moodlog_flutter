import 'package:flutter/material.dart';

import '../../constants/common.dart';

class TagChip extends StatelessWidget {
  final String tagName;
  final double? fontSize;
  final EdgeInsets? padding;
  final double? borderRadius;

  const TagChip({
    super.key,
    required this.tagName,
    this.fontSize,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding:
          padding ??
          const EdgeInsets.symmetric(
            horizontal: Spacing.sm,
            vertical: Spacing.xs,
          ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(borderRadius ?? 16),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
      ),
      child: Text(
        tagName,
        style: textTheme.bodySmall?.copyWith(
          fontSize: fontSize,
          color: colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
