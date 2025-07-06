import 'package:flutter/material.dart';

import '../../../../core/constants/common.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../view_models/onboarding/onboarding_viewmodel.dart';
import '../../../widgets/fade_in.dart';

class OnboardingPageViewSuccess extends StatelessWidget {
  final OnboardingViewModel viewModel;
  final void Function() onNext;

  const OnboardingPageViewSuccess({
    super.key,
    required this.viewModel,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 40,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeIn(
          child: Text(
            AppLocalizations.of(context)!.onboarding_success_title,
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        Expanded(
          flex: 1,
          child: FadeIn(
            delay: DelayMs.lazy,
            child: Text(
              AppLocalizations.of(context)!.onboarding_success_description,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        FadeIn(
          delay: DelayMs.lazy * 2,
          child: SafeArea(
            bottom: true,
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onNext,
                child: Text(
                  AppLocalizations.of(context)!.onboarding_success_button,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
