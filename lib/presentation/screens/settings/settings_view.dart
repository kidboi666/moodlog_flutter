import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/extensions/localization.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/data/data_source/local/journal_local_data_source.dart';
import 'package:moodlog/data/repositories/analytics_repository_impl.dart';
import 'package:moodlog/data/repositories/backup_repository_impl.dart';
import 'package:moodlog/presentation/providers/app_state_provider.dart';
import 'package:moodlog/presentation/screens/settings/settings_view_model.dart';
import 'package:moodlog/presentation/screens/settings/widgets/dialog/ai_personality_dialog.dart';
import 'package:moodlog/presentation/screens/settings/widgets/dialog/font_family_dialog.dart';
import 'package:moodlog/presentation/screens/settings/widgets/dialog/init_db_dialog.dart';
import 'package:moodlog/presentation/screens/settings/widgets/dialog/init_storage_dialog.dart';
import 'package:moodlog/presentation/screens/settings/widgets/dialog/language_dialog.dart';
import 'package:moodlog/presentation/screens/settings/widgets/dialog/theme_dialog.dart';
import 'package:moodlog/presentation/screens/settings/widgets/dialog_tile.dart';
import 'package:moodlog/presentation/screens/settings/widgets/menu_list_tile.dart';
import 'package:moodlog/presentation/screens/settings/widgets/section_header.dart';
import 'package:moodlog/presentation/screens/settings/widgets/switch_tile.dart';
import 'package:moodlog/presentation/widgets/glower.dart';
import 'package:provider/provider.dart';

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
        backupRepository: BackupRepositoryImpl(
          firestore: FirebaseFirestore.instance,
          localDataSource: context.read<JournalLocalDataSource>(),
        ),
      ),
      child: _SettingsScreenContent(),
    );
  }
}
