import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/constants/enum.dart';
import '../../../core/extensions/enum.dart';
import '../../../core/extensions/widget.dart';
import '../write_viewmodel.dart';

class MoodButton extends StatelessWidget {
  final MoodType mood;
  final int index;
  final Function nextPage;

  const MoodButton({
    super.key,
    required this.mood,
    required this.index,
    required this.nextPage,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Consumer<WriteViewModel>(
      builder: (context, viewModel, _) {
        final isSelected = viewModel.selectedMood == mood;

        return ElevatedButton(
          onPressed: () async {
            viewModel.updateMoodType(mood);
            Future.delayed(DurationMS.instant, () => nextPage());
          },
          style: ButtonStyle(
            elevation: WidgetStateProperty.all(0),
            backgroundColor: WidgetStateProperty.all(
              isSelected
                  ? Color(mood.colorValue).withValues(alpha: 0.5)
                  : colorScheme.surfaceContainer,
            ),
            overlayColor: WidgetStateProperty.all(
              Color(mood.colorValue).withValues(alpha: 0.5),
            ),
            shadowColor: WidgetStateProperty.all(Color(mood.colorValue)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(mood.emoji, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: Spacing.sm),
              Text(mood.getDisplayName(context)),
            ],
          ),
        ).scale();
      },
    );
  }
}
