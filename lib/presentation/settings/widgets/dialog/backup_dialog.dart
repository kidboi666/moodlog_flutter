import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/l10n/app_localizations.dart';
import '../../viewmodel/settings_viewmodel.dart';

class BackupDialog extends StatelessWidget {
  final SettingsViewModel viewModel;

  const BackupDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(t.settings_data_backup_title),
      content: Text(t.settings_data_backup_confirm),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(t.common_confirm_cancel),
        ),
        FilledButton(
          onPressed: () {
            viewModel.performBackup();
            context.pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(t.snackbar_backup_completed)),
            );
          },
          child: Text(t.settings_data_backup_confirm_ok),
        ),
      ],
    );
  }
}
