import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/snack_bar.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../settings_viewmodel.dart';

class ClearCacheDialog extends StatelessWidget {
  final SettingsViewModel viewModel;

  const ClearCacheDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(t.settings_data_cache_cleanup_title),
      content: Text(t.settings_data_cache_cleanup_confirm),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(t.common_confirm_cancel),
        ),
        FilledButton(
          onPressed: () {
            viewModel.clearCache();
            context.pop();
            context.showSnackBar(
              SnackBar(content: Text(t.snackbar_cache_cleared)),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: Text(t.common_confirm_delete),
        ),
      ],
    );
  }
}
