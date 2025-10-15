import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/observers/app_lifecycle_observer.dart';
import 'package:moodlog/core/routing/router.dart';
import 'package:moodlog/core/services/flavor_service.dart';
import 'package:moodlog/core/utils/keyboard_utils.dart';
import 'package:moodlog/presentation/providers/app_state_provider.dart';
import 'package:moodlog/presentation/theme/theme.dart';
import 'package:provider/provider.dart';

class MoodLogApp extends StatefulWidget {
  final NavigatorObserver? analyticsObserver;

  const MoodLogApp({this.analyticsObserver, super.key});

  @override
  State<MoodLogApp> createState() => _MoodLogAppState();
}

class _MoodLogAppState extends State<MoodLogApp> {
  GoRouter? _router;
  AppLifecycleObserver? _lifecycleObserver;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_lifecycleObserver == null) {
      final appStateProvider = context.read<AppStateProvider>();
      _lifecycleObserver = AppLifecycleObserver(
        context: context,
        appStateProvider: appStateProvider,
        auth: context.read<LocalAuthentication>(),
      )..init();
    }
  }

  @override
  void dispose() {
    _lifecycleObserver?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final (:languageCode, :fontType, :themeMode) = context.select(
      (AppStateProvider provider) => (
        languageCode: provider.appState.languageCode,
        fontType: provider.appState.fontType,
        themeMode: provider.appState.themeMode,
      ),
    );
    _router ??= router(context.read(), widget.analyticsObserver);

    return KeyboardDismissOnTapOutside(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: FlavorService.isDebug,
        localizationsDelegates: const [
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
        locale: Locale(languageCode.value),
        theme: AppTheme.lightTheme(fontType),
        darkTheme: AppTheme.darkTheme(fontType),
        themeMode: themeMode.materialThemeMode,
        routerConfig: _router,
      ),
    );
  }
}
