import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import '../../../core/l10n/app_localizations.dart';
import '../../../core/routing/routes.dart';
import '../../settings/widgets/dialog/app_info_dialog.dart';
import '../../settings/widgets/dialog/contact_dialog.dart';
import '../../settings/widgets/section_header.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                const DrawerHeader(
                  child: Text('Menu'), // Placeholder
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.home_outlined),
                  title: Text(t.tab_home),
                  onTap: () {
                    context.go(Routes.home);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.book_outlined),
                  title: Text(t.tab_entries),
                  onTap: () {
                    context.push(Routes.entries);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.query_stats_sharp),
                  title: Text(t.tab_statistics),
                  onTap: () {
                    context.push(Routes.statistics);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings_outlined),
                  title: Text(t.tab_settings),
                  onTap: () {
                    context.push(Routes.settings);
                    Navigator.pop(context);
                  },
                ),
                const Divider(),
                SectionHeader(title: t.settings_information_title),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: Text(t.settings_information_app_title),
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) => const AppInfoDialog(),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.local_police_outlined),
                  title: Text(t.settings_information_license_title),
                  onTap: () => showLicensePage(context: context),
                ),
                ListTile(
                  leading: const Icon(Icons.mail_outline),
                  title: Text(t.settings_information_qna_title),
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) => ContactDialog(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
