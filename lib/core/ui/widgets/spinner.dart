import 'package:flutter/material.dart';

import '../../constants/enum.dart';

class Spinner extends StatelessWidget {
  final SpinnerType spinnerType;

  const Spinner({super.key, this.spinnerType = SpinnerType.button});

  @override
  Widget build(BuildContext context) {
    switch (spinnerType) {
      case SpinnerType.button:
        return const _CircularProgressIndicator(size: 20);
      case SpinnerType.screen:
        return const Center(child: _CircularProgressIndicator(size: 40));
      case SpinnerType.element:
        return const _CircularProgressIndicator(size: 30);
    }
  }
}

class _CircularProgressIndicator extends StatelessWidget {
  final double size;

  const _CircularProgressIndicator({required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: const CircularProgressIndicator(strokeWidth: 2),
    );
  }
}
