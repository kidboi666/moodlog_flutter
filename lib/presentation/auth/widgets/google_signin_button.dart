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
    final viewModel = context.read<AuthViewModel>();
    final isLoading = context.select((AuthViewModel vm) => vm.isLoading);

    return SubmitButton(
      isLoading: isLoading,
      onPressed: () async {
        final result = await viewModel.signInGoogle();
        if (context.mounted) {
          switch (result) {
            case Ok():
              context.go(
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
