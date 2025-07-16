import 'package:flutter/material.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';

import 'google_account_card.dart';

class AccountCard extends StatelessWidget {
  final bool isGoogleUser;
  final String email;

  const AccountCard({
    super.key,
    required this.isGoogleUser,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      leading: Text(t.profile_account_title, style: textTheme.titleSmall),
      title: Row(
        children: [
          const Expanded(child: SizedBox()),
          Column(children: [if (isGoogleUser) GoogleAccountCard(email: email)]),
        ],
      ),
    );
  }
}
