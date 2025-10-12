import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'core/constants/enum.dart';
import 'core/l10n/app_localizations.dart';
import 'core/routing/router.dart';
import 'core/services/flavor_service.dart';
import 'core/ui/theme/theme.dart';
import 'core/utils/keyboard_utils.dart';
import 'presentation/providers/app_state_provider.dart';

class MoodLogApp extends StatefulWidget {
  final NavigatorObserver? analyticsObserver;
  final Future<void> Function(BuildContext context)? onAppStarted;

  const MoodLogApp({this.analyticsObserver, this.onAppStarted, super.key});

  @override
  State<MoodLogApp> createState() => _MoodLogAppState();
}

class _MoodLogAppState extends State<MoodLogApp> {
  GoRouter? _router;
  bool _startupLogicExecuted = false;

  @override
  Widget build(BuildContext context) {
    final appStateProvider = context.watch<AppStateProvider>();

    if (appStateProvider.isLoading) {
      return const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    final appState = appStateProvider.appState;
    _router ??= router(context.read(), widget.analyticsObserver);

    if (widget.onAppStarted != null && !_startupLogicExecuted) {
      _startupLogicExecuted = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onAppStarted!(context);
      });
    }

    return KeyboardDismissOnTapOutside(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: FlavorService.instance.showDebugBanner,
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
        routerConfig: _router,
      ),
    );
  }
}
