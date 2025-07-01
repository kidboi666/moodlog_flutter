import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moodlog/presentation/views/settings/widgets/dialog/init_db_dialog.dart';

import '../../../../core/constants/common.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../view_models/settings/settings_viewmodel.dart';
import '../widgets/card_list_tile.dart';
import '../widgets/dialog/app_info_dialog.dart';
import '../widgets/dialog/backup_dialog.dart';
import '../widgets/dialog/clear_cache_dialog.dart';
import '../widgets/dialog/color_theme_dialog.dart';
import '../widgets/dialog/contact_dialog.dart';
import '../widgets/dialog/init_storage_dialog.dart';
import '../widgets/dialog/language_dialog.dart';
import '../widgets/dialog/theme_dialog.dart';
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
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.settings_title)),
      body: Container(
        padding: Spacing.paddingHorizontal,
        child: ListenableBuilder(
          listenable: widget.viewModel,
          builder: (context, _) {
            return ListView(
              children: [
                if (kDebugMode) ...[
                  SectionHeader(title: '디버그'),
                  DialogTile(
                    title: '스토리지 초기화',
                    subtitle: '개발모드 전용 동작',
                    icon: Icons.delete,
                    onTap: () => widget.viewModel.showDialogWithWidget(
                      context,
                      InitStorageDialog(viewModel: widget.viewModel),
                    ),
                  ),
                  DialogTile(
                    title: '데이터베이스 초기화',
                    subtitle: '개발모드 전용 동작',
                    icon: Icons.delete,
                    onTap: () => widget.viewModel.showDialogWithWidget(
                      context,
                      InitDatabaseDialog(viewModel: widget.viewModel),
                    ),
                  ),
                ],

                SectionHeader(
                  title: AppLocalizations.of(context)!.settings_common_title,
                ),
                SwitchTile(
                  title: AppLocalizations.of(
                    context,
                  )!.settings_common_notification_title,
                  subtitle: AppLocalizations.of(
                    context,
                  )!.settings_common_notification_subtitle,
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
                  onTap: () => widget.viewModel.showDialogWithWidget(
                    context,
                    ThemeDialog(viewModel: widget.viewModel),
                  ),
                ),
                DialogTile(
                  title: AppLocalizations.of(
                    context,
                  )!.settings_common_color_theme_title,
                  subtitle: AppLocalizations.of(
                    context,
                  )!.settings_common_color_theme_subtitle,
                  icon: Icons.color_lens,
                  onTap: () => widget.viewModel.showDialogWithWidget(
                    context,
                    ColorThemeDialog(viewModel: widget.viewModel),
                  ),
                ),
                DialogTile(
                  title: AppLocalizations.of(
                    context,
                  )!.settings_common_language_title,
                  subtitle: widget.viewModel.appState.languageCode.displayName,
                  icon: Icons.language,
                  onTap: () => widget.viewModel.showDialogWithWidget(
                    context,
                    LanguageDialog(viewModel: widget.viewModel),
                  ),
                ),
                const SizedBox(height: 40),
                SectionHeader(
                  title: AppLocalizations.of(context)!.settings_data_title,
                ),
                SwitchTile(
                  title: AppLocalizations.of(
                    context,
                  )!.settings_data_auto_sync_title,
                  subtitle: AppLocalizations.of(
                    context,
                  )!.settings_data_auto_sync_subtitle,
                  icon: Icons.sync,
                  value: widget.viewModel.appState.hasAutoSyncEnabled,
                  onChanged: widget.viewModel.setAutoSyncEnabled,
                ),
                CardListTile(
                  title: AppLocalizations.of(
                    context,
                  )!.settings_data_backup_title,
                  subtitle: AppLocalizations.of(
                    context,
                  )!.settings_data_backup_subtitle,
                  icon: Icons.backup,
                  onTap: () => widget.viewModel.showDialogWithWidget(
                    context,
                    BackupDialog(viewModel: widget.viewModel),
                  ),
                ),
                CardListTile(
                  title: AppLocalizations.of(
                    context,
                  )!.settings_data_cash_cleanup_title,
                  subtitle: AppLocalizations.of(
                    context,
                  )!.settings_data_cash_cleanup_subtitle,
                  icon: Icons.delete_sweep,
                  onTap: () => widget.viewModel.showDialogWithWidget(
                    context,
                    ClearCacheDialog(viewModel: widget.viewModel),
                  ),
                ),
                const SizedBox(height: 20),
                SectionHeader(
                  title: AppLocalizations.of(
                    context,
                  )!.settings_information_title,
                ),
                CardListTile(
                  title: AppLocalizations.of(
                    context,
                  )!.settings_information_app_title,
                  subtitle: AppLocalizations.of(
                    context,
                  )!.settings_information_app_subtitle,
                  icon: Icons.info,
                  onTap: () => widget.viewModel.showDialogWithWidget(
                    context,
                    AppInfoDialog(viewModel: widget.viewModel),
                  ),
                ),
                CardListTile(
                  title: AppLocalizations.of(
                    context,
                  )!.settings_information_faq_title,
                  subtitle: AppLocalizations.of(
                    context,
                  )!.settings_information_faq_subtitle,
                  icon: Icons.help,
                  onTap: () {},
                ),
                CardListTile(
                  title: AppLocalizations.of(
                    context,
                  )!.settings_information_qna_title,
                  subtitle: AppLocalizations.of(
                    context,
                  )!.settings_information_qna_subtitle,
                  icon: Icons.mail,
                  onTap: () => widget.viewModel.showDialogWithWidget(
                    context,
                    ContactDialog(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
