import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import "package:flutter_localizations/flutter_localizations.dart";
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'core/constants/enum.dart';
import 'core/di/injection_container.dart';
import 'core/l10n/app_localizations.dart';
import 'core/providers/app_state_provider.dart';
import 'core/routing/router.dart';
import 'core/theme/theme.dart';
import 'firebase_options.dart';
import 'presentation/widgets/spinner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await MobileAds.instance.initialize();
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
  GoRouter? _router;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, appStateProvider, child) {
        final appState = appStateProvider.appState;
        if (appStateProvider.isLoading) {
          return const Spinner(spinnerType: SpinnerType.screen);
        }
        _router ??= router(context.read());

        return MaterialApp.router(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale(LanguageCode.ko.value),
            Locale(LanguageCode.en.value),
          ],
          locale: Locale(appState.languageCode.value),
          theme: AppTheme.lightTheme(appState.colorTheme, appState.fontFamily),
          darkTheme: AppTheme.darkTheme(
            appState.colorTheme,
            appState.fontFamily,
          ),
          themeMode: appState.themeMode.materialThemeMode,
          routerConfig: _router!,
        );
      },
    );
  }
}
