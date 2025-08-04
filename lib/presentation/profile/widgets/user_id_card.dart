import 'package:flutter/material.dart';
import 'package:moodlog/presentation/profile/viewmodel/profile_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../common/l10n/app_localizations.dart';

class UserIdCard extends StatelessWidget {
  const UserIdCard({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
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
            Selector<ProfileViewModel, String>(
              selector: (context, viewModel) => viewModel.user?.uid ?? '',
              builder: (context, uid, _) {
                return Text(
                  uid,
                  style: textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
