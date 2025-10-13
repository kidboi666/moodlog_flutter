import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/home/home_view_model.dart';
import 'package:moodlog/presentation/screens/home/widgets/calendar_bottom_sheet.dart';
import 'package:moodlog/presentation/screens/home/widgets/waving_hand.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final viewModel = context.watch<HomeViewModel>();
    final (:isSelectionMode, :selectedJournalIds) = context.select(
      (HomeViewModel vm) => (
        isSelectionMode: vm.isSelectionMode,
        selectedJournalIds: vm.selectedJournalIds,
      ),
    );

    return AppBar(
      title: isSelectionMode
          ? Text(
              t.home_selection_count(selectedJournalIds.length),
              style: Theme.of(context).textTheme.titleLarge,
            )
          : Row(
              spacing: Spacing.sm,
              children: [
                Text(t.home_hello, style: TextTheme.of(context).displaySmall),
                const WavingHand(),
              ],
            ),
      automaticallyImplyLeading: false,
      actions: isSelectionMode
          ? const [_CancelSelectionButton(), _DeleteSelectionButton()]
          : [
              IconButton(
                icon: const Icon(Icons.calendar_today_outlined),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    clipBehavior: Clip.hardEdge,
                    builder: (_) => ChangeNotifierProvider.value(
                      value: viewModel,
                      child: const CalendarBottomSheet(),
                    ),
                  );
                },
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
    final t = AppLocalizations.of(context)!;
    final viewModel = context.read<HomeViewModel>();
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () async {
        final shouldDelete = await showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(t.journal_delete_confirm_title),
              content: Text(
                t.home_delete_journals_confirm_message(
                  viewModel.selectedJournalIds.length,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => context.pop(false),
                  child: Text(t.common_confirm_cancel),
                ),
                TextButton(
                  onPressed: () => context.pop(true),
                  child: Text(t.common_confirm_delete),
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
