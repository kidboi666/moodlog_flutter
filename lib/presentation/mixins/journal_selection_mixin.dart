import 'package:flutter/material.dart';
import 'package:moodlog/core/mixins/async_state_mixin.dart';
import 'package:moodlog/domain/entities/timeline_entry.dart';
import 'package:moodlog/domain/use_cases/check_in_use_case.dart';
import 'package:moodlog/domain/use_cases/journal_use_case.dart';

mixin JournalSelectionMixin on ChangeNotifier, AsyncStateMixin {
  JournalUseCase get journalUseCase;
  CheckInUseCase get checkInUseCase;
  List<TimelineEntry> get timelineEntries;

  bool _isSelectionMode = false;
  final Set<int> _selectedTimelineIds = {};

  bool get isSelectionMode => _isSelectionMode;

  Set<int> get selectedJournalIds => Set.from(_selectedTimelineIds);

  void toggleSelectionMode() {
    _isSelectionMode = !_isSelectionMode;
    if (!_isSelectionMode) {
      _selectedTimelineIds.clear();
    }
    notifyListeners();
  }

  void toggleJournalSelection(int id) {
    if (_selectedTimelineIds.contains(id)) {
      _selectedTimelineIds.remove(id);
    } else {
      _selectedTimelineIds.add(id);
    }
    notifyListeners();
  }

  void clearSelection() {
    _isSelectionMode = false;
    _selectedTimelineIds.clear();
    notifyListeners();
  }

  Future<void> deleteSelectedJournals() async {
    final entriesToDelete = timelineEntries
        .where((entry) => _selectedTimelineIds.contains(entry.id))
        .toList();

    for (final entry in entriesToDelete) {
      if (entry.type.isJournal) {
        await journalUseCase.deleteJournalById(entry.id);
      } else if (entry.type.isCheckIn) {
        await checkInUseCase.deleteCheckIn(entry.id);
      }
    }

    _selectedTimelineIds.clear();
    _isSelectionMode = false;
    notifyListeners();
  }
}
