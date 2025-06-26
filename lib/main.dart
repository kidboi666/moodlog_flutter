import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:moodlog/core/providers/app_state_provider.dart';
import 'package:moodlog/data/repositories/app_state_repository_impl.dart';
import 'package:provider/provider.dart';

import 'core/l10n/app_localizations.dart';
import 'data/data_source/database.dart';
import 'data/repositories/journal_repository_impl.dart';
import 'domain/repositories/journal_repository.dart';
import 'router/router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (_) => MoodLogDatabase(),
          dispose: (_, db) => db.close(),
        ),
        Provider(create: (_) => AppStateRepositoryImpl()),
        ChangeNotifierProvider(
          create: (context) =>
              AppStateProvider(appStateRepository: context.read()),
        ),
        ProxyProvider<MoodLogDatabase, JournalRepository>(
          update: (_, db, _) => JournalRepositoryImpl(db: db),
        ),
      ],
      child: const MoodLogApp(),
    ),
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
      theme: ThemeData(
        fontFamily: 'Pretendard',
        textTheme: TextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      routerConfig: router(),
    );
  }
}
