import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/common.dart';
import '../../core/router/routes.dart';
import '../../core/utils/animated_container.dart';

class ScaffoldWithNavbar extends StatelessWidget {
  final List<Widget> children;
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavbar({
    super.key,
    required this.children,
    required this.navigationShell,
  });

  void _onTap(int index) {
    final currentIndex = navigationShell.currentIndex > 2
        ? navigationShell.currentIndex - 1
        : navigationShell.currentIndex;
    final nextIndex = index > 2 ? index - 1 : index;
    navigationShell.goBranch(
      nextIndex,
      initialLocation: currentIndex == nextIndex,
    );
  }

  int _setSelectedIndex(index) {
    switch (index) {
      case 0:
        return 0;
      case 1:
        return 1;
      case 2:
        return 3;
      case 3:
        return 4;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: AnimatedNavigatorContainer(
        currentIndex: navigationShell.currentIndex,
        children: children,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40.0),
            topLeft: Radius.circular(40.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40.0),
            topLeft: Radius.circular(40.0),
          ),
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            child: NavigationBar(
              elevation: 0,
              animationDuration: DurationMs.lazy,
              selectedIndex: _setSelectedIndex(navigationShell.currentIndex),
              onDestinationSelected: _onTap,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home_filled),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.book_outlined),
                  selectedIcon: Icon(Icons.book),
                  label: 'Entries',
                ),
                NavigationDestination(
                  icon: SizedBox(),
                  label: '',
                  enabled: false,
                ),
                NavigationDestination(
                  icon: Icon(Icons.query_stats),
                  selectedIcon: Icon(Icons.query_stats_rounded),
                  label: 'Statistics',
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(Routes.write),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
