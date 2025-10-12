import 'package:flutter/material.dart';

class KeyboardUtils {
  static void dismissKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild!.unfocus();
    }
    FocusScope.of(context).unfocus();
  }
}

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
