import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/extensions/widget_scale.dart';

class PopButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final IconData? icon;

  const PopButton({super.key, this.onTap, this.icon = Icons.arrow_back});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            if (onTap != null) {
              onTap!();
            } else {
              context.pop();
            }
          },
          icon: Icon(icon),
        ).scale(),
      ],
    );
  }
}
