import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/observers/app_lifecycle_observer.dart';
import 'package:moodlog/core/routing/router.dart';
import 'package:moodlog/core/services/flavor_service.dart';
import 'package:moodlog/core/ui/theme/theme.dart';
import 'package:moodlog/core/utils/keyboard_utils.dart';
import 'package:moodlog/presentation/providers/app_state_provider.dart';
import 'package:provider/provider.dart';

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
    final appStateProvider = context.watch<AppStateProvider>();
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
        debugShowCheckedModeBanner: FlavorService.isDebug,
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
