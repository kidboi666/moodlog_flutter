import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(left: Spacing.xl),
      child: Text(
        title,
        style: textTheme.titleMedium?.copyWith(color: colorTheme.primary),
      ),
    );
  }
}
