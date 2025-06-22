import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

enum EmojiSize { small, medium, large }

class ShakeEmoji extends StatefulWidget {
  final String emoji;
  final int duration;
  final EmojiSize size;

  const ShakeEmoji({
    super.key,
    required this.emoji,
    this.duration = 6000,
    this.size = EmojiSize.medium,
  });

  @override
  State<ShakeEmoji> createState() => _ShakeEmojiState();
}

class _ShakeEmojiState extends State<ShakeEmoji>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _angleAnimation;
  Timer? _stopTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..repeat(reverse: true);

    _angleAnimation = Tween<double>(begin: 0, end: pi / 3).animate(_controller);

    _stopTimer = Timer(Duration(milliseconds: widget.duration), () {
      _controller.stop();
      _controller.reset();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _stopTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _angleAnimation.value,
          child: Text(
            widget.emoji,
            style: TextStyle(
              fontSize: switch (widget.size) {
                EmojiSize.small => 20,
                EmojiSize.medium => 40,
                EmojiSize.large => 60,
              },
            ),
          ),
        );
      },
    );
  }
}
