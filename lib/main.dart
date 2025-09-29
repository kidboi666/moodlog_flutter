import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'core/constants/enum.dart';
import 'core/di/injection_container.dart';
import 'core/l10n/app_localizations.dart';
import 'core/routing/router.dart';
import 'core/ui/theme/theme.dart';
import 'core/ui/widgets/spinner.dart';
import 'core/utils/keyboard_utils.dart';
import 'data/repositories/analytics_repository_impl.dart';
import 'firebase_options.dart';
import 'presentation/providers/app_state_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(Duration(seconds: 2));

  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (Platform.isAndroid || Platform.isIOS) {
    await MobileAds.instance.initialize();
  }

  final analyticsRepo = AnalyticsRepositoryImpl();
  await analyticsRepo.initialize();

  if (kDebugMode) {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      debugPrint('${record.level.name}: ${record.time}: ${record.message}');
    });
  }

  runApp(
    MultiProvider(
      providers: createProviders(),
      child: MoodLogApp(analyticsObserver: analyticsRepo.navigatorObserver),
    ),
  );
}

class MoodLogApp extends StatefulWidget {
  final NavigatorObserver analyticsObserver;

  const MoodLogApp({required this.analyticsObserver, super.key});

  @override
  State<MoodLogApp> createState() => _MoodLogAppState();
}

class _MoodLogAppState extends State<MoodLogApp> {
  GoRouter? _router;

  @override
  Widget build(BuildContext context) {
    final appState = context.select((AppStateProvider v) => v.appState);
    final isLoading = context.select((AppStateProvider v) => v.isLoading);

    if (isLoading) {
      return const Spinner(spinnerType: SpinnerType.center);
    }

    _router ??= router(context.read(), widget.analyticsObserver);

    return KeyboardDismissOnTapOutside(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale(LanguageCode.ko.value),
          Locale(LanguageCode.en.value),
          Locale(LanguageCode.ja.value),
        ],
        locale: Locale(appState.languageCode.value),
        theme: AppTheme.lightTheme(appState.fontFamily),
        darkTheme: AppTheme.darkTheme(appState.fontFamily),
        themeMode: appState.themeMode.materialThemeMode,
        routerConfig: _router!,
      ),
    );
  }
}
