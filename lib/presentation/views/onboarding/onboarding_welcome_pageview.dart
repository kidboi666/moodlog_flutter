import 'package:flutter/material.dart';

import '../../../core/constants/common.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../view_models/onboarding/onboarding_viewmodel.dart';
import '../../widgets/fade_in.dart';

class OnboardingWelcomePageView extends StatelessWidget {
  final void Function() onNext;
  final OnboardingViewModel viewModel;

  const OnboardingWelcomePageView({
    super.key,
    required this.onNext,
    required this.viewModel,
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
            AppLocalizations.of(context)!.onboarding_welcome_title,
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        FadeIn(
          delay: DelayMs.lazy,
          child: Text(
            AppLocalizations.of(context)!.onboarding_welcome_description1,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: FadeIn(
            delay: DelayMs.lazy * 2,
            child: Text(
              AppLocalizations.of(context)!.onboarding_welcome_description2,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ),
        FadeIn(
          delay: DelayMs.lazy * 3,
          child: Text(
            AppLocalizations.of(context)!.onboarding_welcome_next,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        FadeIn(
          delay: DelayMs.lazy * 4,
          child: SizedBox(
            width: double.infinity,
            child: IconButton.filled(
              alignment: Alignment.center,
              onPressed: onNext,
              icon: const Icon(Icons.arrow_forward),
            ),
          ),
        ),
      ],
    );
  }
}
