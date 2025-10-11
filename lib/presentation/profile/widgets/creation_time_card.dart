import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/l10n/app_localizations.dart';
import '../profile_view_model.dart';

class CreationTimeCard extends StatelessWidget {
  const CreationTimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final t = AppLocalizations.of(context)!;
    final createdAt = context.select(
      (ProfileViewModel vm) {
        final date = vm.user?.createdAt;
        if (date == null) return '';
        return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
      },
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Spacing.sm,
        children: [
          Text(t.profile_creation_time_title, style: textTheme.titleSmall),
          Text(createdAt, style: textTheme.bodyMedium),
        ],
      ),
    );
  }
}
