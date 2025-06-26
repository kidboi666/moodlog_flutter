import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../widgets/fade_in.dart';

class OnboardingNicknamePageView extends StatelessWidget {
  const OnboardingNicknamePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 40,
      children: <Widget>[
        FadeIn(
          child: Text(
            t.onboarding_nickname_title,
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        FadeIn(
          delay: const Duration(milliseconds: DelayMs.lazy),
          child: Text(
            t.onboarding_nickname_description,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        TextFormField(),
        Expanded(
          flex: 1,
          child: FadeIn(
            delay: const Duration(milliseconds: DelayMs.lazy * 2),
            child: Text(t.onboarding_welcome_description2),
          ),
        ),
        FadeIn(
          delay: const Duration(milliseconds: DelayMs.lazy * 3),
          child: Text(t.onboarding_welcome_next),
        ),
      ],
    );
  }
}
