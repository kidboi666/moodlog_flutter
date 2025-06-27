import 'package:flutter/cupertino.dart';

import '../../core/constants/common.dart';

class FadeIn extends StatefulWidget {
  final Duration delay;
  final Duration duration;
  final Widget child;

  const FadeIn({
    super.key,
    this.delay = const Duration(milliseconds: DelayMs.instant),
    this.duration = const Duration(milliseconds: DurationMs.lazy),
    required this.child,
  });

  @override
  State<FadeIn> createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);
    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo));
    _scale = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo));
    widget.delay > Duration.zero
        ? Future.delayed(widget.delay, () {
            if (mounted) _controller.forward();
          })
        : _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: FadeTransition(opacity: _opacity, child: widget.child),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
