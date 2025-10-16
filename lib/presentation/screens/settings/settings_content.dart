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

                SwitchTile(
                  title: t.settings_common_app_lock_title,
                  subtitle: t.settings_common_app_lock_subtitle,
                  icon: Icons.lock,
                  value: context.select(
                    (SettingsViewModel vm) => vm.appState.isAppLockEnabled,
                  ),
                  onChanged: (enabled) async {
                    if (enabled) {
                      _showPinCreateToEnableLock(context, viewModel);
                    } else {
                      _showPinVerifyToDisableLock(context, viewModel);
                    }
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
                MenuListTile(
                  title: t.settings_common_font_family_title,
                  subtitle: viewModel.appState.fontType.displayName,
                  icon: Icons.text_format,
                  onTap: () => context.push(Routes.fontSettings),
                ),
                DialogTile(
                  title: t.settings_common_time_format_title,
                  subtitle: t.settings_common_time_format_subtitle,
                  icon: Icons.access_time,
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) => TimeFormatDialog(viewModel: viewModel),
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
                MenuListTile(
                  title: t.settings_data_export_title,
                  subtitle: t.settings_data_export_subtitle,
                  icon: Icons.download,
                  onTap: () async {
                    _showLoadingDialog(context, t.settings_data_export_progress);
                    try {
                      final filePath = await viewModel.exportLocalBackup();
                      if (context.mounted) {
                        context.pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              t.settings_data_export_success(
                                filePath.split('/').last,
                              ),
                            ),
                          ),
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        context.pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(t.settings_data_export_failed(e.toString())),
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.error,
                          ),
                        );
                      }
                    }
                  },
                ),
                MenuListTile(
                  title: t.settings_data_import_title,
                  subtitle: t.settings_data_import_subtitle,
                  icon: Icons.upload,
                  onTap: () async {
                    try {
                      final result = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['json'],
                      );

                      if (result != null && result.files.single.path != null) {
                        final filePath = result.files.single.path!;

                        if (context.mounted) {
                          _showLoadingDialog(context, t.settings_data_import_progress);
                        }

                        await viewModel.importLocalBackup(filePath);

                        if (context.mounted) {
                          context.pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(t.settings_data_import_success)),
                          );
                        }
                      }
                    } catch (e) {
                      if (context.mounted) {
                        context.pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(t.settings_data_import_failed(e.toString())),
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.error,
                          ),
                        );
                      }
                    }
                  },
                ),

                const SizedBox(height: kBottomNavigationBarHeight * 6),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

void _showLoadingDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              Text(message),
            ],
          ),
        ),
      );
    },
  );
}

void _showPinCreateToEnableLock(
  BuildContext context,
  SettingsViewModel viewModel,
) {
  final t = AppLocalizations.of(context)!;

  screenLockCreate(
    context: context,
    title: Text(t.lockScreenTitle),
    confirmTitle: Text(t.lockScreenConfirmTitle),
    digits: 4,
    onConfirmed: (pin) async {
      await viewModel.savePin(pin);
      await viewModel.setAppLockWithType(true, LockType.pin);
      if (context.mounted) {
        context.pop();
        context.read<AppStateProvider>().setAuthenticated(true);
      }
    },
  );
}

void _showPinVerifyToDisableLock(
  BuildContext context,
  SettingsViewModel viewModel,
) {
  final t = AppLocalizations.of(context)!;

  screenLock(
    context: context,
    correctString: '0000',
    title: Text(t.lockScreenTitle),
    canCancel: true,
    onCancelled: () => context.pop(),
    onUnlocked: () async {
      context.pop();
      await viewModel.setAppLockWithType(false, LockType.none);
      await viewModel.deletePin();
      if (context.mounted) {
        context.read<AppStateProvider>().setAuthenticated(true);
      }
    },
    onValidate: (pin) async {
      final isValid = await viewModel.verifyPin(pin);
      return isValid;
    },
    onError: (_) {},
  );
}
