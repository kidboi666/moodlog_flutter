part of 'journal_view.dart';

class _JournalScreenContent extends StatelessWidget {
  void _handleBackNavigation(BuildContext context, JournalViewModel viewModel) {
    if (viewModel.shouldReplaceOnPop) {
      context.replace(Routes.home);
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final viewModel = context.read<JournalViewModel>();
    final (:isLoading, :journal, :align) = context.select(
      (JournalViewModel vm) => (
        isLoading: vm.isLoading,
        journal: vm.journal,
        align: vm.currentAlign,
      ),
    );

    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        leading: PopButton(
          onTap: () => _handleBackNavigation(context, viewModel),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: Spacing.sm,
          children: [
            Text(
              DateFormat(
                'yyyy.MM.dd',
              ).format(journal?.createdAt ?? DateTime.now()),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              DateFormat('HH:mm').format(journal?.createdAt ?? DateTime.now()),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(
                  context,
                ).textTheme.titleMedium?.color?.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) async {
              switch (value) {
                case 'align':
                  viewModel.changeAlign();
                  break;
                case 'edit':
                  context.push('${Routes.write}?editJournalId=${viewModel.id}');
                  break;
                case 'delete':
                  final shouldPopPage = await showDialog(
                    context: context,
                    builder: (context) => DeleteConfirmDialog(
                      viewModel: viewModel,
                      id: viewModel.id,
                    ),
                  );
                  if (shouldPopPage) {
                    if (context.mounted) {
                      _handleBackNavigation(context, viewModel);
                    }
                  }
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'align',
                child: Row(
                  children: [
                    Icon(align.icon),
                    CommonSizedBox.widthSm,
                    Text(t.journal_menu_change_align),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    const Icon(Icons.edit),
                    CommonSizedBox.widthSm,
                    Text(t.journal_menu_edit),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    const Icon(Icons.delete),
                    CommonSizedBox.widthSm,
                    Text(t.journal_menu_delete),
                  ],
                ),
              ),
            ],
          ).scale(),
        ],
      ),
      body: ListView(
        children: [
          FadeIn(
            delay: DelayMS.quick,
            child: ContentBox(viewModel: viewModel, currentAlign: align),
          ),
        ],
      ),
    );
  }
}
