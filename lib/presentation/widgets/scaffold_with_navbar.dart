import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/constants/common.dart';
import '../../common/constants/navigation.dart';
import '../../common/extensions/widget_scale.dart';
import '../../common/routing/routes.dart';
import '../../common/utils/animated_container.dart';
import 'banner_ad_widget.dart';

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
    return Scaffold(
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
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_filled),
            label: Navigation.home,
          ).scale(),
          const NavigationDestination(
            icon: Icon(Icons.book_outlined),
            selectedIcon: Icon(Icons.book),
            label: Navigation.entries,
          ).scale(),
          NavigationDestination(
            icon: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 28),
            ),
            selectedIcon: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 28),
            ),
            label: Navigation.write,
          ).scale(),
          const NavigationDestination(
            icon: Icon(Icons.query_stats_sharp),
            selectedIcon: Icon(Icons.query_stats),
            label: Navigation.statistics,
          ).scale(),
          const NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: Navigation.settings,
          ).scale(),
        ],
      ),
    );
  }
}
