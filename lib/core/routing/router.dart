import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../presentation/auth/auth_view.dart';
import '../../presentation/base_layout/base_layout_screen.dart';
import '../../presentation/entries/entries_screen.dart';
import '../../presentation/home/home_screen.dart';
import '../../presentation/journal/image_detail_screen.dart';
import '../../presentation/journal/journal_view.dart';
import '../../presentation/onboarding/onboarding_view.dart';
import '../../presentation/profile/profile_view.dart';
import '../../presentation/providers/app_state_provider.dart';
import '../../presentation/providers/user_provider.dart';
import '../../presentation/settings/settings_view.dart';
import '../../presentation/statistics/statistics_screen.dart';
import '../../presentation/write/write_screen.dart';
import '../constants/enum.dart';
import 'routes.dart';

GoRouter router(
  UserProvider userProvider,
  NavigatorObserver? analyticsObserver,
) => GoRouter(
  initialLocation: Routes.home,
  redirect: _redirect,
  refreshListenable: userProvider,
  observers: [?analyticsObserver],
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
        LoginMethod loginType = LoginMethod.anonymous;

        // extra에서 loginType 확인
        final extra = state.extra as Map<String, LoginMethod>?;
        if (extra?['loginType'] != null) {
          loginType = extra!['loginType']!;
        } else {
          // query parameter에서 loginType 확인
          final loginTypeStr = state.uri.queryParameters['loginType'];
          debugPrint('login type string : $loginTypeStr');
          if (loginTypeStr != null) {
            switch (loginTypeStr) {
              case 'anonymous':
                loginType = LoginMethod.anonymous;
                break;
              case 'google':
                loginType = LoginMethod.google;
                break;
              case 'apple':
                loginType = LoginMethod.apple;
                break;
            }
          }
        }

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
      routes: [
        GoRoute(
          path: 'image',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            final imageUrl = extra?['imageUrl'] as String? ?? '';
            final heroTag = extra?['heroTag'] as String?;

            return ImageDetailScreen(imageUrl: imageUrl, heroTag: heroTag);
          },
        ),
      ],
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
  final UserProvider userProvider = context.read<UserProvider>();
  final AppStateProvider appStateProvider = context.read<AppStateProvider>();
  final bool isAuthenticated = userProvider.isAuthenticated;
  final bool isAnonymousUser = userProvider.isAnonymousUser;
  final bool shouldShowOnboarding = appStateProvider.appState
      .shouldShowOnboarding(isAnonymousUser);
  final String location = state.matchedLocation;
  final bool isOnboarding = location == Routes.onboarding;
  final bool isSigning = location == Routes.signIn;

  // 인증되지 않은 사용자는 무조건 로그인 화면으로
  if (!isAuthenticated) {
    // 로그인 화면은 접근 허용
    if (isSigning) {
      return null;
    }
    // 다른 모든 경로 (온보딩 포함)는 로그인 화면으로 리다이렉트
    return Routes.signIn;
  }

  // 로그인 화면 접근 처리
  if (isSigning) {
    if (isAnonymousUser) {
      // 익명 사용자는 로그인 화면 접근 허용 (소셜 로그인 전환 가능)
      return null;
    }
    // 이미 소셜 로그인한 사용자는 홈으로 리다이렉트
    return Routes.home;
  }

  // 온보딩 화면 접근 처리
  if (isOnboarding) {
    if (!shouldShowOnboarding) {
      // 온보딩이 필요없으면 홈으로 리다이렉트
      return Routes.home;
    }
    // 온보딩이 필요하면 접근 허용
    return null;
  }

  // 온보딩이 필요한 경우 온보딩 화면으로 리다이렉트
  if (shouldShowOnboarding) {
    final loginMethod = userProvider.currentSignInMethod;
    return Uri(
      path: Routes.onboarding,
      queryParameters: {'loginType': loginMethod.value},
    ).toString();
  }

  // 모든 조건을 통과하면 현재 경로 유지
  return null;
}
