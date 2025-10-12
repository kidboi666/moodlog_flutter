import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'core/constants/enum.dart';
import 'core/l10n/app_localizations.dart';
import 'core/routing/router.dart';
import 'core/services/flavor_service.dart';
import 'core/ui/theme/theme.dart';
import 'core/ui/widgets/spinner.dart';
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

  @override
  void initState() {
    super.initState();
    if (widget.onAppStarted != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onAppStarted!(context);
      });
    }
  }

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
