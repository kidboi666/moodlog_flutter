import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/presentation/screens/home/home_view_model.dart';
import 'package:moodlog/presentation/screens/home/widgets/title_bar.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final (:isSelectionMode, :selectedJournalIds, :calendarViewMode) = context
        .select(
          (HomeViewModel vm) => (
            isSelectionMode: vm.isSelectionMode,
            selectedJournalIds: vm.selectedJournalIds,
            calendarViewMode: vm.calendarViewMode,
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
              IconButton(
                icon: Icon(
                  calendarViewMode == CalendarViewMode.horizontal
                      ? Icons.calendar_view_month_outlined
                      : Icons.view_week_outlined,
                ),
                onPressed: () => viewModel.toggleCalendarView(),
              ),
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
    final viewModel = context.read<HomeViewModel>();
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
            viewModel.deleteSelectedJournals();
          }
        }
      },
    );
  }
}
