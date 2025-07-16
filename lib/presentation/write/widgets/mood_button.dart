import 'package:flutter/material.dart';
import 'package:moodlog/core/extensions/enum.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/constants/enum.dart';
import '../viewmodel/write_viewmodel.dart';

class MoodButton extends StatelessWidget {
  final MoodType mood;
  final int index;

  const MoodButton({super.key, required this.mood, required this.index});

  @override
  Widget build(BuildContext context) {
    return Selector<WriteViewModel, MoodType?>(
      selector: (context, viewModel) => viewModel.selectedMood,
      builder: (context, selectedMood, child) {
        final isSelected = selectedMood == mood;

        return ElevatedButton(
          onPressed: () => context.read<WriteViewModel>().updateMoodType(mood),
          style: ButtonStyle(
            elevation: WidgetStateProperty.all(0),
            backgroundColor: WidgetStateProperty.all(
              isSelected
                  ? Color(mood.colorValue).withValues(alpha: 0.5)
                  : Theme.of(context).colorScheme.surfaceContainer,
            ),
            overlayColor: WidgetStateProperty.all(
              Color(mood.colorValue).withValues(alpha: 0.5),
            ),
            shadowColor: WidgetStateProperty.all(Color(mood.colorValue)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(mood.emoji, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: Spacing.sm),
              Text(mood.getDisplayName(context)),
            ],
          ),
        );
      },
    );
  }
}
