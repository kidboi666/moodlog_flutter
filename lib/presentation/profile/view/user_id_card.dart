import 'package:flutter/material.dart';

import '../../../core/l10n/app_localizations.dart';

class UserIdCard extends StatelessWidget {
  final String uid;

  const UserIdCard({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      bottom: true,
      child: ListTile(
        leading: Text(
          t.profile_uid_title,
          style: textTheme.titleSmall?.copyWith(
            color: colorScheme.secondaryFixedDim,
          ),
        ),
        title: Row(
          children: [
            const Expanded(child: SizedBox()),
            Text(uid, style: textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
