import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/domain/repositories/auth_repository.dart';
import 'package:provider/provider.dart';

import '../../presentation/entries/view/entries_screen.dart';
import '../../presentation/home/view/home_screen.dart';
import '../../presentation/journal/view/journal_screen.dart';
import '../../presentation/journal/viewmodel/journal_viewmodel.dart';
import '../../presentation/onboarding/view/onboarding_screen.dart';
import '../../presentation/profile/view/profile_screen.dart';
import '../../presentation/settings/view/settings_screen.dart';
import '../../presentation/statistics/view/statistics_screen.dart';
import '../../presentation/widgets/scaffold_with_navbar.dart';
import '../../presentation/write/view/write_screen.dart';
import 'routes.dart';

GoRouter router(AuthRepository authRepository) => GoRouter(
  initialLocation: Routes.home,
  refreshListenable: authRepository,
  redirect: _redirect,
  routes: [
    GoRoute(
      path: Routes.onboarding,
      builder: (_, _) => const OnboardingScreen(),
    ),
    GoRoute(path: Routes.profile, builder: (_, _) => const ProfileScreen()),
    StatefulShellRoute(
      builder: (_, _, navigationShell) => navigationShell,
      navigatorContainerBuilder: (_, navigationShell, children) {
        return ScaffoldWithNavbar(
          navigationShell: navigationShell,
          children: children,
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(path: Routes.home, builder: (_, _) => const HomeScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.entries,
              builder: (_, _) => const EntriesScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.statistics,
              builder: (_, _) => const StatisticsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.settings,
              builder: (_, _) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),

    GoRoute(path: Routes.write, builder: (_, _) => const WriteScreen()),
    GoRoute(
      path: '/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        final data = state.extra as Map<String, dynamic>;
        final viewModel = JournalViewModel(
          journalRepository: context.read(),
          aiGenerationRepository: context.read(),
          source: data['source'],
          id: id,
        );
        return JournalScreen(viewModel: viewModel);
      },
    ),
  ],
);

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  final authRepository = context.read<AuthRepository>();
  final isAuthenticated = authRepository.isAuthenticated;
  final location = state.matchedLocation;

  if (!isAuthenticated) {
    return location == Routes.onboarding ? null : Routes.onboarding;
  }

  if (location == Routes.onboarding) {
    return Routes.home;
  }

  return null;
}
