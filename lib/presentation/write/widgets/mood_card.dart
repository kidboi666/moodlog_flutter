import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/constants/enum.dart';
import '../../../core/extensions/enum.dart';
import '../viewmodel/write_viewmodel.dart';

class MoodCard extends StatelessWidget {
  final void Function() onTap;
  const MoodCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final selectedMood = context.select<WriteViewModel, MoodType>(
      (vm) => vm.selectedMood,
    );
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(foregroundColor: selectedMood.color),
      child: Row(
        spacing: Spacing.sm,
        children: [
          Text(selectedMood.emoji, style: textTheme.titleLarge),
          Text(selectedMood.getDisplayName(context)),
        ],
      ),
    );
  }
}
