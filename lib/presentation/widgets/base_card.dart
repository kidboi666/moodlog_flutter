import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';

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
    final effectiveTitleColor =
        titleColor ?? Theme.of(context).colorScheme.primary;
    final effectiveIconColor =
        iconColor ?? Theme.of(context).colorScheme.primary;
    final effectiveBackgroundColor =
        backgroundColor ?? Theme.of(context).colorScheme.surfaceContainer;
    final effectivePadding = padding ?? CommonPadding.lg;

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
                  CommonSizedBox.widthSm,
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: effectiveTitleColor,
                      ),
                    ),
                  ),
                ],
              ),
              CommonSizedBox.heightLg,
            ],
            child,
          ],
        ),
      ),
    );
  }
}
