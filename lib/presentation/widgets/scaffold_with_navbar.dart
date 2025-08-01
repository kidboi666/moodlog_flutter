import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/common.dart';
import '../../core/constants/navigation.dart';
import '../../core/extensions/widget_scale.dart';
import '../../core/routing/routes.dart';
import '../../core/utils/animated_container.dart';
import 'banner_ad_widget.dart';

class ScaffoldWithNavbar extends StatelessWidget {
  final List<Widget> children;
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavbar({
    super.key,
    required this.children,
    required this.navigationShell,
  });

  void _onTap(int index) {
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
        onDestinationSelected: _onTap,
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
          const NavigationDestination(
            icon: Icon(Icons.query_stats_sharp),
            selectedIcon: Icon(Icons.query_stats),
            label: Navigation.entries,
          ).scale(),
          const NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: Navigation.settings,
          ).scale(),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(Routes.write),
        child: const Icon(Icons.add, size: 28),
      ).scale(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
