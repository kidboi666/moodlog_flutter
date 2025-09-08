import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';

class RailNavigation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final Function getNavigationIndex;
  final Function onTap;
  final Widget Function() buildContent;

  const RailNavigation({
    super.key,
    required this.navigationShell,
    required this.getNavigationIndex,
    required this.onTap,
    required this.buildContent,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Row(
      children: [
        NavigationRail(
          selectedIndex: getNavigationIndex(navigationShell.currentIndex),
          onDestinationSelected: (index) => onTap(context, index),
          labelType: NavigationRailLabelType.all,
          destinations: [
            NavigationRailDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home_filled),
              label: Text(t.tab_home),
            ),
            NavigationRailDestination(
              icon: const Icon(Icons.book_outlined),
              selectedIcon: const Icon(Icons.book),
              label: Text(t.tab_entries),
            ),
            NavigationRailDestination(
              icon: const Icon(Icons.create),
              label: Text(t.tab_write),
            ),
            NavigationRailDestination(
              icon: const Icon(Icons.query_stats_sharp),
              selectedIcon: const Icon(Icons.query_stats),
              label: Text(t.tab_statistics),
            ),
            NavigationRailDestination(
              icon: const Icon(Icons.settings_outlined),
              selectedIcon: const Icon(Icons.settings),
              label: Text(t.tab_settings),
            ),
          ],
        ),
        const VerticalDivider(),
        Expanded(child: buildContent()),
      ],
    );
  }
}
