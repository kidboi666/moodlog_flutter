import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';

class StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const StatItem({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Icon(icon, size: 32, color: colorScheme.primary),
        const SizedBox(height: Spacing.sm),
        Text(
          value,
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(label, style: textTheme.bodyMedium),
      ],
    );
  }
}
