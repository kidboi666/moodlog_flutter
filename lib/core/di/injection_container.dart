import 'package:local_auth/local_auth.dart';
import 'package:moodlog/data/data_source/local/activity_local_data_source.dart';
import 'package:moodlog/data/data_source/local/check_in_local_data_source.dart';
import 'package:moodlog/data/data_source/local/database/database.dart';
import 'package:moodlog/data/data_source/local/emotion_local_data_source.dart';
import 'package:moodlog/data/data_source/local/journal_local_data_source.dart';
import 'package:moodlog/data/data_source/local/shared_preferences_local_data_source.dart';
import 'package:moodlog/data/repositories/activity_repository_impl.dart';
import 'package:moodlog/data/repositories/analytics_repository_impl.dart';
import 'package:moodlog/data/repositories/check_in_repository_impl.dart';
import 'package:moodlog/data/repositories/emotion_repository_impl.dart';
import 'package:moodlog/data/repositories/image_repository_impl.dart';
import 'package:moodlog/data/repositories/journal_repository_impl.dart';
import 'package:moodlog/data/repositories/local_backup_repository_impl.dart';
import 'package:moodlog/data/repositories/local_user_repository_impl.dart';
import 'package:moodlog/data/repositories/location_repository_impl.dart';
import 'package:moodlog/data/repositories/settings_repository_impl.dart';
import 'package:moodlog/data/repositories/weather_repository_impl.dart';
import 'package:moodlog/domain/repositories/activity_repository.dart';
import 'package:moodlog/domain/repositories/analytics_repository.dart';
import 'package:moodlog/domain/repositories/check_in_repository.dart';
import 'package:moodlog/domain/repositories/emotion_repository.dart';
import 'package:moodlog/domain/repositories/image_repository.dart';
import 'package:moodlog/domain/repositories/journal_repository.dart';
import 'package:moodlog/domain/repositories/local_backup_repository.dart';
import 'package:moodlog/domain/repositories/local_user_repository.dart';
import 'package:moodlog/domain/repositories/location_repository.dart';
import 'package:moodlog/domain/repositories/settings_repository.dart';
import 'package:moodlog/domain/repositories/weather_repository.dart';
import 'package:moodlog/domain/use_cases/activity_use_case.dart';
import 'package:moodlog/domain/use_cases/check_in_use_case.dart';
import 'package:moodlog/domain/use_cases/emotion_use_case.dart';
import 'package:moodlog/domain/use_cases/get_current_location_use_case.dart';
import 'package:moodlog/domain/use_cases/journal_use_case.dart';
import 'package:moodlog/domain/use_cases/local_backup_use_case.dart';
import 'package:moodlog/domain/use_cases/local_user_use_case.dart';
import 'package:moodlog/domain/use_cases/observe_journal_list_use_case.dart';
import 'package:moodlog/domain/use_cases/settings_use_case.dart';
import 'package:moodlog/domain/use_cases/weather_use_case.dart';
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
    ProxyProvider<MoodLogDatabase, CheckInLocalDataSource>(
      update: (_, db, previous) => previous ?? CheckInLocalDataSource(db),
    ),
    ProxyProvider<MoodLogDatabase, ActivityLocalDataSource>(
      update: (_, db, previous) => previous ?? ActivityLocalDataSource(db: db),
    ),
    ProxyProvider<MoodLogDatabase, EmotionLocalDataSource>(
      update: (_, db, previous) => previous ?? EmotionLocalDataSource(db),
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
    Provider<JournalRepository>(
      create: (context) =>
          JournalRepositoryImpl(localDataSource: context.read()),
      lazy: false,
    ),
    Provider<CheckInRepository>(
      create: (context) => CheckInRepositoryImpl(
        checkInLocalDataSource: context.read(),
        tagLocalDataSource: context.read(),
        emotionLocalDataSource: context.read(),
      ),
      lazy: false,
    ),
    Provider<ActivityRepository>(
      create: (context) =>
          ActivityRepositoryImpl(localDataSource: context.read()),
      lazy: false,
    ),
    Provider<EmotionRepository>(
      create: (context) => EmotionRepositoryImpl(context.read()),
      lazy: false,
    ),
    Provider<LocationRepository>(create: (_) => LocationRepositoryImpl()),
    Provider<WeatherRepository>(create: (_) => WeatherRepositoryImpl()),
    Provider<ImageRepository>(create: (_) => ImageRepositoryImpl()),
    Provider<AnalyticsRepository>(create: (_) => AnalyticsRepositoryImpl()),
    Provider<LocalBackupRepository>(
      create: (context) => LocalBackupRepositoryImpl(
        journalRepository: context.read(),
        tagRepository: context.read(),
        localUserRepository: context.read(),
        settingsRepository: context.read(),
        database: context.read(),
      ),
    ),
  ];
}

List<SingleChildWidget> _createStateProviders() {
  return [
    ChangeNotifierProvider<AppStateProvider>(
      create: (context) => AppStateProvider(settingsUseCase: context.read()),
      lazy: false,
    ),
    ChangeNotifierProvider<UserProvider>(
      create: (context) => UserProvider(localUserUseCase: context.read()),
    ),
  ];
}

List<SingleChildWidget> _createUseCases() {
  return [
    Provider<SettingsUseCase>(
      create: (context) => SettingsUseCase(settingsRepository: context.read()),
    ),
    Provider<JournalUseCase>(
      create: (context) => JournalUseCase(journalRepository: context.read()),
    ),
    Provider<CheckInUseCase>(
      create: (context) => CheckInUseCase(checkInRepository: context.read()),
    ),
    Provider<ActivityUseCase>(
      create: (context) => ActivityUseCase(context.read()),
    ),
    Provider<GetCurrentLocationUseCase>(
      create: (context) =>
          GetCurrentLocationUseCase(locationRepository: context.read()),
    ),
    Provider<WeatherUseCase>(
      create: (context) => WeatherUseCase(repository: context.read()),
    ),
    Provider<ObserveJournalListUseCase>(
      create: (context) =>
          ObserveJournalListUseCase(journalRepository: context.read()),
    ),
    Provider<EmotionUseCase>(
      create: (context) => EmotionUseCase(context.read()),
    ),
    Provider<LocalBackupUseCase>(
      create: (context) =>
          LocalBackupUseCase(localBackupRepository: context.read()),
    ),
    Provider<LocalUserUseCase>(
      create: (context) =>
          LocalUserUseCase(localUserRepository: context.read()),
    ),
  ];
}
