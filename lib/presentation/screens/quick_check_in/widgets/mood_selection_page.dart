import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/quick_check_in/quick_check_in_view_model.dart';
import 'package:moodlog/presentation/widgets/fade_in.dart';
import 'package:moodlog/presentation/widgets/mood_slider_widget.dart';
import 'package:provider/provider.dart';

class MoodSelectionPage extends StatelessWidget {
  final void Function() onNext;

  const MoodSelectionPage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final selectedMood = context.select(
      (QuickCheckInViewModel vm) => vm.selectedMood,
    );

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonSizedBox.heightXl,
          FadeIn(
            delay: DelayMS.medium,
            child: Text(
              t.quick_check_in_mood_question,
              style: textTheme.headlineSmall,
            ),
          ),
          Expanded(
            child: FadeIn(
              delay: DelayMS.medium * 2,
              child: MoodSliderWidget(
                selectedMood: selectedMood,
                onMoodChanged: (mood) {
                  context.read<QuickCheckInViewModel>().selectMood(mood);
                },
                expandContent: true,
              ),
            ),
          ),
          CommonSizedBox.heightXl,
          FadeIn(
            delay: DelayMS.medium * 5,
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onNext,
                child: Text(
                  t.quick_check_in_next,
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          CommonSizedBox.heightMd,
        ],
      ),
    );
  }
}
