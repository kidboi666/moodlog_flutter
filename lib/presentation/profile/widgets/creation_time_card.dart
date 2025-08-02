import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/extensions/date_time.dart';
import '../../../common/l10n/app_localizations.dart';
import '../viewmodel/profile_viewmodel.dart';

class CreationTimeCard extends StatelessWidget {
  const CreationTimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final t = AppLocalizations.of(context)!;
    return Selector<ProfileViewModel, String>(
      selector: (context, viewModel) =>
          viewModel.user?.metadata.creationTime?.formattedDotNationWithTime() ??
          '',
      builder: (context, creationTime, _) {
        return ListTile(
          leading: Text(
            t.profile_creation_time_title,
            style: textTheme.titleSmall,
          ),
          title: Row(
            children: [
              const Expanded(child: SizedBox()),
              Text(creationTime, style: textTheme.bodyMedium),
            ],
          ),
        );
      },
    );
  }
}
