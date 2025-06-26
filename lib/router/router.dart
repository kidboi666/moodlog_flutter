import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/presentation/view_models/journal/journal_viewmodel.dart';
import 'package:provider/provider.dart';

import '../domain/repositories/app_state_repository.dart';
import '../presentation/view_models/home/home_viewmodel.dart';
import '../presentation/view_models/write/write_viewmodel.dart';
import '../presentation/views/entries/entries_screen.dart';
import '../presentation/views/home/home_screen.dart';
import '../presentation/views/journal/journal_screen.dart';
import '../presentation/views/onboarding/onboarding_screen.dart';
import '../presentation/views/settings/settings_screen.dart';
import '../presentation/views/write/write_screen.dart';
import '../presentation/widgets/scaffold_with_navbar.dart';
import 'routes.dart';

GoRouter router() => GoRouter(
  initialLocation: Routes.onboarding,
  debugLogDiagnostics: true,
  // redirect: _redirect,
  routes: [
    GoRoute(
      path: Routes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
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
  final result = await context.read<AppStateRepository>().getAppState();
  final isFirstLaunch = result.isFirstLaunch;

  if (isFirstLaunch) {
    return Routes.onboarding;
  }
  return Routes.home;
}
