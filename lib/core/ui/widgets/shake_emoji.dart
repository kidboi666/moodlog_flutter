import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../constants/enum.dart';

class ShakeEmoji extends StatefulWidget {
  final Emoji emoji;
  final int? duration;
  final double size;
  final int repeatCount;

  const ShakeEmoji({
    super.key,
    required this.emoji,
    this.duration,
    this.size = 40,
    this.repeatCount = 3,
  });

  @override
  State<ShakeEmoji> createState() => _ShakeEmojiState();
}

class _ShakeEmojiState extends State<ShakeEmoji>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _angleAnimation;
  Timer? _stopTimer;
  int _currentRepeatCount = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _angleAnimation = Tween<double>(begin: 0, end: pi / 6).animate(_controller);

    _controller.addStatusListener(_onAnimationStatus);
    _controller.forward();

    if (widget.duration != null) {
      _stopTimer = Timer(Duration(milliseconds: widget.duration!), () {
        _controller.stop();
        _controller.reset();
      });
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
    _controller.removeStatusListener(_onAnimationStatus);
    _controller.dispose();
    _stopTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: Text(
        widget.emoji.displayEmoji,
        style: TextStyle(fontSize: widget.size),
      ),
      builder: (context, child) {
        return Transform.rotate(angle: _angleAnimation.value, child: child);
      },
    );
  }
}
