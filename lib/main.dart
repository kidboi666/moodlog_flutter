import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'core/l10n/app_localizations.dart';
import 'core/providers/app_state_provider.dart';
import 'core/theme/theme.dart';
import 'data/data_source/database.dart';
import 'data/repositories/app_state_repository_impl.dart';
import 'data/repositories/journal_repository_impl.dart';
import 'domain/repositories/journal_repository.dart';
import 'router/router.dart';

void main() {
  runApp(
    MultiProvider(providers: _createProviders(), child: const MoodLogApp()),
  );
}

class MoodLogApp extends StatelessWidget {
  const MoodLogApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('ko')],
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router(),
    );
  }
}

List<SingleChildWidget> _createProviders() {
  return [
    Provider<MoodLogDatabase>(
      create: (_) => MoodLogDatabase(),
      dispose: (_, db) => db.close(),
    ),
    Provider<AppStateRepositoryImpl>(create: (_) => AppStateRepositoryImpl()),
    ProxyProvider<MoodLogDatabase, JournalRepository>(
      update: (_, db, __) => JournalRepositoryImpl(db: db),
    ),
    ChangeNotifierProxyProvider<AppStateRepositoryImpl, AppStateProvider>(
      create: (context) => AppStateProvider(
        appStateRepository: context.read<AppStateRepositoryImpl>(),
      ),
      update: (_, appStateRepo, previous) =>
          previous ?? AppStateProvider(appStateRepository: appStateRepo),
    ),
  ];
}
