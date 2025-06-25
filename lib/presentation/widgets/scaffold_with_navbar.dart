import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/common.dart';
import '../../core/utils/animated_container.dart';
import '../../router/routes.dart';

class ScaffoldWithNavbar extends StatelessWidget {
  final List<Widget> children;
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavbar({
    super.key,
    required this.children,
    required this.navigationShell,
  });

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: AnimatedNavigatorContainer(
        currentIndex: navigationShell.currentIndex,
        children: children,
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(40.0),
        child: NavigationBar(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          animationDuration: const Duration(milliseconds: DurationMs.lazy),
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _onTap,
          destinations: const <Widget>[
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
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: 'Settings',
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(Routes.write),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
