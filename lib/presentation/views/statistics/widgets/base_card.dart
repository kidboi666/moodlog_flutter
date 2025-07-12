import 'package:flutter/material.dart';

import '../../../../core/constants/common.dart';

class BaseCard extends StatelessWidget {
  final Widget child;

  const BaseCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(padding: EdgeInsets.all(Spacing.lg), child: child),
    );
  }
}
