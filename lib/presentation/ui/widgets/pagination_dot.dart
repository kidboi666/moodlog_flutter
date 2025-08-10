import 'package:flutter/material.dart';

class PaginationDot extends StatelessWidget {
  final int current;
  final int total;

  const PaginationDot({super.key, required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        total,
        (index) => AnimatedContainer(
          margin: const EdgeInsets.symmetric(horizontal: 2.0),
          width: 8,
          height: 8,
          duration: const Duration(milliseconds: 400),
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
