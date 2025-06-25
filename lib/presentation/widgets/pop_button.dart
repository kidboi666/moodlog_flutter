import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PopButton extends StatelessWidget {
  final GestureTapCallback? onTap;

  const PopButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: () {
        if (onTap != null) {
          onTap!();
        } else {
          context.pop();
        }
      },
      child: Center(child: Icon(Icons.arrow_back)),
    );
  }
}
