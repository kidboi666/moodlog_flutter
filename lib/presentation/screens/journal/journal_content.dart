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
    final textTheme = Theme.of(context).textTheme;
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              journal?.createdAt.formattedDotNation() ?? '',
              style: textTheme.titleLarge,
            ),
            const SizedBox(width: Spacing.sm),
            Text(
              DateFormat('HH:mm').format(journal?.createdAt ?? DateTime.now()),
              style: textTheme.titleMedium?.copyWith(
                color: textTheme.titleMedium?.color?.withValues(alpha: 0.6),
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
                    builder: (context) =>
                        DeleteConfirmDialog(viewModel: viewModel, id: viewModel.id),
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
                    const SizedBox(width: Spacing.sm),
                    const Text('정렬 변경'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: Spacing.sm),
                    Text('수정'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete),
                    SizedBox(width: Spacing.sm),
                    Text('삭제'),
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
