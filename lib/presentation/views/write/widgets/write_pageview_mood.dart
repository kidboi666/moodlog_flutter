import 'package:flutter/material.dart';

import '../../../../core/constants/common.dart';
import '../../../../core/constants/enum.dart';
import '../../../view_models/write/write_viewmodel.dart';

class WritePageViewMood extends StatelessWidget {
  final WriteViewModel viewModel;

  const WritePageViewMood({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Spacing.containerHorizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 28,
        children: [
          Text(
            '오늘 기분은 어떠신가요?',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListenableBuilder(
                listenable: viewModel,
                builder: (context, _) {
                  return Column(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: MoodType.values.map((mood) {
                      final isSelected = viewModel.selectedMood == mood;

                      return ElevatedButton(
                        onPressed: () => viewModel.updateMoodType(mood),
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            isSelected
                                ? Color(mood.colorValue).withValues(alpha: 0.3)
                                : null,
                          ),
                          overlayColor: WidgetStateProperty.all(
                            Color(mood.colorValue).withValues(alpha: 0.5),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              mood.emoji,
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(width: 8),
                            Text(mood.name),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
