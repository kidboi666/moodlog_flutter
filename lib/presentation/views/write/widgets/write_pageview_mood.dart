import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:moodlog/core/extensions/enum.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/widgets/fade_in.dart';

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
        spacing: Spacing.xxl,
        children: [
          FadeIn(
            delay: DelayMs.quick,
            child: Text(
              AppLocalizations.of(context)!.write_mood_title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListenableBuilder(
                listenable: viewModel,
                builder: (context, _) {
                  return Column(
                    spacing: Spacing.lg,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: MoodType.values.mapIndexed((index, mood) {
                      final isSelected = viewModel.selectedMood == mood;

                      return FadeIn(
                        delay: DelayMs.quick * index + DelayMs.quick,
                        duration: DurationMs.lazy,
                        child: ElevatedButton(
                          onPressed: () => viewModel.updateMoodType(mood),
                          style: ButtonStyle(
                            elevation: WidgetStateProperty.all(0),
                            backgroundColor: WidgetStateProperty.all(
                              isSelected
                                  ? Color(
                                      mood.colorValue,
                                    ).withValues(alpha: 0.5)
                                  : Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainer,
                            ),
                            overlayColor: WidgetStateProperty.all(
                              Color(mood.colorValue).withValues(alpha: 0.5),
                            ),
                            shadowColor: WidgetStateProperty.all(
                              Color(mood.colorValue),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                mood.emoji,
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(width: Spacing.sm),
                              Text(mood.getDisplayName(context)),
                            ],
                          ),
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
