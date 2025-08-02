import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/constants/enum.dart';
import '../../common/providers/user_provider.dart';
import '../../data/repositories/analytics_repository_impl.dart';
import '../../domain/repositories/weather_repository.dart';
import '../../domain/use_cases/weather/get_current_weather_use_case.dart';
import '../../presentation/auth/screen/sign_in_screen.dart';
import '../../presentation/auth/viewmodel/auth_viewmodel.dart';
import '../../presentation/entries/screen/entries_screen.dart';
import '../../presentation/entries/viewmodel/entries_viewmodel.dart';
import '../../presentation/home/screen/home_screen.dart';
import '../../presentation/home/viewmodel/home_viewmodel.dart';
import '../../presentation/journal/screen/journal_screen.dart';
import '../../presentation/journal/viewmodel/journal_viewmodel.dart';
import '../../presentation/onboarding/screen/onboarding_screen.dart';
import '../../presentation/onboarding/viewmodel/onboarding_viewmodel.dart';
import '../../presentation/profile/screen/profile_screen.dart';
import '../../presentation/profile/viewmodel/profile_viewmodel.dart';
import '../../presentation/settings/screen/settings_screen.dart';
import '../../presentation/settings/viewmodel/settings_viewmodel.dart';
import '../../presentation/statistics/screen/statistics_screen.dart';
import '../../presentation/statistics/viewmodel/statistics_viewmodel.dart';
import '../../presentation/widgets/scaffold_with_navbar.dart';
import '../../presentation/write/screen/write_screen.dart';
import '../../presentation/write/viewmodel/write_viewmodel.dart';
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
        return ChangeNotifierProvider(
          create: (context) => AuthViewModel(
            authRepository: context.read(),
            appStateProvider: context.read(),
          ),
          child: SignInScreen(source: extra?['source']),
        );
      },
    ),
    GoRoute(
      path: Routes.onboarding,
      builder: (_, state) {
        final extra = state.extra as Map<String, LoginType>?;
        final loginType = extra?['loginType'] ?? LoginType.anonymous;
        return ChangeNotifierProvider(
          create: (context) => OnboardingViewModel(
            totalSteps: 4,
            appStateProvider: context.read(),
            authRepository: context.read(),
            loginType: loginType,
          ),
          child: const OnboardingScreen(),
        );
      },
    ),
    GoRoute(
      path: Routes.profile,
      builder: (_, _) => ChangeNotifierProvider(
        create: (context) => ProfileViewModel(
          userProvider: context.read(),
          authUseCase: context.read(),
          pickImageUseCase: context.read(),
        ),
        child: const ProfileScreen(),
      ),
    ),
    GoRoute(
      path: Routes.write,
      builder: (_, _) => ChangeNotifierProvider(
        create: (context) => WriteViewModel(
          geminiRepository: context.read(),
          appStateProvider: context.read(),
          settingsRepository: context.read(),
          aiGenerationRepository: context.read(),
          pickImageUseCase: context.read(),
          getCurrentLocationUseCase: context.read(),
          getCurrentWeatherUseCase: context.read(),
          addJournalUseCase: context.read(),
          updateJournalUseCase: context.read(),
          checkAiUsageLimitUseCase: context.read(),
          totalSteps: 2,
        ),
        child: const WriteScreen(),
      ),
    ),
    GoRoute(
      path: Routes.journalPage,
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        final extra = state.extra as Map<String, JournalSource>?;
        final source = extra?['source'] ?? JournalSource.home;
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => JournalViewModel(
                journalRepository: context.read(),
                aiGenerationRepository: context.read(),
                appStateProvider: context.read(),
                source: source,
                id: id,
              ),
            ),
            Provider.value(value: context.read<GetCurrentWeatherUseCase>()),
            Provider.value(value: context.read<WeatherRepository>()),
          ],
          child: const JournalScreen(),
        );
      },
    ),
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
            GoRoute(
              path: Routes.home,
              builder: (_, _) => ChangeNotifierProvider(
                create: (context) => HomeViewModel(
                  journalRepository: context.read(),
                  userProvider: context.read(),
                  deleteJournalUseCase: context.read(),
                  getCurrentLocationUseCase: context.read(),
                  getCurrentWeatherUseCase: context.read(),
                ),
                child: const HomeScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.entries,
              builder: (_, _) => ChangeNotifierProvider(
                create: (context) => EntriesViewModel(
                  journalRepository: context.read(),
                  deleteJournalUseCase: context.read(),
                ),
                child: const EntriesScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.statistics,
              builder: (_, _) => ChangeNotifierProvider(
                create: (context) => StatisticsViewModel(
                  journalRepository: context.read(),
                  userProvider: context.read(),
                ),
                child: const StatisticsScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.settings,
              builder: (_, _) => ChangeNotifierProvider(
                create: (context) => SettingsViewModel(
                  settingsRepository: context.read(),
                  appStateProvider: context.read(),
                  journalRepository: context.read(),
                  userProvider: context.read(),
                ),
                child: const SettingsScreen(),
              ),
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
