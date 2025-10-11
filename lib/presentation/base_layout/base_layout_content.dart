part of 'base_layout_view.dart';

class _BaseLayoutScreenContent extends StatelessWidget {
  final List<Widget> children;
  final StatefulNavigationShell navigationShell;

  const _BaseLayoutScreenContent({
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

  @override
  Widget build(BuildContext context) {
    return _buildBottomNavigation(context);
  }

  Widget _buildBottomNavigation(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      extendBody: true,
      appBar: _buildAppBar(context),
      endDrawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(child: Text(t.settings_title)),
                  const WeatherWidget(),
                  ListTile(
                    leading: const Icon(Icons.home_outlined),
                    title: Text(t.tab_home),
                    onTap: () {
                      _onTap(context, 0);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.book_outlined),
                    title: Text(t.tab_entries),
                    onTap: () {
                      _onTap(context, 1);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.query_stats_sharp),
                    title: Text(t.tab_statistics),
                    onTap: () {
                      _onTap(context, 3);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings_outlined),
                    title: Text(t.tab_settings),
                    onTap: () {
                      _onTap(context, 4);
                      Navigator.pop(context);
                    },
                  ),
                  const Divider(),
                  SectionHeader(title: t.settings_information_title),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: Text(t.settings_information_app_title),
                    onTap: () => showDialog(
                      context: context,
                      builder: (_) => AppInfoDialog(
                        viewModel: context.read<BaseLayoutViewModel>(),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.local_police_outlined),
                    title: Text(t.settings_information_license_title),
                    onTap: () => showLicensePage(context: context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.mail_outline),
                    title: Text(t.settings_information_qna_title),
                    onTap: () => showDialog(
                      context: context,
                      builder: (_) => ContactDialog(),
                    ),
                  ),
                ],
              ),
            ),
            SafeArea(child: context.read<BaseLayoutViewModel>().bannerAdWidget),
          ],
        ),
      ),
      body: _buildContent(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onTap(context, 2),
        child: const Icon(Icons.create),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return AnimatedNavigatorContainer(
      currentIndex: navigationShell.currentIndex,
      children: children,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: TitleBar(),
      actionsPadding: Spacing.containerHorizontalPadding,
      actions: [
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          ),
        ),
      ],
    );
  }
}
