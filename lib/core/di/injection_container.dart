import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../data/data_source/local/database/database.dart';
import '../../data/data_source/local/journal_local_data_source.dart';
import '../../data/data_source/local/tag_local_data_source.dart';
import '../../data/repositories/analytics_repository_impl.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/gemini_repository_impl.dart';
import '../../data/repositories/image_repository_impl.dart';
import '../../data/repositories/journal_repository_impl.dart';
import '../../data/repositories/location_repository_impl.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../data/repositories/tag_repository_impl.dart';
import '../../data/repositories/weather_repository_impl.dart';
import '../../domain/repositories/analytics_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/gemini_repository.dart';
import '../../domain/repositories/image_repository.dart';
import '../../domain/repositories/journal_repository.dart';
import '../../domain/repositories/location_repository.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/repositories/tag_repository.dart';
import '../../domain/repositories/weather_repository.dart';
import '../../domain/use_cases/auth_use_case.dart';
import '../../domain/use_cases/check_ai_usage_limit_use_case.dart';
import '../../domain/use_cases/gemini_use_case.dart';
import '../../domain/use_cases/get_current_location_use_case.dart';
import '../../domain/use_cases/journal_use_case.dart';
import '../../domain/use_cases/log_mood_entry_use_case.dart';
import '../../domain/use_cases/pick_image_use_case.dart';
import '../../domain/use_cases/settings_use_case.dart';
import '../../domain/use_cases/tag_use_case.dart';
import '../../domain/use_cases/weather_use_case.dart';
import '../../presentation/providers/ai_generation_provider.dart';
import '../../presentation/providers/app_state_provider.dart';
import '../../presentation/providers/user_provider.dart';

List<SingleChildWidget> createProviders() {
  return [
    ..._createInfrastructures(),
    ..._createDataSources(),
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

List<SingleChildWidget> _createDataSources() {
  return [
    ProxyProvider<MoodLogDatabase, JournalLocalDataSource>(
      update: (_, db, previous) => previous ?? JournalLocalDataSource(db: db),
    ),
    ProxyProvider<MoodLogDatabase, TagLocalDataSource>(
      update: (_, db, previous) => previous ?? TagLocalDataSource(db: db),
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
    Provider<JournalRepository>(
      create: (context) =>
          JournalRepositoryImpl(localDataSource: context.read()),
      lazy: false,
    ),
    Provider<TagRepository>(
      create: (context) => TagRepositoryImpl(localDataSource: context.read()),
      lazy: false,
    ),
    Provider<LocationRepository>(create: (_) => LocationRepositoryImpl()),
    Provider<WeatherRepository>(create: (_) => WeatherRepositoryImpl()),
    Provider<ImageRepository>(create: (_) => ImageRepositoryImpl()),
    Provider<AnalyticsRepository>(create: (_) => AnalyticsRepositoryImpl()),
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
    Provider<SettingsUseCase>(
      create: (context) => SettingsUseCase(settingsRepository: context.read()),
    ),
    Provider<GeminiUseCase>(
      create: (context) => GeminiUseCase(geminiRepository: context.read()),
    ),
    Provider<PickImageUseCase>(
      create: (context) => PickImageUseCase(imageRepository: context.read()),
    ),
    Provider<JournalUseCase>(
      create: (context) => JournalUseCase(journalRepository: context.read()),
    ),
    Provider<TagUseCase>(create: (context) => TagUseCase(context.read())),
    Provider<GetCurrentLocationUseCase>(
      create: (context) =>
          GetCurrentLocationUseCase(locationRepository: context.read()),
    ),
    Provider<CheckAiUsageLimitUseCase>(
      create: (context) =>
          CheckAiUsageLimitUseCase(settingsRepository: context.read()),
    ),
    Provider<WeatherUseCase>(
      create: (context) => WeatherUseCase(weatherRepository: context.read()),
    ),
    Provider<LogMoodEntryUseCase>(
      create: (context) =>
          LogMoodEntryUseCase(analyticsRepository: context.read()),
    ),
  ];
}
