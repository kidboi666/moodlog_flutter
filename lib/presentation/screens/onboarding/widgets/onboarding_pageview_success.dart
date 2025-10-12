import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/routing/routes.dart';
import 'package:moodlog/core/ui/widgets/fade_in.dart';
import 'package:moodlog/core/ui/widgets/spinner.dart';
import 'package:moodlog/presentation/screens/onboarding/onboarding_view_model.dart';
import 'package:provider/provider.dart';

class OnboardingPageViewSuccess extends StatelessWidget {
  const OnboardingPageViewSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
      child: Column(
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
              delay: DelayMS.medium,
              child: Text(
                t.onboarding_success_description,
                style: textTheme.titleLarge,
              ),
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
