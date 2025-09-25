import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/enum.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/routing/routes.dart';
import '../../../core/ui/widgets/submit_button.dart';
import '../../../core/utils/result.dart';
import '../auth_viewmodel.dart';

class GoogleSigninButton extends StatelessWidget {
  const GoogleSigninButton({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final viewModel = context.read<AuthViewModel>();
    final isLoadingGoogle = context.select((AuthViewModel vm) => vm.isLoadingGoogle);
    final isAnyLoading = context.select((AuthViewModel vm) => vm.isLoading);
    final isDisabled = isAnyLoading && !isLoadingGoogle;

    return SubmitButton(
      isLoading: isLoadingGoogle,
      style: FilledButton.styleFrom(
        backgroundColor: isDisabled
            ? colorScheme.surfaceContainer.withValues(alpha: 0.12)
            : colorScheme.surfaceContainer,
        foregroundColor: isDisabled
            ? colorScheme.onSurface.withValues(alpha: 0.38)
            : colorScheme.onSurface,
        disabledBackgroundColor: colorScheme.surfaceContainer.withValues(alpha: 0.12),
        disabledForegroundColor: colorScheme.onSurface.withValues(alpha: 0.38),
      ),
      onPressed: isDisabled ? null : () async {
        final result = await viewModel.signInGoogle();
        if (context.mounted) {
          switch (result) {
            case Ok():
              context.push(
                Routes.onboarding,
                extra: {'loginType': LoginType.google},
              );
            case Error():
              break;
          }
        }
      },
      children: [
        SvgPicture.asset('assets/svg/google-icon.svg', width: 24, height: 24),
        Text(
          t.signin_button_google,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
