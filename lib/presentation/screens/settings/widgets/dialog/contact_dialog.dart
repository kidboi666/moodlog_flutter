import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDialog extends StatelessWidget {
  const ContactDialog({super.key});

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
          await _copyToClipboard(context, 'log.mind.365@gmail.com');
        }
      }
    } catch (e) {
      if (context.mounted) {
        await _copyToClipboard(context, 'log.mind.365@gmail.com');
      }
    }
  }

  Future<void> _launchPhone(BuildContext context) async {
    try {
      final uri = Uri.parse('tel:010-9383-4485');

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          await _copyToClipboard(context, '010-9383-4485');
        }
      }
    } catch (e) {
      if (context.mounted) {
        await _copyToClipboard(context, '010-9383-4485');
      }
    }
  }

  Future<void> _copyToClipboard(BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$text 복사되었습니다')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(t.settings_information_qna_title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.email_outlined),
            title: const Text('log.mind.365@gmail.com'),
            subtitle: Text(t.common_email),
            onTap: () => _launchEmail(context),
          ),
          const Divider(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.phone_outlined),
            title: const Text('010-9383-4485'),
            subtitle: Text(t.common_phone),
            onTap: () => _launchPhone(context),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(t.common_confirm_cancel),
        ),
      ],
    );
  }
}
