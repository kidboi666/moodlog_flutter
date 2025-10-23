import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/extensions/routing.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/domain/entities/timeline_entry.dart';
import 'package:moodlog/presentation/screens/home/home_view_model.dart';
import 'package:moodlog/presentation/widgets/empty_entries_box.dart';
import 'package:moodlog/presentation/widgets/fade_in.dart';
import 'package:moodlog/presentation/widgets/timeline_card.dart';
import 'package:moodlog/presentation/widgets/timeline_item.dart';
import 'package:provider/provider.dart';

class TimelineList extends StatelessWidget {
  final List<TimelineEntry> entries;
  final DateTime selectedDate;
  final bool isSelectedDateInFuture;
  final bool isCompact;
  final bool isFirstRender;
  final bool isSelectionMode;
  final Set<int> selectedJournalIds;

  const TimelineList({
    super.key,
    required this.entries,
    required this.selectedDate,
    this.isSelectedDateInFuture = false,
    this.isCompact = false,
    this.isFirstRender = false,
    this.isSelectionMode = false,
    this.selectedJournalIds = const {},
  });

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return EmptyEntriesBox(
        isDisabled: isSelectedDateInFuture,
        selectedDate: selectedDate,
      );
    }

    return ListView.builder(
      padding: isCompact ? CommonPadding.horizontalMd : EdgeInsets.zero,
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        final isFirst = index == 0;
        final isLast = index == entries.length - 1;

        Widget child = isCompact
            ? _buildCompactEntry(context, entry)
            : TimelineItem(
                time: entry.createdAt,
                isFirst: isFirst,
                isLast: isLast,
                child: entry.type.isJournal
                    ? _buildJournalEntry(context, entry)
                    : _buildCheckInEntry(context, entry),
              );

        if (isCompact) {
          return Padding(
            padding: const EdgeInsets.only(bottom: Spacing.md),
            child: child,
          );
        }

        return FadeIn(
          delay: isFirstRender ? DelayMS.medium * (5 + index) : DelayMS.medium,
          child: child,
        );
      },
    );
  }

  Widget _buildCompactEntry(BuildContext context, TimelineEntry entry) {
    return TimelineCard(
      entry: entry,
      onTap: () {
        if (entry.type.isJournal) {
          context.pushToJournalFromHome(entry.id);
        } else {
          debugPrint('CheckIn tapped: ${entry.id}');
        }
      },
    );
  }

  Widget _buildJournalEntry(BuildContext context, TimelineEntry entry) {
    final t = AppLocalizations.of(context)!;
    return Dismissible(
      key: ValueKey('journal_${entry.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.error,
          borderRadius: BorderRadius.circular(Roundness.card),
        ),
        alignment: Alignment.centerRight,
        padding: CommonPadding.horizontalXl,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(t.journal_delete_confirm_title),
              content: Text(t.journal_delete_confirm_description),
              actions: [
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
      },
      onDismissed: (direction) {
        context.read<HomeViewModel>().deleteJournal(entry.id);
      },
      child: TimelineCard(
        entry: entry,
        isSelectable: isSelectionMode,
        isSelected: selectedJournalIds.contains(entry.id),
        onTap: isSelectionMode
            ? () =>
                  context.read<HomeViewModel>().toggleJournalSelection(entry.id)
            : () => context.pushToJournalFromHome(entry.id),
        onLongPress: () => context.read<HomeViewModel>().toggleSelectionMode(),
      ),
    );
  }

  Widget _buildCheckInEntry(BuildContext context, TimelineEntry entry) {
    return TimelineCard(
      entry: entry,
      onTap: () {
        debugPrint('CheckIn tapped: ${entry.id}');
      },
    );
  }
}
