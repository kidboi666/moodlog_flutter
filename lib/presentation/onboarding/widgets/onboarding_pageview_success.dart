import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/common.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../widgets/fade_in.dart';
import '../viewmodel/onboarding_viewmodel.dart';

class OnboardingPageViewSuccess extends StatelessWidget {
  final void Function() onNext;
  final void Function() signInGoogle;

  const OnboardingPageViewSuccess({
    super.key,
    required this.onNext,
    required this.signInGoogle,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

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
              child: Selector<OnboardingViewModel, bool>(
                selector: (context, viewModel) => viewModel.isLoading,
                builder: (context, isLoading, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: colorScheme.surfaceContainer,
                          foregroundColor: colorScheme.onSurface,
                        ),
                        onPressed: isLoading ? null : signInGoogle,
                        child: isLoading
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Row(
                                spacing: Spacing.md,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/google-icon.svg',
                                    width: 24,
                                    height: 24,
                                  ),
                                  Text(t.onboarding_success_google),
                                ],
                              ),
                      ),
                      // TODO 카카오 로그인
                      if (kDebugMode)
                        FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.yellow,
                            foregroundColor: Colors.black,
                          ),
                          onPressed: () {},
                          child: isLoading
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Row(
                                  spacing: Spacing.md,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/kakao-icon.svg',
                                      width: 24,
                                      height: 24,
                                    ),
                                    Text(t.onboarding_success_kakao),
                                  ],
                                ),
                        ),
                      TextButton(
                        onPressed: isLoading ? null : onNext,
                        child: isLoading
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(t.onboarding_success_guest),
                      ),
                    ],
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
