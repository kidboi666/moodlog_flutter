import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/routing/routes.dart';
import 'package:moodlog/presentation/screens/onboarding/onboarding_view_model.dart';
import 'package:moodlog/presentation/widgets/fade_in.dart';
import 'package:moodlog/presentation/widgets/spinner.dart';
import 'package:provider/provider.dart';

class OnboardingPageViewSuccess extends StatelessWidget {
  const OnboardingPageViewSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: Spacing.xl * 2),
                FadeIn(
                  child: Text(
                    t.onboarding_success_title,
                    style: textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: Spacing.md),
                FadeIn(
                  delay: DelayMS.medium,
                  child: Text(
                    t.onboarding_success_description,
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.secondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          FadeIn(
            delay: DelayMS.medium * 2,
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
                                  await viewModel.completeOnboarding();
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
      ),
    );
  }
}