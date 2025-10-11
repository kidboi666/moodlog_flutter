import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/routing/routes.dart';
import '../../../core/ui/widgets/banner_ad_widget.dart';
import '../../settings/widgets/dialog/contact_dialog.dart';
import 'app_info_footer.dart';
import 'weather_widget.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return NavigationDrawer(
      footer: const Column(children: [AppInfoFooter(), BannerAdWidget()]),
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(height: 80, child: WeatherWidget()),
        ),
        const Divider(),

        ListTile(
          leading: const Icon(Icons.book_outlined),
          title: Text(t.tab_entries),
          onTap: () {
            context.push(Routes.entries);
            context.pop();
          },
        ),
        ListTile(
          leading: const Icon(Icons.query_stats_sharp),
          title: Text(t.tab_statistics),
          onTap: () {
            context.push(Routes.statistics);
            context.pop();
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: Text(t.tab_settings),
          onTap: () {
            context.push(Routes.settings);
            context.pop();
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.local_police_outlined),
          title: Text(t.settings_information_license_title),
          onTap: () => showLicensePage(context: context),
        ),
        ListTile(
          leading: const Icon(Icons.mail_outline),
          title: Text(t.settings_information_qna_title),
          onTap: () =>
              showDialog(context: context, builder: (_) => ContactDialog()),
        ),
      ],
    );
  }
}
