import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'core/l10n/app_localizations.dart';
import 'core/theme/theme.dart';
import 'data/data_source/database.dart';
import 'data/repositories/app_state_repository_impl.dart';
import 'data/repositories/journal_repository_impl.dart';
import 'domain/repositories/app_state_repository.dart';
import 'domain/repositories/journal_repository.dart';
import 'router/router.dart';

void main() {
  Logger.root.level = Level.ALL;
  runApp(
    MultiProvider(providers: _createProviders(), child: const MoodLogApp()),
  );
}

class MoodLogApp extends StatefulWidget {
  const MoodLogApp({super.key});

  @override
  State<MoodLogApp> createState() => _MoodLogAppState();
}

class _MoodLogAppState extends State<MoodLogApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = router(context.read<AppStateRepository>());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateRepository>(
      builder: (context, appStateRepo, child) {
        final appState = appStateRepo.appState;
        return MaterialApp.router(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [Locale('ko')],
          theme: AppTheme.lightTheme(appState.colorTheme),
          darkTheme: AppTheme.darkTheme(appState.colorTheme),
          themeMode: appState.themeMode,
          routerConfig: _router,
        );
      },
    );
  }
}

List<SingleChildWidget> _createProviders() {
  return [
    Provider<MoodLogDatabase>(
      create: (_) => MoodLogDatabase(),
      dispose: (_, db) => db.close(),
      lazy: false,
    ),
    ProxyProvider<MoodLogDatabase, JournalRepository>(
      update: (_, db, previous) => previous ?? JournalRepositoryImpl(db: db),
    ),
    ChangeNotifierProxyProvider<MoodLogDatabase, AppStateRepository>(
      create: (context) {
        final db = context.read<MoodLogDatabase>();
        return AppStateRepositoryImpl(db: db);
      },
      update: (_, db, previous) => previous ?? AppStateRepositoryImpl(db: db),
    ),
  ];
}
