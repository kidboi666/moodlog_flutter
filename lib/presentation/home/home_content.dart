part of 'home_view.dart';

class _HomeScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isSelectionMode =
        context.select((HomeViewModel vm) => vm.isSelectionMode);

    return Scaffold(
      appBar: const _HomeAppBar(),
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
      floatingActionButton:
          isSelectionMode ? null : const _HomeFloatingActionButton(),
    );
  }
}

class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _HomeAppBar();

  @override
  Widget build(BuildContext context) {
    final (:isSelectionMode, :selectedJournalIds) = context.select(
      (HomeViewModel vm) => (
        isSelectionMode: vm.isSelectionMode,
        selectedJournalIds: vm.selectedJournalIds,
      ),
    );

    return AppBar(
      title: isSelectionMode
          ? Text(
              '${selectedJournalIds.length} selected',
              style: Theme.of(context).textTheme.titleLarge,
            )
          : const TitleBar(),
      automaticallyImplyLeading: false,
      actions: isSelectionMode
          ? const [_CancelSelectionButton(), _DeleteSelectionButton()]
          : [
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
              ),
            ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CancelSelectionButton extends StatelessWidget {
  const _CancelSelectionButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.cancel),
      onPressed: () => context.read<HomeViewModel>().clearSelection(),
    );
  }
}

class _DeleteSelectionButton extends StatelessWidget {
  const _DeleteSelectionButton();

  @override
  Widget build(BuildContext context) {
    final selectedJournalIds =
        context.read<HomeViewModel>().selectedJournalIds;
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () async {
        final shouldDelete = await showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text("Confirm Deletion"),
              content: Text(
                "Are you sure you want to delete ${selectedJournalIds.length} journal entries?",
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => context.pop(false),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () => context.pop(true),
                  child: const Text("Delete"),
                ),
              ],
            );
          },
        );
        if (shouldDelete == true) {
          if (context.mounted) {
            context.read<HomeViewModel>().deleteSelectedJournals();
          }
        }
      },
    );
  }
}

class _HomeFloatingActionButton extends StatelessWidget {
  const _HomeFloatingActionButton();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => context.push(Routes.write),
      child: const Icon(Icons.create),
    );
  }
}
