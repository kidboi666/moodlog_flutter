import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/extensions/enum.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/routing/routes.dart';
import '../../widgets/avatar.dart';
import '../viewmodel/settings_viewmodel.dart';
import '../widgets/card_list_tile.dart';
import '../widgets/dialog/app_info_dialog.dart';
import '../widgets/dialog/backup_dialog.dart';
import '../widgets/dialog/clear_cache_dialog.dart';
import '../widgets/dialog/color_theme_dialog.dart';
import '../widgets/dialog/contact_dialog.dart';
import '../widgets/dialog/font_family_dialog.dart';
import '../widgets/dialog/init_db_dialog.dart';
import '../widgets/dialog/init_storage_dialog.dart';
import '../widgets/dialog/language_dialog.dart';
import '../widgets/dialog/theme_dialog.dart';
import '../widgets/dialog_tile.dart';
import '../widgets/section_header.dart';
import '../widgets/switch_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final viewModel = Provider.of<SettingsViewModel>(context);
    return CustomScrollView(
      slivers: [
        Selector<SettingsViewModel, String?>(
          selector: (_, viewModel) => viewModel.profileImage,
          builder: (context, profileImage, _) {
            return SliverAppBar(
              title: Text(t.settings_title),
              actionsPadding: Spacing.containerHorizontalPadding,
              actions: [
                Avatar(
                  photoUrl: profileImage,
                  onTap: () => context.push(Routes.profile),
                ),
              ],
            );
          },
        ),

        SliverPadding(
          padding: Spacing.containerHorizontalPadding,
          sliver: SliverList(
            delegate: SliverChildListDelegate.fixed([
              const SizedBox(height: Spacing.xl),

              if (kDebugMode) ...[
                SectionHeader(title: '개발용 옵션'),
                DialogTile(
                  title: '스토리지 초기화',
                  subtitle: '개발모드 전용 동작',
                  icon: Icons.delete,
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) => InitStorageDialog(viewModel: viewModel),
                  ),
                ),
                DialogTile(
                  title: '데이터베이스 초기화',
                  subtitle: '개발모드 전용 동작',
                  icon: Icons.delete,
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) => InitDatabaseDialog(),
                  ),
                ),
                const SizedBox(height: Spacing.xl),
              ],

              SectionHeader(title: t.settings_common_title),

              // TODO: 미구현 알림 기능
              if (kDebugMode)
                SwitchTile(
                  title: t.settings_common_notification_title,
                  subtitle: t.settings_common_notification_subtitle,
                  icon: Icons.notifications,
                  value: viewModel.appState.hasNotificationEnabled,
                  onChanged: viewModel.setNotificationEnabled,
                ),

              DialogTile(
                title: t.settings_common_theme_title,
                subtitle: t.settings_common_theme_subtitle,
                icon: Icons.dark_mode,
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => ThemeDialog(viewModel: viewModel),
                ),
              ),
              DialogTile(
                title: t.settings_common_color_theme_title,
                subtitle: t.settings_common_color_theme_subtitle,
                icon: Icons.color_lens,
                onTap: () => showDialog(
                  context: context,
                  builder: (_) => ColorThemeDialog(viewModel: viewModel),
                ),
              ),
              DialogTile(
                title: t.settings_common_language_title,
                subtitle: viewModel.appState.languageCode.displayName,
                icon: Icons.language,
                onTap: () => showDialog(
                  context: context,
                  builder: (_) => LanguageDialog(viewModel: viewModel),
                ),
              ),
              DialogTile(
                title: t.settings_common_font_family_title,
                subtitle: viewModel.appState.fontFamily.getDisplayName(context),
                icon: Icons.text_format,
                onTap: () => showDialog(
                  context: context,
                  builder: (_) => FontFamilyDialog(viewModel: viewModel),
                ),
              ),
              const SizedBox(height: Spacing.xl),
              SectionHeader(title: t.settings_data_title),
              // TODO: 미구현 데이터 백업
              if (kDebugMode) ...[
                SwitchTile(
                  title: t.settings_data_auto_sync_title,
                  subtitle: t.settings_data_auto_sync_subtitle,
                  icon: Icons.sync,
                  value: viewModel.appState.hasAutoSyncEnabled,
                  onChanged: viewModel.setAutoSyncEnabled,
                ),
                CardListTile(
                  title: t.settings_data_backup_title,
                  subtitle: t.settings_data_backup_subtitle,
                  icon: Icons.backup,
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) => BackupDialog(viewModel: viewModel),
                  ),
                ),
              ],

              CardListTile(
                title: t.settings_data_cache_cleanup_title,
                subtitle: t.settings_data_cache_cleanup_subtitle,
                icon: Icons.delete_sweep,
                onTap: () => showDialog(
                  context: context,
                  builder: (_) => ClearCacheDialog(viewModel: viewModel),
                ),
              ),
              const SizedBox(height: Spacing.xl),
              SectionHeader(title: t.settings_information_title),
              CardListTile(
                title: t.settings_information_app_title,
                subtitle: t.settings_information_app_subtitle,
                icon: Icons.info,
                onTap: () => showDialog(
                  context: context,
                  builder: (_) => AppInfoDialog(viewModel: viewModel),
                ),
              ),
              // TODO: 미구현 FAQ
              if (kDebugMode)
                CardListTile(
                  title: t.settings_information_faq_title,
                  subtitle: t.settings_information_faq_subtitle,
                  icon: Icons.help,
                  onTap: () {},
                ),

              CardListTile(
                title: t.settings_information_qna_title,
                subtitle: t.settings_information_qna_subtitle,
                icon: Icons.mail,
                onTap: () => showDialog(
                  context: context,
                  builder: (_) => ContactDialog(),
                ),
              ),
              const SizedBox(height: kBottomNavigationBarHeight * 3),
            ]),
          ),
        ),
      ],
    );
  }
}
