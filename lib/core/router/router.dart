import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import '../../domain/repositories/app_state_repository.dart';
import '../../presentation/view_models/journal/journal_viewmodel.dart';
import '../../presentation/view_models/onboarding/onboarding_viewmodel.dart';
import '../../presentation/view_models/write/write_viewmodel.dart';
import '../../presentation/views/entries/screen/entries_screen.dart';
import '../../presentation/views/home/screen/home_screen.dart';
import '../../presentation/views/journal/screen/journal_screen.dart';
import '../../presentation/views/onboarding/screen/onboarding_screen.dart';
import '../../presentation/views/profile/screen/profile_screen.dart';
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
          firebaseAuth: FirebaseAuth.instance,
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
              routes: [
                GoRoute(
                  path: Routes.profileRelative,
                  builder: (_, _) => const ProfileScreen(),
                ),
              ],
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
          aiGenerationRepository: context.read(),
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
  final log = Logger('Redirect');
  final user = FirebaseAuth.instance.currentUser;
  final isLoggedIn = user != null;

  final appStateRepository = context.read<AppStateRepository>();
  final isLoading = appStateRepository.isLoading;

  if (isLoading) {
    log.info('Still loading app state, no redirection');
    return null;
  }

  final isFirstLaunch = appStateRepository.appState.isFirstLaunch;
  final location = state.matchedLocation;

  log.info(
    'Current user: ${user?.uid}, isFirstLaunch: $isFirstLaunch, location: $location',
  );

  if (!isLoggedIn) {
    // 비로그인 상태일 때
    log.info('User is not logged in.');
    return location == Routes.onboarding ? null : Routes.onboarding;
  } else {
    // 로그인 상태일 때 (익명 포함)
    log.info('User is logged in.');
    if (isFirstLaunch) {
      // 최초 실행 시에는 온보딩을 완료해야 함
      log.info('First launch for a logged-in user, redirecting to onboarding.');
      return location == Routes.onboarding ? null : Routes.onboarding;
    }

    if (location == Routes.onboarding || location == Routes.splash) {
      // 온보딩/스플래시 페이지에 있으면 홈으로 리다이렉트
      log.info('User is on onboarding/splash, redirecting to home.');
      return Routes.home;
    }
  }

  return null; // 그 외의 경우는 리다이렉트하지 않음
}
