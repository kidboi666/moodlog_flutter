import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/l10n/app_localizations.dart';
import '../profile_view_model.dart';
import 'apple_account_card.dart';
import 'google_account_card.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final (:isCurrentGoogleUser, :isCurrentAppleUser, :email) = context.select(
      (ProfileViewModel vm) => (
        isCurrentGoogleUser: vm.isCurrentGoogleUser,
        isCurrentAppleUser: vm.isCurrentAppleUser,
        email: vm.user?.email,
      ),
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
        ],
      ),
    );
  }
}
