import 'package:flutter/material.dart';

import '../../constants/common.dart';

class BaseCard extends StatelessWidget {
  final Widget child;
  final String title;
  final IconData icon;
  final Color? titleColor;
  final Color? iconColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final bool showHeader;

  const BaseCard({
    super.key,
    required this.child,
    required this.title,
    required this.icon,
    this.titleColor,
    this.iconColor,
    this.backgroundColor,
    this.padding,
    this.showHeader = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final effectiveTitleColor = titleColor ?? colorScheme.primary;
    final effectiveIconColor = iconColor ?? colorScheme.primary;
    final effectiveBackgroundColor =
        backgroundColor ?? colorScheme.surfaceContainer;
    final effectivePadding = padding ?? const EdgeInsets.all(Spacing.lg);

    return Container(
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(Roundness.card),
      ),
      child: Padding(
        padding: effectivePadding,
        child: Column(
          children: [
            if (showHeader) ...[
              Row(
                children: [
                  Icon(icon, color: effectiveIconColor, size: 20),
                  const SizedBox(width: Spacing.sm),
                  Expanded(
                    child: Text(
                      title,
                      style: textTheme.titleMedium?.copyWith(
                        color: effectiveTitleColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Spacing.lg),
            ],
            child,
          ],
        ),
      ),
    );
  }
}
