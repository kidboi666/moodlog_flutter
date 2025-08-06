import 'package:flutter/material.dart';

import '../../../common/constants/common.dart';

class BaseCard extends StatelessWidget {
  final Widget child;

  const BaseCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surface,
      child: Padding(padding: EdgeInsets.all(Spacing.lg), child: child),
    );
  }
}
