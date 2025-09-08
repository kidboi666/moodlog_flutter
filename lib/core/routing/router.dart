import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../data/repositories/analytics_repository_impl.dart';
import '../../presentation/auth/sign_in_screen.dart';
import '../../presentation/entries/entries_screen.dart';
import '../../presentation/home/home_screen.dart';
import '../../presentation/journal/journal_screen.dart';
import '../../presentation/layout/base_scaffold/base_scaffold_screen.dart';
import '../../presentation/onboarding/onboarding_screen.dart';
import '../../presentation/profile/profile_screen.dart';
import '../../presentation/providers/user_provider.dart';
import '../../presentation/settings/settings_screen.dart';
import '../../presentation/statistics/statistics_screen.dart';
import '../../presentation/write/write_screen.dart';
import '../constants/enum.dart';
import 'routes.dart';

GoRouter router(UserProvider userProvider) => GoRouter(
  initialLocation: Routes.home,
  redirect: _redirect,
  refreshListenable: userProvider,
  observers: [AnalyticsRepositoryImpl().observer],
  routes: [
    GoRoute(
      path: Routes.signIn,
      builder: (_, state) {
        final extra = state.extra as Map<String, SignInSource>?;
        return SignInScreen(source: extra?['source']);
      },
    ),
    GoRoute(
      path: Routes.onboarding,
      builder: (_, state) {
        final extra = state.extra as Map<String, LoginType>?;
        final loginType = extra?['loginType'] ?? LoginType.anonymous;
        return OnboardingScreen(loginType: loginType);
      },
    ),
    GoRoute(
      path: Routes.profile,
      builder: (_, _) {
        return const ProfileScreen();
      },
    ),
    GoRoute(
      path: Routes.write,
      builder: (_, state) {
        final extra = state.extra as Map<String, DateTime>?;
        final date = extra?['date'] ?? DateTime.now();
        final editJournalIdStr = state.uri.queryParameters['editJournalId'];
        final editJournalId = editJournalIdStr != null
            ? int.tryParse(editJournalIdStr)
            : null;
        return WriteScreen(date: date, editJournalId: editJournalId);
      },
    ),
    GoRoute(
      path: Routes.journalPage,
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        final extra = state.extra as Map<String, JournalSource>?;
        final source = extra?['source'] ?? JournalSource.home;
        return JournalScreen(source: source, id: id);
      },
    ),
    StatefulShellRoute(
      builder: (_, _, navigationShell) => navigationShell,
      navigatorContainerBuilder: (_, navigationShell, children) {
        return BaseLayoutScreen(
          navigationShell: navigationShell,
          children: children,
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.home,
              builder: (_, _) {
                return const HomeScreen();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.entries,
              builder: (_, _) {
                return const EntriesScreen();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.statistics,
              builder: (_, _) {
                return const StatisticsScreen();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.settings,
              builder: (_, _) {
                return const SettingsScreen();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  final userProvider = context.read<UserProvider>();
  final isAuthenticated = userProvider.isAuthenticated;
  final isAnonymousUser = userProvider.isAnonymousUser;
  final location = state.matchedLocation;
  final isOnboarding = location == Routes.onboarding;
  final isSigning = location == Routes.signIn;

  // 로그인을 안했다면
  if (!isAuthenticated) {
    // 로그인 페이지가 아니라면 로그인 페이지로
    return isSigning ? null : Routes.signIn;
  }

  // 로그인을 했고
  // 로그인 페이지이거나 온보딩 페이지라면
  if (isSigning || isOnboarding) {
    // 익명 사용자가 아니라면 홈으로
    return isAnonymousUser ? null : Routes.home;
  }

  return null;
}
