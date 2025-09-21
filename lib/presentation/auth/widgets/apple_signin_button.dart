import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/ui/widgets/apple_logo_painter.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/enum.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/routing/routes.dart';
import '../../../core/ui/widgets/submit_button.dart';
import '../../../core/utils/result.dart';
import '../auth_viewmodel.dart';

class AppleSigninButton extends StatelessWidget {
  const AppleSigninButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;
    return Consumer<AuthViewModel>(
      builder: (context, viewModel, _) {
        return SubmitButton(
          isLoading: viewModel.isLoading,
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
          ),
          onPressed: () async {
            final result = await viewModel.signInApple();
            if (context.mounted) {
              switch (result) {
                case Ok():
                  context.go(
                    Routes.onboarding,
                    extra: {'loginType': LoginType.apple},
                  );
                case Error():
                  break;
              }
            }
          },
          children: [
            FixedSizeAppleLogo(),
            Text(
              t.signin_button_apple,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: colorScheme.onPrimary),
            ),
          ],
        );
      },
    );
  }
}
