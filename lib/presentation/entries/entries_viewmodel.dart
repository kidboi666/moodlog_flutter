import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/domain/use_cases/observe_journal_list_use_case.dart';

import '../../core/constants/enum.dart';
import '../../core/mixins/async_state_mixin.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/journal/journal.dart';
import '../../domain/entities/journal/tag.dart';
import '../../domain/use_cases/journal_use_case.dart';
import '../../domain/use_cases/tag_use_case.dart';

enum EntriesViewMode { list, calendar }

class EntriesViewModel extends ChangeNotifier with AsyncStateMixin {
  final JournalUseCase _journalUseCase;
  final ObserveJournalListUseCase _observeJournalListUseCase;
  final TagUseCase _tagUseCase;

  EntriesViewModel({
    required JournalUseCase journalUseCase,
    required ObserveJournalListUseCase observeJournalListUseCase,
    required TagUseCase tagUseCase,
  }) : _journalUseCase = journalUseCase,
       _observeJournalListUseCase = observeJournalListUseCase,
       _tagUseCase = tagUseCase {
    _load();
  }

  final Logger _log = Logger('EntriesViewModel');
  StreamSubscription? _journalSubscription;
  DateTime selectedDate = DateTime.now();
  DateTime _selectedMonth = DateTime.now();
  DateTime? _selectedDay;
  List<Journal> _entries = [];
  List<Journal> _allMonthEntries = [];
  EntriesViewMode _viewMode = EntriesViewMode.list;
  List<Tag> _availableTags = [];
  Tag? _selectedTagFilter;
  MoodType? _selectedMoodFilter;

  List<Journal> get entries => _entries;

  DateTime get selectedMonth => _selectedMonth;

  DateTime? get selectedDay => _selectedDay;

  EntriesViewMode get viewMode => _viewMode;

  List<Tag> get availableTags => _availableTags;

  Tag? get selectedTagFilter => _selectedTagFilter;

  MoodType? get selectedMoodFilter => _selectedMoodFilter;

  Future<void> _load() async {
    setLoading();
    try {
      await Future.wait([_loadMonthEntries(), _loadAllTags()]);
      _subscribeToJournalChanges();
      _log.fine('Data loaded successfully');
      setSuccess();
    } catch (e) {
      _log.warning('Failed to load data', e);
      setError(e);
    }
  }

  void toggleViewMode() {
    _viewMode = _viewMode == EntriesViewMode.list
        ? EntriesViewMode.calendar
        : EntriesViewMode.list;
    _selectedDay = null;
    notifyListeners();
  }

  void selectDay(DateTime day) {
    _selectedDay = day;
    notifyListeners();
  }

  Future<void> setPreviousMonth() async {
    _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1, 1);
    _selectedDay = null; // 월 변경 시 선택된 날짜 초기화

    setLoading();
    try {
      await _loadMonthEntries();
      setSuccess();
    } catch (e) {
      _log.warning('Failed to load month entries', e);
      setError(e);
    }
  }

  Future<void> setNextMonth() async {
    _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1, 1);
    _selectedDay = null; // 월 변경 시 선택된 날짜 초기화

    setLoading();
    try {
      await _loadMonthEntries();
      setSuccess();
    } catch (e) {
      _log.warning('Failed to load month entries', e);
      setError(e);
    }
  }

  Future<void> deleteJournal(int id) async {
    setLoading();
    final result = await _journalUseCase.deleteJournal(id);
    switch (result) {
      case Ok<void>():
        _log.fine('Journal deleted successfully');
        setSuccess();
      case Failure<void>():
        _log.warning('Failed to delete journal: ${result.error}');
        setError(result.error);
    }
  }

  Future<void> setTagFilter(Tag? tag) async {
    _selectedTagFilter = tag;
    await _applyFilters();
    notifyListeners();
  }

  Future<void> clearTagFilter() async {
    _selectedTagFilter = null;
    await _applyFilters();
    notifyListeners();
  }

  Future<void> setMoodFilter(MoodType? mood) async {
    _selectedMoodFilter = mood;
    await _applyFilters();
    notifyListeners();
  }

  Future<void> clearMoodFilter() async {
    _selectedMoodFilter = null;
    await _applyFilters();
    notifyListeners();
  }

  Future<void> clearAllFilters() async {
    _selectedTagFilter = null;
    _selectedMoodFilter = null;
    await _applyFilters();
    notifyListeners();
  }

  Future<void> _loadMonthEntries() async {
    final result = await _journalUseCase.getJournalsByMonth(_selectedMonth);
    switch (result) {
      case Ok<List<Journal>>():
        _log.fine('Loaded journals');
        _allMonthEntries = result.value;
        await _applyFilters();
      case Failure<List<Journal>>():
        _log.warning('Failed to load journals', result.error);
        _allMonthEntries = [];
        _entries = [];
        throw result.error;
    }
  }

  Future<void> _loadAllTags() async {
    final result = await _tagUseCase.getAllTags();
    switch (result) {
      case Ok<List<Tag>>():
        _log.fine('Loaded tags');
        _availableTags = result.value;
      case Failure<List<Tag>>():
        _log.warning('Failed to load tags: ${result.error}');
        _availableTags = [];
    }
  }

  Future<void> _applyFilters() async {
    List<Journal> filteredEntries = _allMonthEntries;

    if (_selectedMoodFilter != null) {
      filteredEntries = filteredEntries
          .where((journal) => journal.moodType == _selectedMoodFilter)
          .toList();
    }

    if (_selectedTagFilter != null) {
      final tagFilteredEntries = <Journal>[];
      for (final journal in filteredEntries) {
        final tagsResult = await _tagUseCase.getTagsByJournalId(journal.id);
        switch (tagsResult) {
          case Ok<List<Tag>>():
            if (tagsResult.value.any(
              (tag) => tag.id == _selectedTagFilter!.id,
            )) {
              tagFilteredEntries.add(journal);
            }
          case Failure<List<Tag>>():
            _log.warning('Failed to get tags for journal ${journal.id}');
        }
      }
      filteredEntries = tagFilteredEntries;
    }

    _entries = filteredEntries;
  }

  Future<void> _filterJournalsForSelectedMonth(
    List<Journal> allJournals,
  ) async {
    final startOfMonth = DateTime(_selectedMonth.year, _selectedMonth.month, 1);
    final endOfMonth = DateTime(
      _selectedMonth.year,
      _selectedMonth.month + 1,
      0,
      23,
      59,
      59,
      999,
    );

    _allMonthEntries = allJournals.where((journal) {
      return journal.createdAt.isAfter(startOfMonth) &&
          journal.createdAt.isBefore(endOfMonth);
    }).toList();

    await _applyFilters();
    notifyListeners();
  }

  void _subscribeToJournalChanges() {
    _journalSubscription = _observeJournalListUseCase.call().listen((
      journals,
    ) async {
      await _filterJournalsForSelectedMonth(journals);
    });
  }

  @override
  void dispose() {
    _journalSubscription?.cancel();
    super.dispose();
  }
}
