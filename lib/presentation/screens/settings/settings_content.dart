part of 'settings_view.dart';

class _SettingsScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final viewModel = context.read<SettingsViewModel>();
    return Scaffold(
      appBar: AppBar(title: Text(t.settings_title)),
      body: Glower(
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

                if (kDebugMode) ...[
                  SwitchTile(
                    title: t.settings_common_notification_title,
                    subtitle: t.settings_common_notification_subtitle,
                    icon: Icons.notifications,
                    value: viewModel.appState.hasNotificationEnabled,
                    onChanged: viewModel.setNotificationEnabled,
                  ),
                ],

                Consumer<SettingsViewModel>(
                  builder: (context, viewModel, child) {
                    final isProUser = viewModel.appState.isProUser;
                    return GestureDetector(
                      onTap: () {
                        if (!isProUser) {
                          _showProFeatureDialog(context);
                        }
                      },
                      child: AbsorbPointer(
                        absorbing: !isProUser,
                        child: SwitchTile(
                          title: t.settings_common_app_lock_title,
                          subtitle: t.settings_common_app_lock_subtitle,
                          icon: Icons.lock,
                          value: isProUser && viewModel.appState.isAppLockEnabled,
                          onChanged: (value) {
                            if (isProUser) {
                              viewModel.setAppLockEnabled(value);
                            }
                          },
                          trailing: isProUser
                              ? null
                              : const Icon(Icons.workspace_premium, color: Colors.amber),
                        ),
                      ),
                    );
                  },
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
                  subtitle: viewModel.appState.fontFamily.getDisplayName(
                    context,
                  ),
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

                if (kDebugMode) ...[
                  SectionHeader(title: t.settings_data_title),
                  SwitchTile(
                    title: t.settings_data_auto_sync_title,
                    subtitle: t.settings_data_auto_sync_subtitle,
                    icon: Icons.sync,
                    value: viewModel.appState.hasAutoSyncEnabled,
                    onChanged: viewModel.setAutoSyncEnabled,
                  ),
                  MenuListTile(
                    title: t.settings_data_backup_title,
                    subtitle: t.settings_data_backup_subtitle,
                    icon: Icons.backup,
                    onTap: () => showDialog(
                      context: context,
                      builder: (_) => BackupDialog(viewModel: viewModel),
                    ),
                  ),

                  MenuListTile(
                    title: t.tags_manage_title,
                    subtitle: t.tags_manage_subtitle,
                    icon: Icons.label,
                    onTap: () => showDialog(
                      context: context,
                      builder: (_) => TagManagementDialog(viewModel: viewModel),
                    ),
                  ),
                ],

                const SizedBox(height: kBottomNavigationBarHeight * 6),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

void _showProFeatureDialog(BuildContext context) {
  final t = AppLocalizations.of(context)!;
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('👑 ${t.proFeatureDialogTitle}'),
      content: Text(t.proFeatureDialogContent),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.common_confirm_cancel),
        ),
        ElevatedButton(
          onPressed: () {
            // TODO: Navigate to purchase screen
            Navigator.of(context).pop();
          },
          child: Text(t.proFeatureDialogUpgradeButton),
        ),
      ],
    ),
  );
}
