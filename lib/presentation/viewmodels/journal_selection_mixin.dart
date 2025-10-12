import 'package:flutter/material.dart';
import 'package:moodlog/core/mixins/async_state_mixin.dart';
import 'package:moodlog/domain/use_cases/journal_use_case.dart';

mixin JournalSelectionMixin on ChangeNotifier, AsyncStateMixin {
  JournalUseCase get journalUseCase;

  bool _isSelectionMode = false;
  final Set<int> _selectedJournalIds = {};

  bool get isSelectionMode => _isSelectionMode;
  Set<int> get selectedJournalIds => Set.from(_selectedJournalIds);

  void toggleSelectionMode() {
    _isSelectionMode = !_isSelectionMode;
    if (!_isSelectionMode) {
      _selectedJournalIds.clear();
    }
    notifyListeners();
  }

  void toggleJournalSelection(int id) {
    if (_selectedJournalIds.contains(id)) {
      _selectedJournalIds.remove(id);
    } else {
      _selectedJournalIds.add(id);
    }
    notifyListeners();
  }

  void clearSelection() {
    _isSelectionMode = false;
    _selectedJournalIds.clear();
    notifyListeners();
  }

  Future<void> deleteSelectedJournals() async {
    setLoading();
    for (final id in _selectedJournalIds) {
      await journalUseCase.deleteJournalById(id);
    }
    _selectedJournalIds.clear();
    _isSelectionMode = false;
    setSuccess();
  }
}
