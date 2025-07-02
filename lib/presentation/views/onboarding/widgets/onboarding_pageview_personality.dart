import 'package:flutter/material.dart';

import '../../../../core/constants/common.dart';
import '../../../../core/constants/enum.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../view_models/onboarding/onboarding_viewmodel.dart';
import '../../../widgets/fade_in.dart';
import 'onboarding_personality_item.dart';

class OnboardingPageViewPersonality extends StatelessWidget {
  final OnboardingViewModel viewModel;
  final void Function() onNext;

  const OnboardingPageViewPersonality({
    super.key,
    required this.viewModel,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 40,
      children: [
        FadeIn(
          child: Text(
            AppLocalizations.of(context)!.onboarding_personality_title,
            style: Theme.of(
              context,
            ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        FadeIn(
          delay: DelayMs.lazy,
          child: Text(
            AppLocalizations.of(context)!.onboarding_personality_description,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) => Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: FadeIn(
                    delay: DelayMs.lazy * 2,
                    child: Column(
                      children: AiPersonality.values.map((personality) {
                        final isSelected =
                            personality == viewModel.selectedPersonality;

                        return PersonalityItem(
                          personality: personality,
                          isSelected: isSelected,
                          selectedPersonality: viewModel.selectedPersonality,
                          onPersonalityChanged: viewModel.setPersonality,
                        );
                      }).toList(),
                    ),
                  ),
                ),
                FadeIn(
                  delay: DelayMs.lazy * 3,
                  child: SizedBox(
                    width: double.infinity,
                    child: IconButton.filled(
                      onPressed: onNext,
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
