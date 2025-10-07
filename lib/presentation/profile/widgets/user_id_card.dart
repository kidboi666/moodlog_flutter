import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/l10n/app_localizations.dart';
import '../profile_view_model.dart';

class UserIdCard extends StatelessWidget {
  const UserIdCard({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final uid = context.select(
      (ProfileViewModel vm) => vm.user?.uid ?? '',
    );

    return SafeArea(
      bottom: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.profile_uid_title,
              style: textTheme.titleSmall?.copyWith(
                color: colorScheme.secondaryFixedDim,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              uid,
              style: textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
