import 'package:flutter/material.dart';

import 'hello.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Hello(key: const ValueKey('hello'));
  }
}
