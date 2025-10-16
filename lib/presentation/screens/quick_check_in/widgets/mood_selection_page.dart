import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/extensions/localization.dart';
import 'package:moodlog/core/extensions/widget.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/quick_check_in/quick_check_in_view_model.dart';
import 'package:moodlog/presentation/widgets/fade_in.dart';
import 'package:provider/provider.dart';

class MoodSelectionPage extends StatelessWidget {
  final void Function() onNext;

  const MoodSelectionPage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final t = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: Spacing.xl * 2),
          FadeIn(
            child: Text(
              t.quick_check_in_mood_question,
              style: textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: Spacing.xl * 2),
          Expanded(
            child: ListView.separated(
              itemCount: MoodType.values.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: Spacing.md),
              itemBuilder: (context, index) {
                final mood = MoodType.values[index];
                return FadeIn(
                  delay: DelayMS.medium * index,
                  child: _MoodButton(
                    mood: mood,
                    onNext: onNext,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MoodButton extends StatelessWidget {
  final MoodType mood;
  final void Function() onNext;

  const _MoodButton({
    required this.mood,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final selectedMood = context.select(
      (QuickCheckInViewModel vm) => vm.selectedMood,
    );
    final isSelected = selectedMood == mood;

    return ElevatedButton(
      onPressed: () async {
        context.read<QuickCheckInViewModel>().selectMood(mood);
        Future.delayed(DurationMS.instant, () => onNext());
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
  }
}
