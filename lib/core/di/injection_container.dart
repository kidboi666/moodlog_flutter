import 'package:moodlog/data/repositories/gemini_repository_impl.dart';
import 'package:moodlog/domain/repositories/ai_generation_repository.dart';
import 'package:moodlog/domain/repositories/gemini_repository.dart';
import 'package:moodlog/presentation/view_models/entries/entries_viewmodel.dart';
import 'package:moodlog/presentation/view_models/home/home_viewmodel.dart';
import 'package:moodlog/presentation/view_models/settings/settings_viewmodel.dart';
import 'package:moodlog/presentation/view_models/statistics/statistics_viewmodel.dart';
import 'package:moodlog/presentation/views/entries/screen/entries_screen.dart';
import 'package:moodlog/presentation/views/home/screen/home_screen.dart';
import 'package:moodlog/presentation/views/statistics/screen/statistics_screen.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../data/data_source/database.dart';
import '../../data/repositories/app_state_repository_impl.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/journal_repository_impl.dart';
import '../../domain/repositories/app_state_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/journal_repository.dart';

List<SingleChildWidget> createProviders() {
  return [
    ChangeNotifierProvider<AuthRepository>(
      create: (context) => AuthRepositoryImpl(),
      lazy: false,
    ),
    Provider<MoodLogDatabase>(
      create: (_) => MoodLogDatabase(),
      dispose: (_, db) => db.close(),
      lazy: false,
    ),
    ChangeNotifierProxyProvider<MoodLogDatabase, AppStateRepository>(
      create: (context) {
        final db = context.read<MoodLogDatabase>();
        return AppStateRepositoryImpl(db: db);
      },
      update: (_, db, previous) => previous ?? AppStateRepositoryImpl(db: db),
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
      create: (context) => HomeViewModel(
        journalRepository: context.read(),
        appStateRepository: context.read(),
      ),
      child: HomeScreen(),
    ),
    ChangeNotifierProvider(
      create: (context) => EntriesViewModel(journalRepository: context.read()),
      child: EntriesScreen(),
    ),
    ChangeNotifierProvider(
      create: (context) =>
          StatisticsViewModel(journalRepository: context.read()),
      child: StatisticsScreen(),
    ),
    ChangeNotifierProvider(
      create: (context) => SettingsViewModel(
        appStateRepository: context.read(),
        journalRepository: context.read(),
        authRepository: context.read(),
      ),
    ),
  ];
}
