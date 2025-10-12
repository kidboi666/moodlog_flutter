import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/extensions/routing.dart';
import '../../../core/ui/widgets/empty_entries_box.dart';
import '../../../core/ui/widgets/fade_in.dart';
import '../../../core/ui/widgets/journal_card.dart';
import '../home_view_model.dart';

class JournalSliverList extends StatelessWidget {
  const JournalSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    final (
      :isFirstRender,
      :journal,
      :isLoading,
      :selectedDate,
      :isSelectedDateInFuture,
      :isSelectionMode,
      :selectedJournalIds,
    ) = context.select(
      (HomeViewModel vm) => (
        isFirstRender: vm.isFirstRender,
        journal: vm.journal,
        isLoading: vm.isLoading,
        selectedDate: vm.selectedDate,
        isSelectedDateInFuture: vm.isSelectedDateInFuture,
        isSelectionMode: vm.isSelectionMode,
        selectedJournalIds: vm.selectedJournalIds,
      ),
    );

    if (isLoading) {
      return SliverToBoxAdapter(
        child: FadeIn(
          delay: isFirstRender ? DelayMS.medium * 5 : DelayMS.medium,
          child: const CircularProgressIndicator(),
        ),
      );
    }

    if (journal.isEmpty) {
      return SliverToBoxAdapter(
        child: FadeIn(
          delay: isFirstRender ? DelayMS.medium * 5 : DelayMS.medium,
          child: EmptyEntriesBox(
            isDisabled: isSelectedDateInFuture,
            selectedDate: selectedDate,
          ),
        ),
      );
    }

    return SliverList(
      key: ValueKey(selectedDate),
      delegate: SliverChildBuilderDelegate((context, index) {
        final e = journal[index];
        return FadeIn(
          delay: isFirstRender ? DelayMS.medium * (5 + index) : DelayMS.medium,
          child: Dismissible(
            key: ValueKey(e.id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Theme.of(context).colorScheme.error,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: Spacing.xl),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            confirmDismiss: (direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Confirm Deletion"),
                    content: const Text("Are you sure you want to delete this journal entry?"),
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
            },
            onDismissed: (direction) {
              context.read<HomeViewModel>().deleteJournal(e.id);
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: Spacing.xl),
                          child: JournalCard(
                            id: e.id,
                            content: e.content ?? '',
                            moodType: e.moodType,
                            coverImg: e.imageUri?.isNotEmpty == true ? e.imageUri!.first : null,
                            createdAt: e.createdAt,
                            isSelectable: isSelectionMode,
                            isSelected: selectedJournalIds.contains(e.id),
                            onTap: isSelectionMode
                                ? () => context.read<HomeViewModel>().toggleJournalSelection(e.id)
                                : () => context.pushToJournalFromHome(e.id),
                            onLongPress: () => context.read<HomeViewModel>().toggleSelectionMode(),
                          ),            ),
          ),
        );
      }, childCount: journal.length),
    );
  }
}
