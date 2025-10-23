import 'package:flutter/material.dart';
import 'package:moodlog/core/utils/keyboard_utils.dart';

class KeyboardDismissOnTapOutside extends StatelessWidget {
  final Widget child;

  const KeyboardDismissOnTapOutside({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => KeyboardUtils.dismissKeyboard(context),
      child: child,
    );
  }
}
