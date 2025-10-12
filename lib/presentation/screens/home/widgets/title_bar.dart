import 'package:flutter/material.dart';
import 'package:moodlog/presentation/screens/home/widgets/hello.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Hello(key: const ValueKey('hello'));
  }
}
