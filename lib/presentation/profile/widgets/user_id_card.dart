import 'package:flutter/material.dart';
import 'package:moodlog/presentation/profile/viewmodel/profile_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../core/l10n/app_localizations.dart';

class UserIdCard extends StatelessWidget {
  const UserIdCard({super.key});

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
            Selector<ProfileViewModel, String>(
              selector: (context, viewModel) => viewModel.user?.uid ?? '',
              builder: (context, uid, _) {
                return Text(uid, style: textTheme.bodyMedium);
              },
            ),
          ],
        ),
      ),
    );
  }
}
