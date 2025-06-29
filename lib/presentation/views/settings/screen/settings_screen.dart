import 'package:flutter/material.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';

import '../../../view_models/settings/settings_viewmodel.dart';
import '../widgets/card_list_tile.dart';
import '../widgets/dialog_tile.dart';
import '../widgets/section_header.dart';
import '../widgets/switch_tile.dart';

class SettingsScreen extends StatefulWidget {
  final SettingsViewModel viewModel;

  const SettingsScreen({super.key, required this.viewModel});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('설정')),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, _) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              SectionHeader(title: '일반'),
              SwitchTile(
                title: '알림',
                subtitle: '푸시 알림을 받습니다',
                icon: Icons.notifications,
                value: widget.viewModel.appState.hasNotificationEnabled,
                onChanged: widget.viewModel.setNotificationEnabled,
              ),
              DialogTile(
                title: AppLocalizations.of(
                  context,
                )!.settings_common_theme_title,
                subtitle: AppLocalizations.of(
                  context,
                )!.settings_common_theme_subtitle,
                icon: Icons.dark_mode,
                onTap: () => widget.viewModel.showThemeDialog(context),
              ),
              DialogTile(
                title: AppLocalizations.of(
                  context,
                )!.settings_common_language_title,
                subtitle: widget.viewModel.appState.languageCode.displayName,
                icon: Icons.language,
                onTap: () => widget.viewModel.showLanguageDialog(context),
              ),
              const SizedBox(height: 40),
              SectionHeader(title: '데이터'),
              SwitchTile(
                title: '자동 동기화',
                subtitle: '데이터를 자동으로 동기화합니다',
                icon: Icons.sync,
                value: widget.viewModel.appState.hasAutoSyncEnabled,
                onChanged: widget.viewModel.setAutoSyncEnabled,
              ),
              CardListTile(
                title: '데이터 백업',
                subtitle: '데이터를 백업합니다',
                icon: Icons.backup,
                onTap: _showBackupDialog,
              ),
              CardListTile(
                title: '캐시 삭제',
                subtitle: '임시 파일을 삭제합니다',
                icon: Icons.delete_sweep,
                onTap: _showClearCacheDialog,
              ),
              const SizedBox(height: 20),
              SectionHeader(title: '정보'),
              CardListTile(
                title: '앱 정보',
                subtitle: '버전 및 라이선스 정보',
                icon: Icons.info,
                onTap: _showAppInfoDialog,
              ),
              CardListTile(
                title: '도움말',
                subtitle: '사용법 및 FAQ',
                icon: Icons.help,
                onTap: () {},
              ),
              CardListTile(
                title: '문의하기',
                subtitle: '개발자에게 문의',
                icon: Icons.mail,
                onTap: _showContactDialog,
              ),
            ],
          );
        },
      ),
    );
  }

  void _showBackupDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('데이터 백업'),
        content: const Text('데이터를 백업하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _performBackup();
            },
            child: const Text('백업'),
          ),
        ],
      ),
    );
  }

  void _showClearCacheDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('캐시 삭제'),
        content: const Text('캐시를 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _clearCache();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }

  void _showAppInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('앱 정보'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('버전: 1.0.0'),
            SizedBox(height: 8),
            Text('빌드: 100'),
            SizedBox(height: 8),
            Text('개발자: Your Name'),
            SizedBox(height: 8),
            Text('© 2024 All rights reserved'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  void _showContactDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('문의하기'),
        content: const Text('이메일: support@yourapp.com\n전화: 02-1234-5678'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  void _performBackup() {
    // 백업 로직 구현
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('백업이 완료되었습니다.')));
  }

  void _clearCache() {
    // 캐시 삭제 로직 구현
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('캐시가 삭제되었습니다.')));
  }
}
