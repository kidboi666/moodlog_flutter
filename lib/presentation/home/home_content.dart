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
      body: Glower(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: Spacing.containerHorizontalPadding,
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    const WelcomeZone(),
                    const SizedBox(height: Spacing.xl),
                    const HorizontalCalendar(),
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
      floatingActionButton: isSelectionMode ? null : const _HomeActionButtons(),
    );
  }
}

class _HomeActionButtons extends StatelessWidget {
  const _HomeActionButtons();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0), // This handles the FAB's default start margin
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CalendarButton(),
          const HomeFloatingActionButton(),
        ],
      ),
    );
  }
}

