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
        surfaceTintColor: Color(
          journal?.moodType.colorValue ?? MoodType.happy.colorValue,
        ),
        leading: PopButton(
          onTap: () => _handleBackNavigation(context, viewModel),
        ),
        title: Text(
          journal?.createdAt.formattedDotNation() ?? '',
          style: textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: viewModel.changeAlign,
            icon: Icon(align.icon),
          ).scale(),
          IconButton(
            onPressed: () {
              context.push('${Routes.write}?editJournalId=${viewModel.id}');
            },
            icon: const Icon(Icons.edit),
          ).scale(),
          IconButton(
            onPressed: () async {
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
            },
            icon: const Icon(Icons.delete),
          ).scale(),
        ],
      ),
      body: ListView(
        children: [
          IntrinsicHeight(
            child: FadeIn(
              delay: DelayMS.quick,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MoodBar(moodType: journal?.moodType ?? MoodType.happy),
                  ContentBox(viewModel: viewModel, currentAlign: align),
                ],
              ),
            ),
          ),
          const SizedBox(height: Spacing.lg),
          FadeIn(
            delay: DelayMS.quick * 2,
            child: AiResponseBox(viewModel: viewModel),
          ),
        ],
      ),
    );
  }
}
