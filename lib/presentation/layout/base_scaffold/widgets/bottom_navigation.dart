import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/extensions/widget.dart';

import '../../../../core/constants/common.dart';
import '../../../../core/l10n/app_localizations.dart';

class BottomNavigation extends StatelessWidget {
  final Function getNavigationIndex;
  final Function onTap;
  final StatefulNavigationShell navigationShell;

  const BottomNavigation({
    super.key,
    required this.getNavigationIndex,
    required this.onTap,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return NavigationBar(
      animationDuration: DurationMs.lazy,
      selectedIndex: getNavigationIndex(navigationShell.currentIndex),
      onDestinationSelected: (index) => onTap(context, index),
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
    );
  }
}
