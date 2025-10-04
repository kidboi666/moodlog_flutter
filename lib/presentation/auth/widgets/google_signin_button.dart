import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/enum.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/routing/routes.dart';
import '../../../core/ui/widgets/submit_button.dart';
import '../../../core/utils/result.dart';
import '../auth_view_model.dart';

class GoogleSigninButton extends StatelessWidget {
  const GoogleSigninButton({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final viewModel = context.read<AuthViewModel>();
    final isLoadingGoogle = context.select(
      (AuthViewModel vm) => vm.isLoadingGoogle,
    );
    final isAnyLoading = context.select((AuthViewModel vm) => vm.isLoading);
    final isDisabled = isAnyLoading && !isLoadingGoogle;

    Future<void> signInGoogle() async {
      final result = await viewModel.signInGoogle();
      if (context.mounted) {
        switch (result) {
          case Ok():
            context.push(
              Routes.onboarding,
              extra: {'loginType': LoginMethod.google},
            );
          case Error():
            break;
        }
      }
    }

    return SubmitButton(
      isLoading: isLoadingGoogle,
      isDisabled: isDisabled,
      onPressed: signInGoogle,
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
