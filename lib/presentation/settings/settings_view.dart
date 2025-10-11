import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/common.dart';
import '../../core/extensions/localization.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/ui/widgets/glower.dart';
import '../../data/repositories/analytics_repository_impl.dart';
import 'settings_view_model.dart';
import 'widgets/dialog/ai_personality_dialog.dart';
import 'widgets/dialog/backup_dialog.dart';
import 'widgets/dialog/font_family_dialog.dart';
import 'widgets/dialog/init_db_dialog.dart';
import 'widgets/dialog/init_storage_dialog.dart';
import 'widgets/dialog/language_dialog.dart';
import 'widgets/dialog/tag_management_dialog.dart';
import 'widgets/dialog/theme_dialog.dart';
import 'widgets/dialog_tile.dart';
import 'widgets/menu_list_tile.dart';
import 'widgets/section_header.dart';
import 'widgets/switch_tile.dart';

part 'settings_content.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingsViewModel(
        appStateProvider: context.read(),
        settingsRepository: context.read(),
        userProvider: context.read(),
        tagUseCase: context.read(),
        analyticsRepository: AnalyticsRepositoryImpl(),
      ),
      child: _SettingsScreenContent(),
    );
  }
}
