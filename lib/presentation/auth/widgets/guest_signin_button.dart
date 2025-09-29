import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/ui/widgets/submit_button.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/enum.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/routing/routes.dart';
import '../../../core/utils/result.dart';
import '../auth_viewmodel.dart';

class GuestSigninButton extends StatelessWidget {
  const GuestSigninButton({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final isLoadingAnonymously = context.select(
      (AuthViewModel vm) => vm.isLoadingAnonymously,
    );
    final isAnyLoading = context.select((AuthViewModel vm) => vm.isLoading);
    final viewModel = context.read<AuthViewModel>();
    final isDisabled = isAnyLoading && !isLoadingAnonymously;

    return SubmitButton(
      onPressed: isDisabled
          ? null
          : () async {
              final result = await viewModel.signInAnonymously();
              if (context.mounted) {
                switch (result) {
                  case Ok():
                    context.push(
                      Routes.onboarding,
                      extra: {'loginType': LoginMethod.anonymous},
                    );
                  case Error():
                    break;
                }
              }
            },
      style: FilledButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: isDisabled
            ? colorScheme.onSurface.withValues(alpha: 0.38)
            : colorScheme.onSurface,
        disabledBackgroundColor: Colors.transparent,
        disabledForegroundColor: colorScheme.onSurface.withValues(alpha: 0.38),
      ),
      isLoading: isLoadingAnonymously,
      children: [
        Text(
          t.signin_button_guest,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
