import 'package:flutter/material.dart';

enum WavingHandAnimationType {
  shake, // Shakes a few times
  wave, // Waves continuously
}

class WavingHand extends StatefulWidget {
  final String emoji;
  final double size;
  final WavingHandAnimationType animationType;
  final Duration duration;
  final int repeatCount; // Only for shake type

  const WavingHand({
    super.key,
    this.emoji = '👋',
    this.size = 24,
    this.animationType = WavingHandAnimationType.wave,
    this.duration = const Duration(milliseconds: 800),
    this.repeatCount = 3,
  });

  @override
  State<WavingHand> createState() => _WavingHandState();
}

class _WavingHandState extends State<WavingHand>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  int _currentRepeatCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    switch (widget.animationType) {
      case WavingHandAnimationType.wave:
        _controller.repeat(reverse: true);
        break;
      case WavingHandAnimationType.shake:
        _controller.addStatusListener(_onAnimationStatus);
        _controller.forward();
        break;
    }
  }

  void _onAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _currentRepeatCount++;
      if (_currentRepeatCount < widget.repeatCount) {
        _controller.reverse();
      }
    } else if (status == AnimationStatus.dismissed &&
        _currentRepeatCount < widget.repeatCount) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    if (widget.animationType == WavingHandAnimationType.shake) {
      _controller.removeStatusListener(_onAnimationStatus);
    }
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween<double>(
        begin: -0.1,
        end: 0.15,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
      child: Text(widget.emoji, style: TextStyle(fontSize: widget.size)),
    );
  }
}
