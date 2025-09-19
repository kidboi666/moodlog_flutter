import 'package:flutter/material.dart';
import 'package:moodlog/core/ui/widgets/apple_logo_painter.dart';

import '../../../core/constants/common.dart';

class AppleAccountCard extends StatelessWidget {
  final String email;

  const AppleAccountCard({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        FixedSizeAppleLogo(color: colorScheme.primary),
        const SizedBox(width: Spacing.md),
        Text(email, style: textTheme.bodySmall),
      ],
    );
  }
}
