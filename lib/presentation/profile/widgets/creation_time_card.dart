import 'package:flutter/material.dart';
import 'package:moodlog/core/extensions/date_time.dart';

import '../../../core/l10n/app_localizations.dart';

class CreationTimeCard extends StatelessWidget {
  final DateTime? creationTime;

  const CreationTimeCard({super.key, required this.creationTime});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final t = AppLocalizations.of(context)!;
    return ListTile(
      leading: Text(t.profile_creation_time_title, style: textTheme.titleSmall),
      title: Row(
        children: [
          const Expanded(child: SizedBox()),
          Text(
            creationTime?.formattedDotNationWithTime() ?? '',
            style: textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
