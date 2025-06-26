import 'package:flutter/material.dart';

class GradientBox extends StatelessWidget {
  final Widget child;

  const GradientBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.onSurface,
            theme.colorScheme.onSurfaceVariant,
          ],
          begin: const Alignment(-1.0, -0.8),
          end: const Alignment(0.8, 1.0),
          stops: const [0.0, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.onSurfaceVariant,
              theme.colorScheme.onSurface,
            ],
            begin: const Alignment(-1.0, -0.8),
            end: const Alignment(0.8, 1.0),
            stops: const [0.0, 1.0],
          ),
        ),
        child: child,
      ),
    );
  }
}
