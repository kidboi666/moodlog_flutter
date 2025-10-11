part of 'home_view.dart';

class _HomeScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final (
      :isSelectionMode,
      :selectedJournalIds,
    ) = context.select(
      (HomeViewModel vm) => (
        isSelectionMode: vm.isSelectionMode,
        selectedJournalIds: vm.selectedJournalIds,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: isSelectionMode
            ? Text(
                '${selectedJournalIds.length} selected',
                style: Theme.of(context).textTheme.titleLarge,
              )
            : const TitleBar(),
        automaticallyImplyLeading: false,
        actions: isSelectionMode
            ? [
                IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () =>
                      context.read<HomeViewModel>().clearSelection(),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    final shouldDelete = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Confirm Deletion"),
                          content: Text(
                              "Are you sure you want to delete ${selectedJournalIds.length} journal entries?"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text("Delete"),
                            ),
                          ],
                        );
                      },
                    );
                    if (shouldDelete == true) {
                      context.read<HomeViewModel>().deleteSelectedJournals();
                    }
                  },
                ),
              ]
            : [
                Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                  ),
                ),
              ],
      ),
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
      floatingActionButton: isSelectionMode
          ? null
          : FloatingActionButton(
              onPressed: () => context.push(Routes.write),
              child: const Icon(Icons.create),
            ),
    );
  }
}
