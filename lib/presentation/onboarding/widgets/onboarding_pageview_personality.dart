import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/common.dart';
import '../../../core/constants/enum.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/ui/widgets/fade_in.dart';
import '../onboarding_view_model.dart';
import 'onboarding_personality_item.dart';

class OnboardingPageViewPersonality extends StatelessWidget {
  final void Function() onNext;

  const OnboardingPageViewPersonality({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Spacing.xl,
        children: [
          FadeIn(
            child: Text(
              t.onboarding_personality_title,
              style: textTheme.displaySmall,
            ),
          ),
          FadeIn(
            delay: DelayMS.medium,
            child: Text(
              t.onboarding_personality_description,
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.secondary,
              ),
            ),
          ),
          FadeIn(
            delay: DelayMS.medium * 2,
            child: Builder(
              builder: (context) {
                final selectedPersonality = context.select(
                  (OnboardingViewModel vm) => vm.selectedPersonality,
                );

                return RadioGroup<AiPersonality>(
                  groupValue: selectedPersonality,
                  onChanged: context.read<OnboardingViewModel>().setPersonality,
                  child: Column(
                    children: AiPersonality.values.map((personality) {
                      final isSelected = personality == selectedPersonality;

                      return PersonalityItem(
                        personality: personality,
                        isSelected: isSelected,
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
          FadeIn(
            delay: DelayMS.medium * 3,
            child: Text(
              t.onboarding_personality_hint,
              style: textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.secondary,
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
          FadeIn(
            delay: DelayMS.medium * 4,
            child: SafeArea(
              bottom: true,
              child: SizedBox(
                width: double.infinity,
                child: IconButton.filled(
                  onPressed: onNext,
                  icon: const Icon(Icons.arrow_forward),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
