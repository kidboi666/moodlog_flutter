import 'package:flutter/material.dart';
import 'package:moodlog/common/constants/common.dart';
import 'package:moodlog/common/extensions/enum.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/enum.dart';
import '../viewmodel/write_viewmodel.dart';

class MoodCard extends StatefulWidget {
  final void Function() onTap;
  const MoodCard({super.key, required this.onTap});

  @override
  State<MoodCard> createState() => _MoodCardState();
}

class _MoodCardState extends State<MoodCard> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Builder(
      builder: (context) {
        final selectedMood = context.select<WriteViewModel, MoodType>(
          (vm) => vm.selectedMood,
        );
        return TextButton(
          onPressed: () => widget.onTap(),
          style: TextButton.styleFrom(foregroundColor: selectedMood.color),
          child: Row(
            spacing: Spacing.sm,
            children: [
              Text(selectedMood.emoji, style: textTheme.titleLarge),
              Text(selectedMood.getDisplayName(context)),
            ],
          ),
        );
      },
    );
  }
}
