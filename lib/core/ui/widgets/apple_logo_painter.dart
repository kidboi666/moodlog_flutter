import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class FixedSizeAppleLogo extends StatelessWidget {
  final Color? color;

  const FixedSizeAppleLogo({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return CustomPaint(
      painter: AppleLogoPainter(
        color: color != null ? color! : colorScheme.onPrimary,
      ),
      size: const Size(20, 24),
    );
  }
}
