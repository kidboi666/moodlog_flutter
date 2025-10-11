import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/l10n/app_localizations.dart';

class AppInfoFooter extends StatelessWidget {
  const AppInfoFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final packageInfo = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  '${AppLocalizations.of(context)!.settings_information_app_version}: ${packageInfo.version}',
                ),
                const SizedBox(height: 8),
                Text(
                  '${AppLocalizations.of(context)!.settings_information_app_build}: ${packageInfo.buildNumber}',
                ),
                const SizedBox(height: 8),
                const SizedBox(height: 8),
                const Text('© 2024 All rights reserved'),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
