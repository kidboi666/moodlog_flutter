import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moodlog/presentation/auth/viewmodel/auth_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../widgets/fade_in.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(t.signin_title)),
      body: Padding(
        padding: const EdgeInsets.all(Spacing.md),
        child: Column(
          spacing: Spacing.xl * 2,
          children: [
            FadeIn(
              delay: DelayMs.medium,
              child: Image.asset(
                'assets/images/icon.png',
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 2,
                fit: BoxFit.contain,
              ),
            ),
            FadeIn(
              delay: DelayMs.medium * 2,
              child: Text(
                t.signin_growth,
                style: textTheme.headlineSmall?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            FadeIn(
              delay: DelayMs.medium * 3,
              child: Text(
                t.signin_login_title,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            FadeIn(
              delay: DelayMs.medium * 4,
              child: SafeArea(
                bottom: true,
                child: SizedBox(
                  width: double.infinity,
                  child: Consumer<AuthViewModel>(
                    builder: (context, viewModel, _) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: colorScheme.surfaceContainer,
                              foregroundColor: colorScheme.onSurface,
                            ),
                            onPressed: viewModel.isLoading
                                ? null
                                : viewModel.signInGoogle,
                            child: viewModel.isLoadingGoogle
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
                                      Text(t.signin_button_google),
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
                              onPressed: viewModel.isLoading ? null : () {},
                              child: viewModel.isLoadingKakao
                                  ? SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Row(
                                      spacing: Spacing.md,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/kakao-icon.svg',
                                          width: 24,
                                          height: 24,
                                        ),
                                        Text(t.signin_button_kakao),
                                      ],
                                    ),
                            ),
                          TextButton(
                            onPressed: viewModel.isLoading
                                ? null
                                : viewModel.signInAnonymously,
                            child: viewModel.isLoadingAnonymously
                                ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(t.signin_button_guest),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
