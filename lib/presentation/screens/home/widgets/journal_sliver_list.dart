import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/extensions/routing.dart';
import 'package:moodlog/presentation/screens/home/home_view_model.dart';
import 'package:moodlog/presentation/widgets/empty_entries_box.dart';
import 'package:moodlog/presentation/widgets/fade_in.dart';
import 'package:moodlog/presentation/widgets/journal_card.dart';
import 'package:moodlog/presentation/widgets/timeline_item.dart';
import 'package:provider/provider.dart';

class JournalSliverList extends StatelessWidget {
  const JournalSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    final (
      :isFirstRender,
      :journal,
      :selectedDate,
      :isSelectedDateInFuture,
      :isSelectionMode,
      :selectedJournalIds,
    ) = context.select(
      (HomeViewModel vm) => (
        isFirstRender: vm.isFirstRender,
        journal: vm.journal,
        selectedDate: vm.selectedDate,
        isSelectedDateInFuture: vm.isSelectedDateInFuture,
        isSelectionMode: vm.isSelectionMode,
        selectedJournalIds: vm.selectedJournalIds,
      ),
    );

    if (journal.isEmpty) {
      return SliverToBoxAdapter(
        child: FadeIn(
          delay: isFirstRender ? DelayMS.medium * 4 : DelayMS.medium,
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
        final isFirst = index == 0;
        final isLast = index == journal.length - 1;

        return FadeIn(
          delay: isFirstRender ? DelayMS.medium * (5 + index) : DelayMS.medium,
          child: TimelineItem(
            time: e.createdAt,
            isFirst: isFirst,
            isLast: isLast,
            child: Dismissible(
              key: ValueKey(e.id),
              direction: DismissDirection.endToStart,
              background: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error,
                  borderRadius: BorderRadius.circular(Roundness.card),
                ),
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
                      content: const Text(
                        "Are you sure you want to delete this journal entry?",
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
              },
              onDismissed: (direction) {
                context.read<HomeViewModel>().deleteJournal(e.id);
              },
              child: JournalCard(
                id: e.id,
                content: e.content,
                coverImg: e.imageUri?.isNotEmpty == true
                    ? e.imageUri!.first
                    : null,
                createdAt: e.createdAt,
                isSelectable: isSelectionMode,
                isSelected: selectedJournalIds.contains(e.id),
                onTap: isSelectionMode
                    ? () => context
                          .read<HomeViewModel>()
                          .toggleJournalSelection(e.id)
                    : () => context.pushToJournalFromHome(e.id),
                onLongPress: () =>
                    context.read<HomeViewModel>().toggleSelectionMode(),
              ),
            ),
          ),
        );
      }, childCount: journal.length),
    );
  }
}
