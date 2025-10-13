import 'package:flutter/material.dart';

class Glower extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;

  const Glower({super.key, required this.child, this.appBar});

  @override
  Widget build(BuildContext context) {
    return GlowingOverscrollIndicator(
      axisDirection: AxisDirection.down,
      color: Theme.of(context).colorScheme.secondary,
      child: child,
    );
  }
}
