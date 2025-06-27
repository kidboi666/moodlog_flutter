import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../view_models/onboarding/onboarding_viewmodel.dart';
import '../../widgets/fade_in.dart';
import 'onboarding_personality_item.dart';

class OnboardingPersonalityPageView extends StatelessWidget {
  final Function onPageChange;

  const OnboardingPersonalityPageView({super.key, required this.onPageChange});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final viewModel = context.read<OnboardingViewModel>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 40,
      children: <Widget>[
        FadeIn(
          child: Text(
            t.onboarding_personality_title,
            style: Theme.of(
              context,
            ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        FadeIn(
          delay: const Duration(milliseconds: DelayMs.lazy),
          child: Text(
            t.onboarding_personality_description,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: FadeIn(
            delay: const Duration(milliseconds: DelayMs.lazy * 2),
            child: Column(
              children: AiPersonalities.values.map((personality) {
                final isSelected = personality == viewModel.selectedPersonality;

                return PersonalityItem(
                  personality: personality,
                  isSelected: isSelected,
                  selectedPersonality: viewModel.selectedPersonality,
                  onPersonalityChanged: viewModel.onPersonalityChanged,
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
