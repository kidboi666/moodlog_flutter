import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/routing/routes.dart';
import 'package:moodlog/presentation/screens/home/widgets/app_info_footer.dart';
import 'package:moodlog/presentation/screens/home/widgets/weather_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  Future<void> _launchEmail(BuildContext context) async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final version = packageInfo.version;
      final buildNumber = packageInfo.buildNumber;
      final platform = Platform.operatingSystem;
      final osVersion = Platform.operatingSystemVersion;

      final subject = Uri.encodeComponent('[MoodLog] 문의하기');
      final body = Uri.encodeComponent('''


---
앱 버전: $version ($buildNumber)
OS: $platform
시스템: $osVersion

문의 내용을 위에 작성해주세요.
''');

      final uri = Uri.parse(
        'mailto:log.mind.365@gmail.com?subject=$subject&body=$body',
      );

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          await Clipboard.setData(
            const ClipboardData(text: 'log.mind.365@gmail.com'),
          );
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('log.mind.365@gmail.com 복사되었습니다'),
              ),
            );
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        await Clipboard.setData(
          const ClipboardData(text: 'log.mind.365@gmail.com'),
        );
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('log.mind.365@gmail.com 복사되었습니다')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return NavigationDrawer(
      footer: const AppInfoFooter(),
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(height: 80, child: WeatherWidget()),
        ),
        const Divider(),

        ListTile(
          leading: const Icon(Icons.query_stats_sharp),
          title: Text(t.tab_statistics),
          onTap: () => context.push(Routes.statistics),
        ),
        ListTile(
          leading: const Icon(Icons.auto_awesome),
          title: Text(t.mood_summary_title),
          onTap: () => context.push(Routes.moodSummary),
        ),
        ListTile(
          leading: const Icon(Icons.sell_outlined),
          title: Text(t.drawer_activities),
          onTap: () => context.push(Routes.activities),
        ),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: Text(t.tab_settings),
          onTap: () => context.push(Routes.settings),
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
          onTap: () => _launchEmail(context),
        ),
        ListTile(
          leading: const Icon(Icons.rate_review_outlined),
          title: Text(t.drawer_review),
          onTap: () async {
            try {
              await InAppReview.instance.requestReview();
            } catch (e) {
              // 개발 모드나 에뮬레이터에서는 조용히 무시
            }
          },
        ),
      ],
    );
  }
}
