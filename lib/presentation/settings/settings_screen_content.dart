part of 'settings_screen.dart';

class _SettingsScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final viewModel = Provider.of<SettingsViewModel>(context);
    return Glower(
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              const SizedBox(height: Spacing.xl),

              if (kDebugMode) ...[
                SectionHeader(title: t.settings_developer_options),
                DialogTile(
                  title: t.dialog_storage_init_title,
                  subtitle: t.settings_developer_mode_only,
                  icon: Icons.delete,
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) => InitStorageDialog(viewModel: viewModel),
                  ),
                ),
                DialogTile(
                  title: t.dialog_database_init_title,
                  subtitle: t.settings_developer_mode_only,
                  icon: Icons.delete,
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) => InitDatabaseDialog(),
                  ),
                ),
                const SizedBox(height: Spacing.xl),
              ],

              SectionHeader(title: t.settings_common_title),

              // TODO: 알림 On/Off 기능
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

              SectionHeader(title: t.settings_ai_section_title),
              DialogTile(
                title: t.settings_ai_personality_title,
                subtitle: viewModel.appState.aiPersonality.getTitle(context),
                icon: Icons.psychology,
                onTap: () => showDialog(
                  context: context,
                  builder: (_) => AiPersonalityDialog(viewModel: viewModel),
                ),
              ),
              const SizedBox(height: Spacing.xl),

              SectionHeader(title: t.settings_data_title),
              // TODO: 데이터 자동 백업 On/Off 기능
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
                title: t.tags_manage_title,
                subtitle: t.tags_manage_subtitle,
                icon: Icons.label,
                onTap: () => showDialog(
                  context: context,
                  builder: (_) => const TagManagementDialog(),
                ),
              ),
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
              // TODO: FAQ 웹뷰 이동 기능
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
        ],
      ),
    );
  }
}
