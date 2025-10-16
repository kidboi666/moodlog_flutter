import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/write/write_view_model.dart';
import 'package:moodlog/presentation/widgets/mood_slider_widget.dart';

class MoodSliderSelectionBottomSheet extends StatelessWidget {
  final WriteViewModel viewModel;

  const MoodSliderSelectionBottomSheet({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLowest,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.outline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              CommonSizedBox.heightMd,
              Text(t.write_mood_title, style: textTheme.headlineSmall),
              CommonSizedBox.heightXl,
              MoodSliderWidget(
                selectedMood: viewModel.selectedMood,
                onMoodChanged: viewModel.updateMoodType,
              ),
              CommonSizedBox.heightXl,
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => context.pop(viewModel.selectedMood),
                  child: Text(
                    t.common_confirm_ok,
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              CommonSizedBox.heightSm,
            ],
          ),
        );
      },
    );
  }
}
