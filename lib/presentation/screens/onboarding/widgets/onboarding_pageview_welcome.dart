import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/extensions/widget.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/ui/widgets/fade_in.dart';

class OnboardingPageViewWelcome extends StatelessWidget {
  final void Function() onNext;

  const OnboardingPageViewWelcome({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final t = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeIn(
                  child: SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/app-icon.png',
                      width: 96,
                      height: 96,
                    ),
                  ),
                ),
                const SizedBox(height: Spacing.xl * 2),
                FadeIn(
                  child: Text(
                    t.onboarding_welcome_title,
                    style: textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          FadeIn(
            delay: DelayMS.medium * 3,
            child: Text(t.onboarding_welcome_next, style: textTheme.titleLarge),
          ),
          const SizedBox(height: Spacing.md),
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
