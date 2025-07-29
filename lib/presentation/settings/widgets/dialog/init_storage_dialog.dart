import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../viewmodel/settings_viewmodel.dart';

class InitStorageDialog extends StatelessWidget {
  final SettingsViewModel viewModel;

  const InitStorageDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    
    return AlertDialog(
      title: Text(t.dialog_storage_init_title),
      content: Text(t.dialog_storage_init_content),
      actions: [
        TextButton(onPressed: () => context.pop(), child: Text(t.common_confirm_cancel)),
        FilledButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onError,
          ),
          onPressed: () {
            viewModel.clearSharedPreferences();
            context.pop();
          },
          child: Text(t.common_confirm_delete),
        ),
      ],
    );
  }
}
