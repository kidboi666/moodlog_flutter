import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/router/routes.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/common.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../widgets/fade_in.dart';
import '../viewmodel/onboarding_viewmodel.dart';

class OnboardingPageViewSuccess extends StatelessWidget {
  const OnboardingPageViewSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final viewModel = context.read<OnboardingViewModel>();

    return Column(
      spacing: Spacing.xl * 2,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeIn(
          child: Text(
            t.onboarding_success_title,
            style: textTheme.displaySmall,
          ),
        ),
        Expanded(
          flex: 1,
          child: FadeIn(
            delay: DelayMs.medium,
            child: Text(
              t.onboarding_success_description,
              style: textTheme.titleLarge,
            ),
          ),
        ),
        FadeIn(
          delay: DelayMs.medium * 2,
          child: SafeArea(
            bottom: true,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FilledButton(
                    onPressed: () {
                      final aiPersonality = viewModel.selectedPersonality;
                      final nickname = viewModel.nickname;
                      context.go(
                        Routes.signIn,
                        extra: {
                          'aiPersonality': aiPersonality,
                          'nickname': nickname,
                        },
                      );
                    },
                    child: Text(t.onboarding_success_next),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
