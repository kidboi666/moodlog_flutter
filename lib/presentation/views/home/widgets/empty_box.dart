import 'package:flutter/material.dart';

class EmptyBox extends StatelessWidget {
  const EmptyBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Theme.of(context).colorScheme.surfaceBright,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Column(
          spacing: 28,
          children: [
            Text(
              // TODO: Localization
              '당신의 이야기를 기다리고 있어요.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            FloatingActionButton(
              // TODO: Add onPressed
              onPressed: () {},
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              elevation: 2.0,
              mini: true,
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
