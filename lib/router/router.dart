import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/domain/repositories/app_state_repository.dart';
import 'package:provider/provider.dart';

import '../presentation/view_models/home/home_viewmodel.dart';
import '../presentation/view_models/journal/journal_viewmodel.dart';
import '../presentation/view_models/onboarding/onboarding_viewmodel.dart';
import '../presentation/view_models/write/write_viewmodel.dart';
import '../presentation/views/entries/entries_screen.dart';
import '../presentation/views/home/home_screen.dart';
import '../presentation/views/journal/journal_screen.dart';
import '../presentation/views/onboarding/onboarding_screen.dart';
import '../presentation/views/settings/settings_screen.dart';
import '../presentation/views/write/write_screen.dart';
import '../presentation/widgets/scaffold_with_navbar.dart';
import 'routes.dart';

GoRouter router(AppStateRepository appStateRepository) => GoRouter(
  initialLocation: Routes.onboarding,
  debugLogDiagnostics: true,
  refreshListenable: appStateRepository,
  redirect: _redirect,
  routes: [
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
                return EntriesScreen();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.settings,
              builder: (context, state) {
                return SettingsScreen();
              },
            ),
          ],
        ),
      ],
    ),

    GoRoute(
      path: Routes.write,
      builder: (context, state) {
        final viewModel = WriteViewModel(journalRepository: context.read());
        return WriteScreen(viewModel: viewModel);
      },
    ),
    GoRoute(
      path: '/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        final viewModel = JournalViewModel(journalRepository: context.read());
        viewModel.load(id);
        return JournalScreen(viewModel: viewModel);
      },
    ),
  ],
);

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  final Logger log = Logger('Redirect');
  final appState = context.read<AppStateRepository>().appState;
  final isFirstLaunch = appState.isFirstLaunch;
  final isInOnboarding = state.matchedLocation == Routes.onboarding;

  if (isFirstLaunch) {
    log.info('First launch, redirecting to onboarding');
    return Routes.onboarding;
  }

  if (isInOnboarding) {
    log.info('Redirecting to home');
    return Routes.home;
  }

  return null;
}
