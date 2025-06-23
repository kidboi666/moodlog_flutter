import 'package:flutter/material.dart';

class JournalScreen extends StatelessWidget {
  final String? id;

  const JournalScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Column(children: [TextField(), Text('어쩌라고')]));
  }
}
