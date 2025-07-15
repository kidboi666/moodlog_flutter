import 'package:moodlog/presentation/profile/viewmodel/profile_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../data/data_source/database.dart';
import '../../data/repositories/app_state_repository_impl.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/gemini_repository_impl.dart';
import '../../data/repositories/journal_repository_impl.dart';
import '../../domain/repositories/ai_generation_repository.dart';
import '../../domain/repositories/app_state_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/gemini_repository.dart';
import '../../domain/repositories/journal_repository.dart';
import '../../presentation/entries/view/entries_screen.dart';
import '../../presentation/entries/viewmodel/entries_viewmodel.dart';
import '../../presentation/home/view/home_screen.dart';
import '../../presentation/home/viewmodel/home_viewmodel.dart';
import '../../presentation/onboarding/viewmodel/onboarding_viewmodel.dart';
import '../../presentation/profile/view/profile_screen.dart';
import '../../presentation/settings/view/settings_screen.dart';
import '../../presentation/settings/viewmodel/settings_viewmodel.dart';
import '../../presentation/statistics/view/statistics_screen.dart';
import '../../presentation/statistics/viewmodel/statistics_viewmodel.dart';
import '../../presentation/write/view/write_screen.dart';
import '../../presentation/write/viewmodel/write_viewmodel.dart';

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
    ChangeNotifierProvider<AppStateRepository>(
      create: (context) => AppStateRepositoryImpl(),
    ),
    Provider<GeminiRepository>(
      create: (_) => GeminiRepositoryImpl.instance,
      lazy: false,
    ),
    ChangeNotifierProvider<AiGenerationRepository>(
      create: (context) => AiGenerationRepository(),
    ),
    ProxyProvider<MoodLogDatabase, JournalRepository>(
      update: (_, db, previous) => previous ?? JournalRepositoryImpl(db: db),
    ),
    ...createProvidersForViewModel(),
  ];
}

List<SingleChildWidget> createProvidersForViewModel() {
  return [
    ChangeNotifierProvider(
      lazy: true,
      create: (context) => OnboardingViewModel(
        appStateRepository: context.read(),
        authRepository: context.read(),
        totalSteps: 4,
      ),
      child: HomeScreen(),
    ),
    ChangeNotifierProvider(
      lazy: true,
      create: (context) => HomeViewModel(
        journalRepository: context.read(),
        appStateRepository: context.read(),
      ),
      child: HomeScreen(),
    ),
    ChangeNotifierProvider(
      lazy: true,
      create: (context) => EntriesViewModel(journalRepository: context.read()),
      child: EntriesScreen(),
    ),
    ChangeNotifierProvider(
      lazy: true,
      create: (context) =>
          StatisticsViewModel(journalRepository: context.read()),
      child: StatisticsScreen(),
    ),
    ChangeNotifierProvider(
      lazy: true,
      create: (context) => SettingsViewModel(
        appStateRepository: context.read(),
        journalRepository: context.read(),
        authRepository: context.read(),
      ),
      child: SettingsScreen(),
    ),
    ChangeNotifierProvider(
      lazy: true,
      create: (context) => WriteViewModel(
        appStateRepository: context.read(),
        journalRepository: context.read(),
        geminiRepository: context.read(),
        aiGenerationRepository: context.read(),
        totalSteps: 2,
      ),
      child: WriteScreen(),
    ),
    ChangeNotifierProvider(
      lazy: true,
      create: (context) => ProfileViewModel(authRepository: context.read()),
      child: ProfileScreen(),
    ),
  ];
}
