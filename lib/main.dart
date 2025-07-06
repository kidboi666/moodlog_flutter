import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'core/di/injection_container.dart';
import 'core/l10n/app_localizations.dart';
import 'core/router/router.dart';
import 'core/theme/theme.dart';
import 'domain/repositories/app_state_repository.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Logger.root.level = Level.ALL;
  runApp(
    MultiProvider(providers: createProviders(), child: const MoodLogApp()),
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
          supportedLocales: [Locale('ko'), Locale('en')],
          locale: Locale(appState.languageCode.code),
          theme: AppTheme.lightTheme(appState.colorTheme),
          darkTheme: AppTheme.darkTheme(appState.colorTheme),
          themeMode: appState.themeMode.materialThemeMode,
          routerConfig: _router,
        );
      },
    );
  }
}
