import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';

class GradientBox extends StatelessWidget {
  final Widget child;
  final Color? firstColor;
  final Color? secondColor;

  const GradientBox({
    super.key,
    required this.child,
    this.firstColor,
    this.secondColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: Spacing.md),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            firstColor ?? Theme.of(context).colorScheme.secondary,
            secondColor ?? Theme.of(context).colorScheme.onSecondaryContainer,
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
