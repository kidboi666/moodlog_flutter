import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/enum.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/routing/routes.dart';
import '../../ui/widgets/spinner.dart';
import '../auth_viewmodel.dart';

class GuestSigninButton extends StatelessWidget {
  const GuestSigninButton({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Consumer<AuthViewModel>(
      builder: (context, viewModel, _) {
        return TextButton(
          onPressed: viewModel.isLoading
              ? null
              : () async {
                  await viewModel.signInAnonymously();
                  if (context.mounted) {
                    context.go(
                      Routes.onboarding,
                      extra: {'loginType': LoginType.anonymous},
                    );
                  }
                },
          child: viewModel.isLoadingAnonymously
              ? const Spinner(spinnerType: SpinnerType.button)
              : Text(t.signin_button_guest),
        );
      },
    );
  }
}
