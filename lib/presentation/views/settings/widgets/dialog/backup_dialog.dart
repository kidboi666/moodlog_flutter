import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/l10n/app_localizations.dart';
import '../../../../view_models/settings/settings_viewmodel.dart';

class BackupDialog extends StatelessWidget {
  final SettingsViewModel viewModel;

  const BackupDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.settings_data_backup_title),
      content: Text(AppLocalizations.of(context)!.settings_data_backup_confirm),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(AppLocalizations.of(context)!.common_confirm_cancel),
        ),
        FilledButton(
          onPressed: () {
            viewModel.performBackup(context);
          },
          child: Text(
            AppLocalizations.of(context)!.settings_data_backup_confirm_ok,
          ),
        ),
      ],
    );
  }
}
