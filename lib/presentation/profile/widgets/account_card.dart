import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/enum.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/routing/routes.dart';
import '../profile_viewmodel.dart';
import 'apple_account_card.dart';
import 'google_account_card.dart';

typedef AccountCardValue = ({
  bool isGoogleUser,
  bool isAppleUser,
  String? email,
  bool isAnonymousUser,
});

class AccountCard extends StatelessWidget {
  const AccountCard({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final isCurrentGoogleUser = context.select(
      (ProfileViewModel vm) => vm.isCurrentGoogleUser,
    );
    final isCurrentAppleUser = context.select(
      (ProfileViewModel vm) => vm.isCurrentAppleUser,
    );
    final email = context.select((ProfileViewModel vm) => vm.user?.email);
    final isAnonymousUser = context.select(
      (ProfileViewModel vm) => vm.isAnonymousUser,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(t.profile_account_title, style: textTheme.titleSmall),
          const SizedBox(height: 8.0),
          if (isCurrentGoogleUser) GoogleAccountCard(email: email ?? ''),
          if (isCurrentAppleUser) AppleAccountCard(email: email ?? ''),
          if (isAnonymousUser)
            FilledButton(
              onPressed: () {
                context.push(
                  Routes.signIn,
                  extra: {'source': SignInSource.profile},
                );
              },
              child: Text(t.profile_button_login),
            ),
        ],
      ),
    );
  }
}
