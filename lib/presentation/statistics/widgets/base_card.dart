import 'package:flutter/material.dart';

import '../../../common/constants/common.dart';

class BaseCard extends StatelessWidget {
  final Widget child;

  const BaseCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(Roundness.card),
        border: Border.all(color: colorScheme.surfaceContainerHighest),
      ),
      child: Padding(padding: EdgeInsets.all(Spacing.lg), child: child),
    );
  }
}
