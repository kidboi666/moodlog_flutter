import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/enum.dart';

class Spinner extends StatelessWidget {
  final SpinnerType spinnerType;
  final double size;
  final double strokeWidth;

  const Spinner({
    super.key,
    this.spinnerType = SpinnerType.button,
    this.size = 20,
    this.strokeWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    switch (spinnerType) {
      case SpinnerType.button:
        return _CircularProgressIndicator(size: size, strokeWidth: strokeWidth);
      case SpinnerType.center:
        return Center(
          child: _CircularProgressIndicator(
            size: size,
            strokeWidth: strokeWidth,
          ),
        );
      case SpinnerType.expanded:
        return Expanded(
          child: _CircularProgressIndicator(
            size: size,
            strokeWidth: strokeWidth,
          ),
        );
    }
  }
}

class _CircularProgressIndicator extends StatelessWidget {
  final double size;
  final double strokeWidth;

  const _CircularProgressIndicator({
    required this.size,
    required this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        padding: EdgeInsets.all(strokeWidth),
      ),
    );
  }
}
