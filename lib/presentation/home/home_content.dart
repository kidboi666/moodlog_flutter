part of 'home_view.dart';

class _HomeScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitleBar(),
        automaticallyImplyLeading: false,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(Routes.write),
        child: const Icon(Icons.create),
      ),
    );
  }
}
