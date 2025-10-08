import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/constants/enum.dart';
import 'core/l10n/app_localizations.dart';
import 'core/routing/router.dart';
import 'core/ui/theme/theme.dart';
import 'core/ui/widgets/spinner.dart';
import 'core/utils/flavor_config.dart';
import 'core/utils/keyboard_utils.dart';
import 'presentation/providers/app_state_provider.dart';

class MoodLogApp extends StatefulWidget {
  final NavigatorObserver? analyticsObserver;

  const MoodLogApp({this.analyticsObserver, super.key});

  @override
  State<MoodLogApp> createState() => _MoodLogAppState();
}

class _MoodLogAppState extends State<MoodLogApp> {
  @override
  Widget build(BuildContext context) {
    final appState = context.select((AppStateProvider v) => v.appState);
    final isLoading = context.select((AppStateProvider v) => v.isLoading);

    if (isLoading) {
      return const Spinner(spinnerType: SpinnerType.center);
    }

    return KeyboardDismissOnTapOutside(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: FlavorConfig.instance.showDebugBanner,
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
        routerConfig: router(context.read(), widget.analyticsObserver),
      ),
    );
  }
}
