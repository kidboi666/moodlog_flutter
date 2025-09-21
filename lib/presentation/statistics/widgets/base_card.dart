import 'package:flutter/material.dart';

import '../../../core/constants/common.dart';

class BaseCard extends StatelessWidget {
  final Widget child;
  final String title;
  final IconData icon;

  const BaseCard({
    super.key,
    required this.child,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(Roundness.card),
      ),
      child: Padding(
        padding: EdgeInsets.all(Spacing.lg),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, color: colorScheme.primary, size: 20),
                const SizedBox(width: Spacing.sm),
                Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: Spacing.lg),
            child,
          ],
        ),
      ),
    );
  }
}
