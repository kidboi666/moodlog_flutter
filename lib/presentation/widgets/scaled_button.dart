import 'package:flutter/material.dart';

class ScaledElevatedButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;
  final Duration duration;
  final double scaleFactor;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;

  // ElevatedButton의 다른 생성자 파라미터들도 필요에 따라 추가할 수 있습니다.

  const ScaledElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.style,
    this.duration = const Duration(milliseconds: 100),
    this.scaleFactor = 0.95,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
  });

  @override
  State<ScaledElevatedButton> createState() => _ScaledElevatedButtonState();
}

class _ScaledElevatedButtonState extends State<ScaledElevatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scaleFactor,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown() {
    if (widget.onPressed != null) {
      // onPressed가 null이 아닐 때만 애니메이션 실행
      _controller.forward();
    }
  }

  void _handleTapUp() {
    if (widget.onPressed != null) {
      Future.delayed(const Duration(milliseconds: 50), () {
        // 탭업 후 약간의 딜레이를 주어 애니메이션이 보이도록 함
        if (mounted) {
          _controller.reverse().then((_) {
            // 애니메이션 복원 후 onPressed 실행 (선택적)
            // widget.onPressed?.call(); // 여기서 호출하거나 GestureDetector의 onTap에서 호출
          });
        }
      });
    }
  }

  void _handleTapCancel() {
    if (widget.onPressed != null && mounted) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _handleTapDown(),
      onTapUp: (_) {
        _handleTapUp();
        // onPressed는 여기서 호출하는 것이 일반적입니다.
        // 애니메이션이 시작된 후 또는 완료된 후 호출할지 결정할 수 있습니다.
        if (widget.onPressed != null) {
          widget.onPressed!();
        }
      },
      onTapCancel: () => _handleTapCancel(),
      behavior: HitTestBehavior.opaque,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style:
              widget.style?.copyWith(splashFactory: NoSplash.splashFactory) ??
              ButtonStyle(splashFactory: NoSplash.splashFactory),
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          clipBehavior: widget.clipBehavior,
          child: widget.child,
        ),
      ),
    );
  }
}
