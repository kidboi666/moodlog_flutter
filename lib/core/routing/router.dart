import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/routing/routes.dart';
import 'package:moodlog/presentation/providers/app_state_provider.dart';
import 'package:moodlog/presentation/screens/home/home_view.dart';
import 'package:moodlog/presentation/screens/journal/image_detail_screen.dart';
import 'package:moodlog/presentation/screens/journal/journal_view.dart';
import 'package:moodlog/presentation/screens/lock/lock_view.dart';
import 'package:moodlog/presentation/screens/onboarding/onboarding_view.dart';
import 'package:moodlog/presentation/screens/purchase/purchase_view.dart';
import 'package:moodlog/presentation/screens/settings/settings_view.dart';
import 'package:moodlog/presentation/screens/statistics/statistics_view.dart';
import 'package:moodlog/presentation/screens/tag_detail/tag_detail_view.dart';
import 'package:moodlog/presentation/screens/tags/tags_view.dart';
import 'package:moodlog/presentation/screens/write/write_view.dart';
import 'package:moodlog/presentation/screens/ai_analysis_report/ai_analysis_report_view.dart';
import 'package:provider/provider.dart';

GoRouter router(
  AppStateProvider appStateProvider,
  NavigatorObserver? analyticsObserver,
) => GoRouter(
  initialLocation: Routes.home,
  redirect: _redirect,
  refreshListenable: appStateProvider,
  observers: [?analyticsObserver],
  routes: [
    GoRoute(
      path: Routes.lock,
      builder: (_, state) {
        return const LockScreen();
      },
    ),
    GoRoute(
      path: Routes.onboarding,
      builder: (_, state) {
        return const OnboardingScreen();
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
    GoRoute(
      path: Routes.home,
      builder: (_, _) {
        return const HomeScreen();
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
    GoRoute(
      path: Routes.purchase,
      builder: (_, _) {
        return const PurchaseScreen();
      },
    ),
    GoRoute(
      path: Routes.aiAnalysisReport,
      builder: (_, _) {
        return const AiAnalysisReportScreen();
      },
    ),
  ],
);

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  final AppStateProvider appStateProvider = context.read<AppStateProvider>();
  final bool isOnboardingComplete =
      appStateProvider.appState.isOnboardingComplete;
  final bool isAppLockEnabled = appStateProvider.appState.isAppLockEnabled;
  final bool isAuthenticated = appStateProvider.isAuthenticated;
  final String location = state.matchedLocation;
  final bool isOnboarding = location == Routes.onboarding;
  final bool isLockScreen = location == Routes.lock;

  if (!isOnboardingComplete && !isOnboarding) {
    return Routes.onboarding;
  }

  if (isOnboardingComplete && isOnboarding) {
    return Routes.home;
  }

  if (isAppLockEnabled && !isAuthenticated && !isLockScreen && !isOnboarding) {
    return Routes.lock;
  }

  if (isAuthenticated && isLockScreen) {
    return Routes.home;
  }

  return null;
}
