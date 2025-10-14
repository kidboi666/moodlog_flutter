import 'package:local_auth/local_auth.dart';
import 'package:moodlog/data/data_source/local/database/database.dart';
import 'package:moodlog/data/data_source/local/journal_local_data_source.dart';
import 'package:moodlog/data/data_source/local/shared_preferences_local_data_source.dart';
import 'package:moodlog/data/data_source/local/tag_local_data_source.dart';
import 'package:moodlog/data/repositories/analytics_repository_impl.dart';
import 'package:moodlog/data/repositories/gemini_repository_impl.dart';
import 'package:moodlog/data/repositories/image_repository_impl.dart';
import 'package:moodlog/data/repositories/journal_repository_impl.dart';
import 'package:moodlog/data/repositories/local_user_repository_impl.dart';
import 'package:moodlog/data/repositories/location_repository_impl.dart';
import 'package:moodlog/data/repositories/settings_repository_impl.dart';
import 'package:moodlog/data/repositories/tag_repository_impl.dart';
import 'package:moodlog/data/repositories/weather_repository_impl.dart';
import 'package:moodlog/domain/repositories/analytics_repository.dart';
import 'package:moodlog/domain/repositories/gemini_repository.dart';
import 'package:moodlog/domain/repositories/image_repository.dart';
import 'package:moodlog/domain/repositories/journal_repository.dart';
import 'package:moodlog/domain/repositories/local_user_repository.dart';
import 'package:moodlog/domain/repositories/location_repository.dart';
import 'package:moodlog/domain/repositories/settings_repository.dart';
import 'package:moodlog/domain/repositories/tag_repository.dart';
import 'package:moodlog/domain/repositories/weather_repository.dart';
import 'package:moodlog/domain/use_cases/check_ai_usage_use_case.dart';
import 'package:moodlog/domain/use_cases/gemini_use_case.dart';
import 'package:moodlog/domain/use_cases/get_current_location_use_case.dart';
import 'package:moodlog/domain/use_cases/journal_use_case.dart';
import 'package:moodlog/domain/use_cases/log_mood_entry_use_case.dart';
import 'package:moodlog/domain/use_cases/observe_journal_list_use_case.dart';
import 'package:moodlog/domain/use_cases/pick_and_save_image_use_case.dart';
import 'package:moodlog/domain/use_cases/settings_use_case.dart';
import 'package:moodlog/domain/use_cases/tag_use_case.dart';
import 'package:moodlog/domain/use_cases/weather_use_case.dart';
import 'package:moodlog/presentation/providers/ai_generation_provider.dart';
import 'package:moodlog/presentation/providers/app_state_provider.dart';
import 'package:moodlog/presentation/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

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
    Provider<LocalAuthentication>(create: (_) => LocalAuthentication()),
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
    Provider<SharedPreferencesLocalDataSource>(
      create: (_) => SharedPreferencesLocalDataSource(),
    ),
  ];
}

List<SingleChildWidget> _createRepositories() {
  return [
    Provider<SettingsRepository>(
      create: (context) => SettingsRepositoryImpl(
        localDataSource: context.read(),
        db: context.read(),
      ),
      lazy: false,
    ),
    Provider<LocalUserRepository>(
      create: (context) =>
          LocalUserRepositoryImpl(localDataSource: context.read()),
      lazy: false,
    ),
    Provider<GeminiRepository>(
      create: (_) => GeminiRepositoryImpl.instance,
      lazy: false,
    ),
    Provider<JournalRepository>(
      create: (context) => JournalRepositoryImpl(
        localDataSource: context.read(),
        tagLocalDataSource: context.read(),
      ),
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
      create: (context) => UserProvider(localUserRepository: context.read()),
    ),
    ChangeNotifierProvider<AiGenerationProvider>(
      create: (context) => AiGenerationProvider(),
    ),
  ];
}

List<SingleChildWidget> _createUseCases() {
  return [
    Provider<SettingsUseCase>(
      create: (context) => SettingsUseCase(settingsRepository: context.read()),
    ),
    Provider<GeminiUseCase>(
      create: (context) => GeminiUseCase(geminiRepository: context.read()),
    ),
    Provider<PickAndSaveImageUseCase>(
      create: (context) => PickAndSaveImageUseCase(imageRepository: context.read()),
    ),
    Provider<JournalUseCase>(
      create: (context) => JournalUseCase(journalRepository: context.read()),
    ),
    Provider<TagUseCase>(create: (context) => TagUseCase(context.read())),
    Provider<GetCurrentLocationUseCase>(
      create: (context) =>
          GetCurrentLocationUseCase(locationRepository: context.read()),
    ),
    Provider<CheckAiUsageUseCase>(
      create: (context) =>
          CheckAiUsageUseCase(settingsRepository: context.read()),
    ),
    Provider<WeatherUseCase>(
      create: (context) => WeatherUseCase(repository: context.read()),
    ),
    Provider<LogMoodEntryUseCase>(
      create: (context) =>
          LogMoodEntryUseCase(analyticsRepository: context.read()),
    ),
    Provider<ObserveJournalListUseCase>(
      create: (context) =>
          ObserveJournalListUseCase(journalRepository: context.read()),
    ),
  ];
}
