import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/extensions/routing.dart';
import 'package:moodlog/domain/entities/timeline_entry.dart';
import 'package:moodlog/presentation/screens/home/home_view_model.dart';
import 'package:moodlog/presentation/widgets/empty_entries_box.dart';
import 'package:moodlog/presentation/widgets/fade_in.dart';
import 'package:moodlog/presentation/widgets/timeline_card.dart';
import 'package:moodlog/presentation/widgets/timeline_item.dart';
import 'package:provider/provider.dart';

class TimelineSliverList extends StatelessWidget {
  const TimelineSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    final (
      :isFirstRender,
      :timelineEntries,
      :selectedDate,
      :isSelectedDateInFuture,
      :isSelectionMode,
      :selectedJournalIds,
    ) = context.select(
      (HomeViewModel vm) => (
        isFirstRender: vm.isFirstRender,
        timelineEntries: vm.timelineEntries,
        selectedDate: vm.selectedDate,
        isSelectedDateInFuture: vm.isSelectedDateInFuture,
        isSelectionMode: vm.isSelectionMode,
        selectedJournalIds: vm.selectedJournalIds,
      ),
    );

    if (timelineEntries.isEmpty) {
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
        final entry = timelineEntries[index];
        final isFirst = index == 0;
        final isLast = index == timelineEntries.length - 1;

        return FadeIn(
          delay: isFirstRender ? DelayMS.medium * (5 + index) : DelayMS.medium,
          child: TimelineItem(
            time: entry.createdAt,
            isFirst: isFirst,
            isLast: isLast,
            moodType: entry.type.isCheckIn ? entry.checkIn?.moodType : null,
            child: entry.type.isJournal
                ? _buildJournalEntry(context, entry, isSelectionMode, selectedJournalIds)
                : _buildCheckInEntry(context, entry),
          ),
        );
      }, childCount: timelineEntries.length),
    );
  }

  Widget _buildJournalEntry(
    BuildContext context,
    TimelineEntry entry,
    bool isSelectionMode,
    Set<int> selectedJournalIds,
  ) {

    return Dismissible(
      key: ValueKey('journal_${entry.id}'),
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
        context.read<HomeViewModel>().deleteJournal(entry.id);
      },
      child: TimelineCard(
        entry: entry,
        isSelectable: isSelectionMode,
        isSelected: selectedJournalIds.contains(entry.id),
        onTap: isSelectionMode
            ? () => context
                  .read<HomeViewModel>()
                  .toggleJournalSelection(entry.id)
            : () => context.pushToJournalFromHome(entry.id),
        onLongPress: () =>
            context.read<HomeViewModel>().toggleSelectionMode(),
      ),
    );
  }

  Widget _buildCheckInEntry(BuildContext context, TimelineEntry entry) {
    return TimelineCard(
      entry: entry,
      onTap: () {
        // TODO: Navigate to CheckIn detail screen
        debugPrint('CheckIn tapped: ${entry.id}');
      },
    );
  }
}
