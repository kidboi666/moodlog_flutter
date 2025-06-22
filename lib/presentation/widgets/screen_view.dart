import 'package:flutter/material.dart';

import '../../core/constants/common.dart';

class ScreenView extends StatelessWidget {
  final Widget child;
  final bool scrollable;

  const ScreenView({super.key, required this.child, this.scrollable = false});

  const ScreenView.scrollable({
    super.key,
    required this.child,
    this.scrollable = true,
  });

  static const EdgeInsets _defaultPadding = EdgeInsets.fromLTRB(
    Layout.paddingHorizontal,
    Layout.paddingVertical,
    Layout.paddingHorizontal,
    0,
  );

  @override
  Widget build(BuildContext context) {
    Widget content = child;
    if (scrollable) {
      content = SingleChildScrollView(child: child);
    }
    return SafeArea(
      child: Container(padding: _defaultPadding, child: content),
    );
  }
}
