import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../presentation/view_models/home/home_viewmodel.dart';
import '../presentation/view_models/write/write_viewmodel.dart';
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
                final homeViewModel = HomeViewModel(
                  journalRepository: context.read(),
                );
                return HomeScreen(viewModel: homeViewModel);
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
                final viewModel = WriteViewModel();
                return WriteScreen(viewModel: viewModel);
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
