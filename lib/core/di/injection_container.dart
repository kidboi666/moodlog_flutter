import 'package:moodlog/domain/use_cases/journal/delete_journal_use_case.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../data/data_source/database.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/gemini_repository_impl.dart';
import '../../data/repositories/journal_repository_impl.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../data/repositories/location_repository_impl.dart';
import '../../domain/repositories/ai_generation_repository.dart';
import '../../domain/repositories/app_state_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/gemini_repository.dart';
import '../../domain/repositories/journal_repository.dart';
import '../../domain/repositories/location_repository.dart';
import '../../domain/use_cases/auth/auth_use_case.dart';
import '../../domain/use_cases/image/pick_image_usecase.dart';
import '../../domain/use_cases/location/get_current_location_use_case.dart';
import '../providers/app_state_provider.dart';
import '../providers/user_provider.dart';

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
    ChangeNotifierProvider<UserProvider>(
      create: (context) => UserProvider(authRepository: context.read()),
    ),
    Provider<LocationRepository>(
      create: (_) => LocationRepositoryImpl(),
    ),
    ..._createUseCases(),
  ];
}

List<SingleChildWidget> _createUseCases() {
  return [
    Provider<AuthUseCase>(
      create: (context) => AuthUseCase(authRepository: context.read()),
    ),
    Provider<PickImageUseCase>(create: (_) => PickImageUseCase()),
    Provider<DeleteJournalUseCase>(
      create: (context) =>
          DeleteJournalUseCase(journalRepository: context.read()),
    ),
    Provider<GetCurrentLocationUseCase>(
      create: (context) =>
          GetCurrentLocationUseCase(locationRepository: context.read()),
    ),
  ];
}
