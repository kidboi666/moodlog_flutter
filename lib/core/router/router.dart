import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/presentation/auth/screen/sign_in_screen.dart';
import 'package:moodlog/presentation/auth/viewmodel/auth_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../domain/repositories/auth_repository.dart';
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

GoRouter router(AuthRepository authRepository) => GoRouter(
  initialLocation: Routes.home,
  refreshListenable: authRepository,
  redirect: _redirect,
  routes: [
    GoRoute(
      path: Routes.onboarding,
      builder: (_, _) => ChangeNotifierProvider(
        create: (context) => OnboardingViewModel(
          totalSteps: 4,
          appStateProvider: context.read(),
        ),
        child: const OnboardingScreen(),
      ),
    ),
    GoRoute(
      path: Routes.signIn,
      builder: (_, state) {
        final data = state.extra as Map<String, dynamic>?;
        return ChangeNotifierProvider(
          create: (context) => AuthViewModel(
            authRepository: context.read(),
            appStateProvider: context.read(),
            nickname: data?['nickname'],
            aiPersonality: data?['aiPersonality'],
          ),
          child: const SignInScreen(),
        );
      },
    ),
    GoRoute(
      path: Routes.profile,
      builder: (_, _) => ChangeNotifierProvider(
        create: (context) => ProfileViewModel(authRepository: context.read()),
        child: const ProfileScreen(),
      ),
    ),
    GoRoute(
      path: Routes.write,
      builder: (_, _) => ChangeNotifierProvider(
        create: (context) => WriteViewModel(
          journalRepository: context.read(),
          geminiRepository: context.read(),
          appStateProvider: context.read(),
          aiGenerationRepository: context.read(),
          totalSteps: 2,
        ),
        child: const WriteScreen(),
      ),
    ),
    GoRoute(
      path: Routes.journalPage,
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
                  authRepository: context.read(),
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
                create: (context) =>
                    EntriesViewModel(journalRepository: context.read()),
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
                  authRepository: context.read(),
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
                  authRepository: context.read(),
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
  final authRepository = context.read<AuthRepository>();
  final isAuthenticated = authRepository.isAuthenticated;
  final isAnonymousUser = authRepository.isAnonymousUser;
  final location = state.matchedLocation;

  if (!isAuthenticated && location != Routes.signIn) {
    return location == Routes.onboarding ? null : Routes.onboarding;
  }

  if (!isAuthenticated) {
    return location == Routes.signIn ? null : Routes.signIn;
  }

  if (isAuthenticated && location == Routes.signIn) {
    return isAnonymousUser ? null : Routes.home;
  }

  return null;
}
