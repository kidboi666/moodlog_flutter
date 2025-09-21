import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../presentation/auth/sign_in_screen.dart';
import '../../presentation/base_layout/base_layout_screen.dart';
import '../../presentation/entries/entries_screen.dart';
import '../../presentation/home/home_screen.dart';
import '../../presentation/journal/journal_screen.dart';
import '../../presentation/onboarding/onboarding_screen.dart';
import '../../presentation/profile/profile_screen.dart';
import '../../presentation/providers/app_state_provider.dart';
import '../../presentation/providers/user_provider.dart';
import '../../presentation/settings/settings_screen.dart';
import '../../presentation/statistics/statistics_screen.dart';
import '../../presentation/write/write_screen.dart';
import '../constants/enum.dart';
import 'routes.dart';

GoRouter router(
  UserProvider userProvider,
  NavigatorObserver analyticsObserver,
) => GoRouter(
  initialLocation: Routes.home,
  redirect: _redirect,
  refreshListenable: userProvider,
  observers: [analyticsObserver],
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
        LoginType loginType = LoginType.anonymous;

        // extra에서 loginType 확인
        final extra = state.extra as Map<String, LoginType>?;
        if (extra?['loginType'] != null) {
          loginType = extra!['loginType']!;
        } else {
          // query parameter에서 loginType 확인
          final loginTypeStr = state.uri.queryParameters['loginType'];
          if (loginTypeStr != null) {
            switch (loginTypeStr) {
              case 'anonymous':
                loginType = LoginType.anonymous;
                break;
              case 'google':
                loginType = LoginType.google;
                break;
              case 'apple':
                loginType = LoginType.apple;
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
  final bool shouldShowOnboarding =
      appStateProvider.appState.shouldShowOnboarding(isAnonymousUser);
  final String location = state.matchedLocation;
  final bool isOnboarding = location == Routes.onboarding;
  final bool isSigning = location == Routes.signIn;

  // 게스트 온보딩인 경우 인증 없이 접근 허용
  if (isOnboarding && !isAuthenticated) {
    final extra = state.extra as Map<String, LoginType>?;
    final loginType = extra?['loginType'];
    if (loginType == LoginType.anonymous) {
      return null; // 게스트 온보딩은 허용
    }
  }

  if (!isAuthenticated) {
    return isOnboarding || isSigning ? null : Routes.signIn;
  }

  if (isSigning) {
    if (!shouldShowOnboarding) {
      return Routes.home;
    }
    return null;
  }

  if (isOnboarding) {
    if (!shouldShowOnboarding) {
      return Routes.home;
    }
    return null;
  }

  if (shouldShowOnboarding) {
    LoginType loginType = LoginType.anonymous;

    if (isAnonymousUser) {
      loginType = LoginType.anonymous;
    } else {
      // 소셜 로그인 사용자인 경우 provider 정보로 정확한 타입 판단
      final user = userProvider.user;
      if (user != null) {
        final isAppleUser = user.providerData.any(
          (provider) => provider.providerId == 'apple.com',
        );
        final isGoogleUser = user.providerData.any(
          (provider) => provider.providerId == 'google.com',
        );

        if (isAppleUser) {
          loginType = LoginType.apple;
        } else if (isGoogleUser) {
          loginType = LoginType.google;
        } else {
          loginType = LoginType.google; // 기본값
        }
      }
    }

    return Uri(
      path: Routes.onboarding,
      queryParameters: {'loginType': loginType.name},
    ).toString();
  }

  return null;
}
