import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/presentation/widgets/spinner.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/constants/enum.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/routing/routes.dart';
import '../viewmodel/auth_viewmodel.dart';

class GoogleSigninButton extends StatelessWidget {
  const GoogleSigninButton({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    return Consumer<AuthViewModel>(
      builder: (context, viewModel, _) {
        return FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.surfaceContainer,
            foregroundColor: colorScheme.onSurface,
          ),
          onPressed: viewModel.isLoading
              ? null
              : () async {
                  await viewModel.signInGoogle();
                  if (context.mounted) {
                    context.go(
                      Routes.onboarding,
                      extra: {'loginType': LoginType.google},
                    );
                  }
                },
          child: viewModel.isLoadingGoogle
              ? const Spinner(spinnerType: SpinnerType.button)
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
        );
      },
    );
  }
}
