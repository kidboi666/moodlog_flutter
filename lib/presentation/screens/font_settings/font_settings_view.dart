import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/extensions/localization.dart';
import 'package:moodlog/data/data_source/local/database/database.dart';
import 'package:moodlog/data/repositories/analytics_repository_impl.dart';
import 'package:moodlog/data/repositories/local_backup_repository_impl.dart';
import 'package:moodlog/domain/use_cases/local_backup_use_case.dart';
import 'package:moodlog/presentation/screens/settings/settings_view_model.dart';
import 'package:provider/provider.dart';

part 'font_settings_content.dart';

class FontSettingsScreen extends StatelessWidget {
  const FontSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingsViewModel(
        appStateProvider: context.read(),
        settingsRepository: context.read(),
        userProvider: context.read(),
        tagUseCase: context.read(),
        analyticsRepository: AnalyticsRepositoryImpl(),
        localBackupUseCase: LocalBackupUseCase(
          localBackupRepository: LocalBackupRepositoryImpl(
            journalRepository: context.read(),
            tagRepository: context.read(),
            localUserRepository: context.read(),
            settingsRepository: context.read(),
            database: context.read<MoodLogDatabase>(),
          ),
        ),
      ),
      child: _FontSettingsContent(),
    );
  }
}
