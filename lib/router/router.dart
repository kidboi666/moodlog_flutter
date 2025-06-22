import 'package:go_router/go_router.dart';

import '../presentation/views/entries/entries_screen.dart';
import '../presentation/views/home/home_screen.dart';
import '../presentation/views/journal/journal_screen.dart';
import '../presentation/views/settings/settings_screen.dart';
import '../presentation/views/write/write_screen.dart';
import '../presentation/widgets/scaffold_with_navbar.dart';
import 'routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: Routes.home,
  routes: <RouteBase>[
    StatefulShellRoute(
      builder: (context, state, navigationShell) => navigationShell,
      navigatorContainerBuilder: (context, navigationShell, children) {
        return ScaffoldWithNavbar(
          navigationShell: navigationShell,
          children: children,
        );
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: Routes.home,
              builder: (context, state) {
                return HomeScreen();
              },
              routes: [
                GoRoute(
                  path: Routes.journal(':id'),
                  builder: (context, state) {
                    return JournalScreen(id: state.pathParameters['id']);
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: Routes.entries,
              builder: (context, state) {
                return EntriesScreen();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: Routes.settings,
              builder: (context, state) {
                return SettingsScreen();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: Routes.write,
              builder: (context, state) {
                return WriteScreen();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
