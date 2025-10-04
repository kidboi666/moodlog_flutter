import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/enum.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/routing/routes.dart';
import '../../../core/ui/widgets/apple_logo_painter.dart';
import '../../../core/ui/widgets/submit_button.dart';
import '../../../core/utils/result.dart';
import '../auth_view_model.dart';

class AppleSigninButton extends StatelessWidget {
  const AppleSigninButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;
    return Consumer<AuthViewModel>(
      builder: (context, viewModel, _) {
        final isLoadingApple = viewModel.isLoadingApple;
        final isAnyLoading = viewModel.isLoading;
        final isDisabled = isAnyLoading && !isLoadingApple;

        return SubmitButton(
          isLoading: isLoadingApple,
          style: FilledButton.styleFrom(
            backgroundColor: isDisabled
                ? colorScheme.primaryContainer.withValues(alpha: 0.12)
                : colorScheme.primaryContainer,
            foregroundColor: isDisabled
                ? colorScheme.onPrimary.withValues(alpha: 0.38)
                : colorScheme.onPrimary,
            disabledBackgroundColor: colorScheme.primaryContainer.withValues(
              alpha: 0.12,
            ),
            disabledForegroundColor: colorScheme.onPrimary.withValues(
              alpha: 0.38,
            ),
          ),
          onPressed: isDisabled
              ? null
              : () async {
                  final result = await viewModel.signInApple();
                  if (context.mounted) {
                    switch (result) {
                      case Ok():
                        context.push(
                          Routes.onboarding,
                          extra: {'loginType': LoginMethod.apple},
                        );
                      case Error():
                        debugPrint('Error: ${result.error}');
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
