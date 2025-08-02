import 'package:flutter/material.dart';

import '../../common/constants/common.dart';

class GradientBox extends StatelessWidget {
  final Widget child;

  const GradientBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: Spacing.md),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.onSurfaceVariant,
            Theme.of(context).colorScheme.onSurface,
          ],
          begin: const Alignment(-1.0, -0.8),
          end: const Alignment(0.8, 1.0),
          stops: const [0.0, 1.0],
        ),
      ),
      child: child,
    );
  }
}
