import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/enum.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/routing/routes.dart';

class GuestSigninButton extends StatelessWidget {
  const GuestSigninButton({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return TextButton(
      onPressed: () {
        context.go(
          Routes.onboarding,
          extra: {'loginType': LoginType.anonymous},
        );
      },
      child: Text(t.signin_button_guest),
    );
  }
}
