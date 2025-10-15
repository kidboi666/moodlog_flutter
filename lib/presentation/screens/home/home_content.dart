part of 'home_view.dart';

class _HomeScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isSelectionMode = context.select(
      (HomeViewModel vm) => vm.isSelectionMode,
    );

    return Scaffold(
      appBar: const HomeAppBar(),
      endDrawer: const AppDrawer(),
      bottomNavigationBar: const SafeArea(
        child: BannerAdWidget(),
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<HomeViewModel>().refresh(),
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: Spacing.containerHorizontalPadding,
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    FadeIn(
                      delay: DelayMS.medium * 2,
                      child: const WelcomeZone(),
                    ),
                    const SizedBox(height: Spacing.xl),
                    FadeIn(
                      delay: DelayMS.medium * 3,
                      child: const UnifiedCalendarWidget(),
                    ),
                    const SizedBox(height: Spacing.xl),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: Spacing.containerHorizontalPadding,
              sliver: JournalSliverList(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: kBottomNavigationBarHeight * 3),
            ),
          ],
        ),
      ),
      floatingActionButton: isSelectionMode
          ? null
          : const HomeFloatingActionButton(),
    );
  }
}
