import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../common/constants/common.dart';
import '../../../common/l10n/app_localizations.dart';
import '../../../common/routing/routes.dart';
import '../../core/widgets/fade_in.dart';
import '../../core/widgets/spinner.dart';
import '../viewmodel/onboarding_viewmodel.dart';

class OnboardingPageViewSuccess extends StatelessWidget {
  const OnboardingPageViewSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

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
                  Builder(
                    builder: (context) {
                      final viewModel = context.read<OnboardingViewModel>();
                      final isLoading = context
                          .select<OnboardingViewModel, bool>(
                            (vm) => vm.isLoading,
                          );

                      return FilledButton(
                        onPressed: isLoading
                            ? null
                            : () async {
                                await viewModel.setOnboardingCompleted();
                                if (context.mounted) {
                                  context.go(Routes.home);
                                }
                              },
                        child: isLoading
                            ? const Spinner()
                            : Text(t.onboarding_success_next),
                      );
                    },
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
