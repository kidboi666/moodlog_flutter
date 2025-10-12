import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/routing/routes.dart';
import 'package:moodlog/core/ui/widgets/banner_ad_widget.dart';
import 'package:moodlog/presentation/screens/home/widgets/app_info_footer.dart';
import 'package:moodlog/presentation/screens/home/widgets/weather_widget.dart';
import 'package:moodlog/presentation/screens/settings/widgets/dialog/contact_dialog.dart';

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
          leading: const Icon(Icons.query_stats_sharp),
          title: Text(t.tab_statistics),
          onTap: () {
            context.pop();
            context.push(Routes.statistics);
          },
        ),
        ListTile(
          leading: const Icon(Icons.sell_outlined),
          title: Text(t.drawer_tags),
          onTap: () {
            context.pop();
            context.push(Routes.tags);
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: Text(t.tab_settings),
          onTap: () {
            context.pop();
            context.push(Routes.settings);
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.policy_outlined),
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
