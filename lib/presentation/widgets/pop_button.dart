import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PopButton extends StatelessWidget {
  final GestureTapCallback? onTap;

  const PopButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (onTap != null) {
          print('asdf');
          onTap!();
        } else {
          context.pop();
        }
      },
      icon: Icon(Icons.arrow_back),
    );
  }
}
