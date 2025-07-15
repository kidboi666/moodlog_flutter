import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/common.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../widgets/fade_in.dart';
import '../viewmodel/onboarding_viewmodel.dart';

class OnboardingPageViewSuccess extends StatelessWidget {
  final void Function() onNext;

  const OnboardingPageViewSuccess({super.key, required this.onNext});

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
            delay: DelayMs.lazy,
            child: Text(
              t.onboarding_success_description,
              style: textTheme.titleLarge,
            ),
          ),
        ),
        FadeIn(
          delay: DelayMs.lazy * 2,
          child: SafeArea(
            bottom: true,
            child: SizedBox(
              width: double.infinity,
              child: Selector<OnboardingViewModel, bool>(
                selector: (context, viewModel) => viewModel.isLoading,
                builder: (context, isLoading, _) {
                  return FilledButton(
                    onPressed: isLoading ? null : onNext,
                    child: isLoading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(t.onboarding_success_button),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
