import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/ui/widgets/submit_button.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/enum.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/routing/routes.dart';
import '../auth_viewmodel.dart';

class GuestSigninButton extends StatelessWidget {
  const GuestSigninButton({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final isLoading = context.select((AuthViewModel vm) => vm.isLoading);

    return SubmitButton(
      onPressed: () {
        context.go(
          Routes.onboarding,
          extra: {'loginType': LoginType.anonymous},
        );
      },
      style: FilledButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      isLoading: isLoading,
      children: [
        Text(
          t.signin_button_guest,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
