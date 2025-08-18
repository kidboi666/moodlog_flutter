part of 'base_scaffold_screen.dart';

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

  bool _shouldUseRailNavigation(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= kBreakPoint;
  }

  int _getNavigationIndex(int shellIndex) {
    return Navigation.navigationIndexMap[shellIndex] ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final shouldUseRailNavigation = _shouldUseRailNavigation(context);

    return shouldUseRailNavigation
        ? _buildRailNavigation(context)
        : _buildBottomNavigation(context);
  }

  Widget _buildRailNavigation(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: _buildAppBar(context),
      persistentFooterButtons: [
        Container(padding: EdgeInsets.zero, child: BannerAdWidget()),
      ],
      body: RailNavigation(
        buildContent: _buildContent,
        navigationShell: navigationShell,
        getNavigationIndex: _getNavigationIndex,
        onTap: _onTap,
        children: children,
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: _buildAppBar(context),
      persistentFooterButtons: [
        Container(padding: EdgeInsets.zero, child: BannerAdWidget()),
      ],
      body: _buildContent(),
      bottomNavigationBar: BottomNavigation(
        navigationShell: navigationShell,
        getNavigationIndex: _getNavigationIndex,
        onTap: _onTap,
      ),
    );
  }

  Widget _buildContent() {
    return AnimatedNavigatorContainer(
      currentIndex: navigationShell.currentIndex,
      children: children,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: TitleBar(),
      actionsPadding: Spacing.containerHorizontalPadding,
      actions: [
        Builder(
          builder: (context) {
            final profileImage = context.select<BaseLayoutViewModel, String?>(
              (vm) => vm.profileImage,
            );
            return Avatar(
              photoUrl: profileImage,
              onTap: () => context.push(Routes.profile),
            );
          },
        ),
      ],
    );
  }
}
