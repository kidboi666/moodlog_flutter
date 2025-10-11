import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/l10n/app_localizations.dart';

class AppInfoDialog extends StatelessWidget {
  const AppInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final packageInfo = snapshot.data!;
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.settings_information_app_title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AppLocalizations.of(context)!.settings_information_app_version}: ${packageInfo.version}',
                ),
                const SizedBox(height: 8),
                Text(
                  '${AppLocalizations.of(context)!.settings_information_app_build}: ${packageInfo.buildNumber}',
                ),
                const SizedBox(height: 8),
                Text(
                  '${AppLocalizations.of(context)!.settings_information_app_developer}: Logmind',
                ),
                const SizedBox(height: 8),
                const Text('© 2024 All rights reserved'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => context.pop(),
                child: Text(AppLocalizations.of(context)!.common_confirm_ok),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
