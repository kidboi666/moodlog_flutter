import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/ui/widgets/banner_ad_widget.dart';
import '../../constants/common.dart';
import '../../constants/navigation.dart';
import '../../extensions/widget.dart';
import '../../l10n/app_localizations.dart';
import '../../routing/routes.dart';
import '../../utils/animated_container.dart';

class ScaffoldWithNavbar extends StatelessWidget {
  final List<Widget> children;
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavbar({
    super.key,
    required this.children,
    required this.navigationShell,
  });

  void _onTap(BuildContext context, int index) {
    if (index == Navigation.fabPlaceholderIndex) {
      context.push(Routes.write);
      return;
    }

    final shellIndex = Navigation.shellIndexMap[index] ?? 0;
    final currentShellIndex = navigationShell.currentIndex;

    navigationShell.goBranch(
      shellIndex,
      initialLocation: currentShellIndex == shellIndex,
    );
  }

  int _getNavigationIndex(int shellIndex) {
    return Navigation.navigationIndexMap[shellIndex] ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return GlowingOverscrollIndicator(
      axisDirection: AxisDirection.down,
      color: colorScheme.secondary,
      child: Scaffold(
        extendBody: true,
        body: AnimatedNavigatorContainer(
          currentIndex: navigationShell.currentIndex,
          children: children,
        ),
        persistentFooterButtons: [
          Container(padding: EdgeInsets.zero, child: BannerAdWidget()),
        ],
        bottomNavigationBar: NavigationBar(
          animationDuration: DurationMs.lazy,
          selectedIndex: _getNavigationIndex(navigationShell.currentIndex),
          onDestinationSelected: (index) => _onTap(context, index),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home_filled),
              label: t.tab_home,
            ).scale(),
            NavigationDestination(
              icon: const Icon(Icons.book_outlined),
              selectedIcon: const Icon(Icons.book),
              label: t.tab_entries,
            ).scale(),
            NavigationDestination(
              icon: const Icon(Icons.create),
              label: t.tab_write,
            ).scale(),
            NavigationDestination(
              icon: const Icon(Icons.query_stats_sharp),
              selectedIcon: const Icon(Icons.query_stats),
              label: t.tab_statistics,
            ).scale(),
            NavigationDestination(
              icon: const Icon(Icons.settings_outlined),
              selectedIcon: const Icon(Icons.settings),
              label: t.tab_settings,
            ).scale(),
          ],
        ),
      ),
    );
  }
}
