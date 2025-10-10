import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/enum.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/routing/routes.dart';

class GuestLoginButton extends StatelessWidget {
  const GuestLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        spacing: 8,
        children: [
          Text(
            t.profile_guest_login_description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          FilledButton(
            onPressed: () {
              context.push(
                Routes.signIn,
                extra: {'source': SignInSource.profile},
              );
            },
            style: FilledButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
            ),
            child: Text(t.profile_guest_login_button),
          ),
        ],
      ),
    );
  }
}
