import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/extensions/date_time.dart';
import '../../../core/l10n/app_localizations.dart';
import '../profile_viewmodel.dart';

class CreationTimeCard extends StatelessWidget {
  const CreationTimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final t = AppLocalizations.of(context)!;
    final createdAt = context.select(
      (ProfileViewModel vm) =>
          vm.user?.metadata.creationTime?.formattedDotNationWithTime(),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Spacing.sm,
        children: [
          Text(t.profile_creation_time_title, style: textTheme.titleSmall),
          Text(createdAt!, style: textTheme.bodyMedium),
        ],
      ),
    );
  }
}
