import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/l10n/app_localizations.dart';
import '../../viewmodel/settings_viewmodel.dart';

class AppInfoDialog extends StatelessWidget {
  final SettingsViewModel viewModel;

  const AppInfoDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.settings_information_app_title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${AppLocalizations.of(context)!.settings_information_app_version}: 1.0.0',
          ),
          SizedBox(height: 8),
          Text(
            '${AppLocalizations.of(context)!.settings_information_app_build}: 100',
          ),
          SizedBox(height: 8),
          Text(
            '${AppLocalizations.of(context)!.settings_information_app_developer}: Your Name',
          ),
          SizedBox(height: 8),
          Text('© 2024 All rights reserved'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(AppLocalizations.of(context)!.common_confirm_ok),
        ),
      ],
    );
  }
}
