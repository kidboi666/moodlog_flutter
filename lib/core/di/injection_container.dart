import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../data/data_source/database.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/gemini_repository_impl.dart';
import '../../data/repositories/journal_repository_impl.dart';
import '../../data/repositories/location_repository_impl.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../data/repositories/tag_repository_impl.dart';
import '../../data/repositories/weather_repository_impl.dart';
import '../../domain/repositories/app_state_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/gemini_repository.dart';
import '../../domain/repositories/journal_repository.dart';
import '../../domain/repositories/location_repository.dart';
import '../../domain/repositories/tag_repository.dart';
import '../../domain/repositories/weather_repository.dart';
import '../../domain/use_cases/ai/check_ai_usage_limit_use_case.dart';
import '../../domain/use_cases/auth/auth_use_case.dart';
import '../../domain/use_cases/image/pick_image_usecase.dart';
import '../../domain/use_cases/journal_use_case.dart';
import '../../domain/use_cases/location_use_case.dart';
import '../../domain/use_cases/tag_use_case.dart';
import '../../domain/use_cases/weather_use_case.dart';
import '../../presentation/providers/ai_generation_provider.dart';
import '../../presentation/providers/app_state_provider.dart';
import '../../presentation/providers/user_provider.dart';

List<SingleChildWidget> createProviders() {
  return [
    ..._createInfrastructures(),
    ..._createRepositories(),
    ..._createUseCases(),
    ..._createStateProviders(),
  ];
}

List<SingleChildWidget> _createInfrastructures() {
  return [
    Provider<MoodLogDatabase>(
      create: (_) => MoodLogDatabase(),
      dispose: (_, db) => db.close(),
      lazy: false,
    ),
  ];
}

List<SingleChildWidget> _createRepositories() {
  return [
    Provider<SettingsRepository>(
      create: (_) => SettingsRepositoryImpl(),
      lazy: false,
    ),
    Provider<AuthRepository>(
      create: (context) => AuthRepositoryImpl(),
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
    ProxyProvider<MoodLogDatabase, TagRepository>(
      update: (_, db, previous) => previous ?? TagRepositoryImpl(db),
      lazy: false,
    ),
    Provider<LocationRepository>(create: (_) => LocationRepositoryImpl()),
    Provider<WeatherRepository>(create: (_) => WeatherRepositoryImpl()),
  ];
}

List<SingleChildWidget> _createStateProviders() {
  return [
    ChangeNotifierProvider<AppStateProvider>(
      create: (context) => AppStateProvider(settingsRepository: context.read()),
      lazy: false,
    ),
    ChangeNotifierProvider<UserProvider>(
      create: (context) => UserProvider(authRepository: context.read()),
    ),
    ChangeNotifierProvider<AiGenerationProvider>(
      create: (context) => AiGenerationProvider(),
    ),
  ];
}

List<SingleChildWidget> _createUseCases() {
  return [
    Provider<AuthUseCase>(
      create: (context) => AuthUseCase(authRepository: context.read()),
    ),
    Provider<PickImageUseCase>(create: (_) => PickImageUseCase()),
    Provider<JournalUseCase>(
      create: (context) => JournalUseCase(journalRepository: context.read()),
    ),
    Provider<TagUseCase>(create: (context) => TagUseCase(context.read())),
    Provider<LocationUseCase>(
      create: (context) => LocationUseCase(locationRepository: context.read()),
    ),
    Provider<CheckAiUsageLimitUseCase>(
      create: (context) =>
          CheckAiUsageLimitUseCase(settingsRepository: context.read()),
    ),
    Provider<WeatherUseCase>(
      create: (context) => WeatherUseCase(weatherRepository: context.read()),
    ),
  ];
}
