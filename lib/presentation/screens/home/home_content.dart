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
      bottomNavigationBar: const SafeArea(child: BannerAdWidget()),
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
                    CommonSizedBox.heightXl,
                    FadeIn(
                      delay: DelayMS.medium * 3,
                      child: const UnifiedCalendarWidget(),
                    ),
                    CommonSizedBox.heightXl,
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: Spacing.containerHorizontalPadding,
              sliver: TimelineSliverList(),
            ),
            const SliverToBoxAdapter(child: CommonSizedBox.homeBottomPadding),
          ],
        ),
      ),
      floatingActionButton: isSelectionMode
          ? null
          : const HomeFloatingActionButton(),
    );
  }
}
