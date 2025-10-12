part of 'tag_detail_view.dart';

class _TagDetailScreenContent extends StatelessWidget {
  const _TagDetailScreenContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TagDetailViewModel>();
    final journals = viewModel.journals;

    return Scaffold(
      appBar: const _TagDetailAppBar(),
      body: Builder(
        builder: (context) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (viewModel.hasError) {
            return Center(child: Text('Error: ${viewModel.error}'));
          }
          if (journals.isEmpty) {
            return const Center(child: Text('No journals found for this tag.'));
          }
          return ListView.builder(
            itemCount: journals.length,
            itemBuilder: (context, index) {
              final journal = journals[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: JournalCard(
                  id: journal.id,
                  content: journal.content ?? '',
                  moodType: journal.moodType,
                  createdAt: journal.createdAt,
                  tags: journal.tags,
                  coverImg: journal.imageUri?.isNotEmpty == true
                      ? journal.imageUri!.first
                      : null,
                  isSelectable: viewModel.isSelectionMode,
                  isSelected: viewModel.selectedJournalIds.contains(journal.id),
                  onTap: viewModel.isSelectionMode
                      ? () => viewModel.toggleJournalSelection(journal.id)
                      : () => context.pushToJournalFromEntries(journal.id),
                  onLongPress: viewModel.toggleSelectionMode,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _TagDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _TagDetailAppBar();

  @override
  Widget build(BuildContext context) {
    final (:isSelectionMode, :selectedJournalIds, :tag, :journals) = context
        .select(
          (TagDetailViewModel vm) => (
            isSelectionMode: vm.isSelectionMode,
            selectedJournalIds: vm.selectedJournalIds,
            tag: vm.tag,
            journals: vm.journals,
          ),
        );

    return AppBar(
      title: Text(
        isSelectionMode
            ? '${selectedJournalIds.length} selected'
            : '${tag?.name ?? '...'} (${journals.length})',
      ),
      actions: isSelectionMode
          ? const [_CancelSelectionButton(), _DeleteSelectionButton()]
          : [],
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
      onPressed: () => context.read<TagDetailViewModel>().clearSelection(),
    );
  }
}

class _DeleteSelectionButton extends StatelessWidget {
  const _DeleteSelectionButton();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<TagDetailViewModel>();
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () async {
        final shouldDelete = await showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text("Confirm Deletion"),
              content: Text(
                "Are you sure you want to delete ${viewModel.selectedJournalIds.length} journal entries?",
              ),
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
          if (context.mounted) {
            viewModel.deleteSelectedJournals();
          }
        }
      },
    );
  }
}
