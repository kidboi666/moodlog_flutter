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
import '../../domain/use_cases/image/pick_image_use_case.dart';
import '../providers/app_state_provider.dart';

List<SingleChildWidget> createProviders() {
  return [
    Provider<MoodLogDatabase>(
      create: (_) => MoodLogDatabase(),
      dispose: (_, db) => db.close(),
      lazy: false,
    ),
    ChangeNotifierProvider<SettingsRepository>(
      create: (_) => SettingsRepositoryImpl(),
      lazy: false,
    ),
    ChangeNotifierProvider<AuthRepository>(
      create: (context) => AuthRepositoryImpl(),
      lazy: false,
    ),
    ChangeNotifierProvider<AppStateProvider>(
      create: (context) => AppStateProvider(settingsRepository: context.read()),
      lazy: false,
    ),
    Provider<GeminiRepository>(
      create: (_) => GeminiRepositoryImpl.instance,
      lazy: false,
    ),
    ProxyProvider<MoodLogDatabase, JournalRepository>(
      update: (_, db, previous) => previous ?? JournalRepositoryImpl(db: db),
      lazy: false,
    ),
    ChangeNotifierProvider<AiGenerationRepository>(
      create: (_) => AiGenerationRepository(),
    ),
    ..._createUseCases(),
  ];
}

List<SingleChildWidget> _createUseCases() {
  return [Provider<PickImageUseCase>(create: (_) => PickImageUseCase())];
}
