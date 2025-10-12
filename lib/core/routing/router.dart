import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../presentation/entries/entries_view.dart';
import '../../presentation/home/home_view.dart';
import '../../presentation/journal/image_detail_screen.dart';
import '../../presentation/journal/journal_view.dart';
import '../../presentation/onboarding/onboarding_view.dart';
import '../../presentation/profile/profile_view.dart';
import '../../presentation/providers/app_state_provider.dart';
import '../../presentation/settings/settings_view.dart';
import '../../presentation/statistics/statistics_view.dart';
import '../../presentation/write/write_view.dart';
import '../../presentation/tag_detail/tag_detail_view.dart';
import '../../presentation/tags/tags_view.dart';
import '../constants/enum.dart';
import 'routes.dart';

GoRouter router(
  AppStateProvider appStateProvider,
  NavigatorObserver? analyticsObserver,
) =>
    GoRouter(
      initialLocation: Routes.home,
      redirect: _redirect,
      refreshListenable: appStateProvider,
      observers: [?analyticsObserver],
      routes: [
        GoRoute(
          path: Routes.onboarding,
          builder: (_, state) {
            return const OnboardingScreen();
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
            final editJournalId =
                editJournalIdStr != null ? int.tryParse(editJournalIdStr) : null;
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
        GoRoute(
          path: Routes.home,
          builder: (_, _) {
            return const HomeScreen();
          },
        ),
        GoRoute(
          path: Routes.entries,
          builder: (_, _) {
            return const EntriesScreen();
          },
        ),
        GoRoute(
          path: Routes.statistics,
          builder: (_, _) {
            return const StatisticsScreen();
          },
        ),
        GoRoute(
          path: Routes.settings,
          builder: (_, _) {
            return const SettingsScreen();
          },
        ),
        GoRoute(
          path: Routes.tags,
          builder: (_, _) {
            return const TagsScreen();
          },
        ),
        GoRoute(
          path: Routes.tagDetail,
          builder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            return TagDetailScreen(tagId: id);
          },
        ),
      ],
    );

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  final AppStateProvider appStateProvider = context.read<AppStateProvider>();
  final bool isOnboardingComplete =
      appStateProvider.appState.isOnboardingComplete;
  final String location = state.matchedLocation;
  final bool isOnboarding = location == Routes.onboarding;

  if (!isOnboardingComplete && !isOnboarding) {
    return Routes.onboarding;
  }

  if (isOnboardingComplete && isOnboarding) {
    return Routes.home;
  }

  return null;
}
