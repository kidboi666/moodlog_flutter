import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';

class PaginationDot extends StatelessWidget {
  final int current;
  final int total;

  const PaginationDot({super.key, required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: Spacing.xs,
      children: List.generate(
        total,
        (index) => AnimatedContainer(
          width: 8,
          height: 8,
          duration: DurationMS.quick,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: index == current
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.surfaceContainer,
          ),
        ),
      ),
    );
  }
}
