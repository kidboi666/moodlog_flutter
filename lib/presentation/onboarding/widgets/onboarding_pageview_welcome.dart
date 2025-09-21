import 'package:flutter/material.dart';

import '../../../core/constants/common.dart';
import '../../../core/extensions/widget.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/ui/widgets/fade_in.dart';

class OnboardingPageViewWelcome extends StatelessWidget {
  final void Function() onNext;

  const OnboardingPageViewWelcome({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Spacing.xl * 2,
        children: [
          FadeIn(
            child: Text(
              t.onboarding_welcome_title,
              style: textTheme.displaySmall,
            ),
          ),
          FadeIn(
            delay: DelayMS.medium,
            child: Text(
              t.onboarding_welcome_description1,
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.secondary,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: FadeIn(
              delay: DelayMS.medium * 2,
              child: Text(
                t.onboarding_welcome_description2,
                style: textTheme.titleLarge?.copyWith(
                  color: colorScheme.secondary,
                ),
              ),
            ),
          ),
          FadeIn(
            delay: DelayMS.medium * 3,
            child: Text(t.onboarding_welcome_next, style: textTheme.titleLarge),
          ),
          FadeIn(
            delay: DelayMS.medium * 4,
            child: SafeArea(
              bottom: true,
              child: SizedBox(
                width: double.infinity,
                child: IconButton.filled(
                  alignment: Alignment.center,
                  onPressed: onNext,
                  icon: const Icon(Icons.arrow_forward),
                ).scale(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
