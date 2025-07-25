import 'package:flutter/material.dart';

import '../../core/constants/common.dart';

class ScaleWrapper extends StatefulWidget {
  final Widget child;
  final double scaleValue;
  final Duration duration;
  final Curve curve;

  const ScaleWrapper({
    super.key,
    required this.child,
    this.scaleValue = 0.95,
    this.duration = DurationMs.instant,
    this.curve = Curves.easeInOut,
  });

  @override
  State<ScaleWrapper> createState() => _ScaleWrapperState();
}

class _ScaleWrapperState extends State<ScaleWrapper> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => setState(() => _isPressed = true),
      onPointerUp: (_) => setState(() => _isPressed = false),
      onPointerCancel: (_) => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? widget.scaleValue : 1.0,
        duration: widget.duration,
        curve: widget.curve,
        child: widget.child,
      ),
    );
  }
}
