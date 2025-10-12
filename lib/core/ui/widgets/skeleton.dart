import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  final double height;
  final double width;

  const Skeleton({super.key, this.height = 50, this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      highlightColor: Theme.of(context).colorScheme.surfaceContainer,
      child: Container(
        height: height,
        width: width,
        color: Theme.of(context).colorScheme.surface,
      ),
    );
  }
}
