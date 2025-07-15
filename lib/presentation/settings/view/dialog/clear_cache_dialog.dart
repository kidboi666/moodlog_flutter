import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';

import '../../viewmodel/settings_viewmodel.dart';

class ClearCacheDialog extends StatelessWidget {
  final SettingsViewModel viewModel;

  const ClearCacheDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppLocalizations.of(context)!.settings_data_cache_cleanup_title,
      ),
      content: Text(
        AppLocalizations.of(context)!.settings_data_cache_cleanup_confirm,
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(AppLocalizations.of(context)!.common_confirm_cancel),
        ),
        FilledButton(
          onPressed: () {
            viewModel.clearCache(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: Text(AppLocalizations.of(context)!.common_confirm_delete),
        ),
      ],
    );
  }
}
