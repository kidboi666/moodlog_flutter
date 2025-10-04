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
    final isLoadingApple = context.select(
      (AuthViewModel vm) => vm.isLoadingApple,
    );
    final isAnyLoading = context.select((AuthViewModel vm) => vm.isLoading);
    final viewModel = context.read<AuthViewModel>();
    final isDisabled = isAnyLoading && !isLoadingApple;

    Future<void> signInApple() async {
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
    }

    return SubmitButton(
      isLoading: isLoadingApple,
      isDisabled: isDisabled,
      backgroundColor: colorScheme.primaryContainer,
      foregroundColor: colorScheme.onPrimary,
      onPressed: signInApple,
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
  }
}
