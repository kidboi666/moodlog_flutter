import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../widgets/fade_in.dart';

class OnboardingWelcomePageView extends StatelessWidget {
  final Function onPageChange;

  const OnboardingWelcomePageView({super.key, required this.onPageChange});

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
          delay: const Duration(milliseconds: DelayMs.lazy),
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
            delay: const Duration(milliseconds: DelayMs.lazy * 2),
            child: Text(
              AppLocalizations.of(context)!.onboarding_welcome_description2,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ),
        FadeIn(
          delay: const Duration(milliseconds: DelayMs.lazy * 3),
          child: Text(
            AppLocalizations.of(context)!.onboarding_welcome_next,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        IconButton.filled(
          onPressed: () => onPageChange(),
          icon: Icon(Icons.arrow_forward),
        ),
      ],
    );
  }
}
