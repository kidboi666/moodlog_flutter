import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../settings_view_model.dart';

class AppInfoDialog extends StatefulWidget {
  final SettingsViewModel viewModel;

  const AppInfoDialog({super.key, required this.viewModel});

  @override
  State<AppInfoDialog> createState() => _AppInfoDialogState();
}

class _AppInfoDialogState extends State<AppInfoDialog> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.loadAppInfo();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.settings_information_app_title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${AppLocalizations.of(context)!.settings_information_app_version}: ${widget.viewModel.appVersion}',
          ),
          SizedBox(height: 8),
          Text(
            '${AppLocalizations.of(context)!.settings_information_app_build}: ${widget.viewModel.appBuild}',
          ),
          SizedBox(height: 8),
          Text(
            '${AppLocalizations.of(context)!.settings_information_app_developer}: Logmind',
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
