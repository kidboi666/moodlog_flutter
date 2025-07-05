import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import '../../domain/repositories/app_state_repository.dart';
import '../../presentation/view_models/entries/entries_viewmodel.dart';
import '../../presentation/view_models/home/home_viewmodel.dart';
import '../../presentation/view_models/journal/journal_viewmodel.dart';
import '../../presentation/view_models/onboarding/onboarding_viewmodel.dart';
import '../../presentation/view_models/settings/settings_viewmodel.dart';
import '../../presentation/view_models/write/write_viewmodel.dart';
import '../../presentation/views/entries/screen/entries_screen.dart';
import '../../presentation/views/home/screen/home_screen.dart';
import '../../presentation/views/journal/screen/journal_screen.dart';
import '../../presentation/views/onboarding/screen/onboarding_screen.dart';
import '../../presentation/views/settings/screen/settings_screen.dart';
import '../../presentation/views/splash/splash_screen.dart';
import '../../presentation/views/statistics/screen/statistics_screen.dart';
import '../../presentation/views/write/screen/write_screen.dart';
import '../../presentation/widgets/scaffold_with_navbar.dart';
import 'routes.dart';

GoRouter router(AppStateRepository appStateRepository) => GoRouter(
  initialLocation: Routes.splash,
  debugLogDiagnostics: true,
  refreshListenable: appStateRepository,
  redirect: _redirect,
  routes: [
    GoRoute(
      path: Routes.splash,
      builder: (context, state) {
        return SplashScreen();
      },
    ),

    GoRoute(
      path: Routes.onboarding,
      builder: (context, state) {
        final viewModel = OnboardingViewModel(
          totalSteps: 4,
          appStateRepository: context.read(),
        );
        return OnboardingScreen(viewModel: viewModel);
      },
    ),
    StatefulShellRoute(
      builder: (context, state, navigationShell) => navigationShell,
      navigatorContainerBuilder: (context, navigationShell, children) {
        return ScaffoldWithNavbar(
          navigationShell: navigationShell,
          children: children,
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.home,
              builder: (context, state) {
                final viewModel = HomeViewModel(
                  journalRepository: context.read(),
                  appStateRepository: context.read(),
                );
                return HomeScreen(viewModel: viewModel);
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.entries,
              builder: (context, state) {
                final viewModel = EntriesViewModel(
                  journalRepository: context.read(),
                );
                return EntriesScreen(viewModel: viewModel);
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.statistics,
              builder: (context, state) {
                return StatisticsScreen();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.settings,
              builder: (context, state) {
                final viewModel = SettingsViewModel(
                  appStateRepository: context.read(),
                );
                return SettingsScreen(viewModel: viewModel);
              },
            ),
          ],
        ),
      ],
    ),

    GoRoute(
      path: Routes.write,
      builder: (context, state) {
        final viewModel = WriteViewModel(
          journalRepository: context.read(),
          geminiRepository: context.read(),
          appStateRepository: context.read(),
          totalSteps: 2,
        );
        return WriteScreen(viewModel: viewModel);
      },
    ),
    GoRoute(
      path: '/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        final data = state.extra as Map<String, dynamic>;
        final viewModel = JournalViewModel(
          journalRepository: context.read(),
          source: data['source'],
          id: id,
        );
        return JournalScreen(viewModel: viewModel);
      },
    ),
  ],
);

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  final log = Logger('Redirect');
  final appState = context.read<AppStateRepository>().appState;
  final isLoading = context.read<AppStateRepository>().isLoading;
  final isFirstLaunch = appState.isFirstLaunch;
  final isInOnboarding = state.matchedLocation == Routes.onboarding;
  final isInSplash = state.matchedLocation == Routes.splash;

  if (isLoading) {
    return null;
  }

  if (isFirstLaunch) {
    log.info('First launch, redirecting to onboarding');
    return Routes.onboarding;
  }

  if (isInOnboarding && !isFirstLaunch || isInSplash && !isFirstLaunch) {
    log.info('Redirecting to home');
    return Routes.home;
  }

  return null;
}
