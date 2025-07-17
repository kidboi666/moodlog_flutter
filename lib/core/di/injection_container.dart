import 'package:moodlog/core/providers/app_state_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../data/data_source/database.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/gemini_repository_impl.dart';
import '../../data/repositories/journal_repository_impl.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../domain/repositories/ai_generation_repository.dart';
import '../../domain/repositories/app_state_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/gemini_repository.dart';
import '../../domain/repositories/journal_repository.dart';

List<SingleChildWidget> createProviders() {
  return [
    ChangeNotifierProvider<AuthRepository>(
      create: (context) => AuthRepositoryImpl(),
    ),
    Provider<MoodLogDatabase>(
      create: (_) => MoodLogDatabase(),
      dispose: (_, db) => db.close(),
      lazy: false,
    ),
    ChangeNotifierProvider<SettingsRepository>(
      create: (_) => SettingsRepositoryImpl(),
    ),
    ChangeNotifierProvider<AppStateProvider>(
      create: (context) => AppStateProvider(settingsRepository: context.read()),
    ),
    Provider<GeminiRepository>(
      create: (_) => GeminiRepositoryImpl.instance,
      lazy: false,
    ),
    ChangeNotifierProvider<AiGenerationRepository>(
      create: (_) => AiGenerationRepository(),
    ),
    ProxyProvider<MoodLogDatabase, JournalRepository>(
      update: (_, db, previous) => previous ?? JournalRepositoryImpl(db: db),
    ),
  ];
}
