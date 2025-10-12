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
        locale: Locale(appState.languageCode.value),
        theme: AppTheme.lightTheme(appState.fontFamily),
        darkTheme: AppTheme.darkTheme(appState.fontFamily),
        themeMode: appState.themeMode.materialThemeMode,
        routerConfig: _router,
        builder: (context, child) {
          // This builder provides a context that is a descendant of MaterialApp,
          // which is required for services that need access to Localizations.
          return AppStartupLogic(
            onAppStarted: widget.onAppStarted,
            child: child ?? const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

/// A helper widget to run one-time startup logic using a context that is
/// available inside the MaterialApp.
class AppStartupLogic extends StatefulWidget {
  const AppStartupLogic({
    super.key,
    required this.child,
    this.onAppStarted,
  });

  final Widget child;
  final Future<void> Function(BuildContext context)? onAppStarted;

  @override
  State<AppStartupLogic> createState() => _AppStartupLogicState();
}

class _AppStartupLogicState extends State<AppStartupLogic> {
  bool _startupLogicExecuted = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _runStartupLogic();
  }

  void _runStartupLogic() {
    if (widget.onAppStarted != null && !_startupLogicExecuted) {
      _startupLogicExecuted = true;
      // The context here is from the AppStartupLogic widget, which is INSIDE
      // MaterialApp, so it has access to AppLocalizations.
      widget.onAppStarted!(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}