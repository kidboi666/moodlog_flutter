import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import '../../../common/mixins/async_state_mixin.dart';
import '../../../common/utils/result.dart';
import '../../../domain/entities/journal.dart';
import '../../../domain/entities/tag.dart';
import '../../../domain/repositories/journal_repository.dart';
import '../../../domain/use_cases/journal/delete_journal_use_case.dart';
import '../../../domain/use_cases/tag/get_all_tags_use_case.dart';
import '../../../domain/use_cases/tag/get_tags_by_journal_use_case.dart';

enum EntriesViewMode { list, calendar }

class EntriesViewModel extends ChangeNotifier with AsyncStateMixin {
  final JournalRepository _journalRepository;
  final DeleteJournalUseCase _deleteJournalUseCase;
  final GetAllTagsUseCase _getAllTagsUseCase;
  final GetTagsByJournalUseCase _getTagsByJournalUseCase;

  EntriesViewModel({
    required JournalRepository journalRepository,
    required DeleteJournalUseCase deleteJournalUseCase,
    required GetAllTagsUseCase getAllTagsUseCase,
    required GetTagsByJournalUseCase getTagsByJournalUseCase,
  }) : _journalRepository = journalRepository,
       _deleteJournalUseCase = deleteJournalUseCase,
       _getAllTagsUseCase = getAllTagsUseCase,
       _getTagsByJournalUseCase = getTagsByJournalUseCase {
    _loadMonthEntries();
    _subscribeToJournalChanges();
    _loadAllTags();
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

  List<Journal> get entries => _entries;

  DateTime get selectedMonth => _selectedMonth;

  DateTime? get selectedDay => _selectedDay;

  EntriesViewMode get viewMode => _viewMode;

  List<Tag> get availableTags => _availableTags;

  Tag? get selectedTagFilter => _selectedTagFilter;

  void toggleViewMode() {
    _viewMode = _viewMode == EntriesViewMode.list
        ? EntriesViewMode.calendar
        : EntriesViewMode.list;
    _selectedDay = null; // 뷰 모드 변경 시 선택된 날짜 초기화
    notifyListeners();
  }

  void selectDay(DateTime day) {
    _selectedDay = day;
    notifyListeners();
  }

  void setPreviousMonth() {
    _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1, 1);
    _selectedDay = null; // 월 변경 시 선택된 날짜 초기화
    notifyListeners();
    _loadMonthEntries();
  }

  void setNextMonth() {
    _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1, 1);
    _selectedDay = null; // 월 변경 시 선택된 날짜 초기화
    notifyListeners();
    _loadMonthEntries();
  }

  Future<void> deleteJournal(int id) async {
    setLoading();
    await _deleteJournalUseCase.deleteJournal(id);
  }

  Future<void> _loadMonthEntries() async {
    setLoading();

    final result = await _journalRepository.getJournalsByMonth(_selectedMonth);
    switch (result) {
      case Ok<List<Journal>>():
        _allMonthEntries = result.value;
        _applyTagFilter();
        _log.fine('Loaded journals');
      case Failure<List<Journal>>():
        _allMonthEntries = [];
        _entries = [];
        setError(result.error);
        _log.warning('Failed to load journals', result.error);
    }
    setSuccess();
  }

  void _subscribeToJournalChanges() {
    _journalSubscription = _journalRepository.journalStream.listen((journals) {
      // 전체 일기 목록이 변경되었을 때, 현재 선택된 월의 일기만 필터링
      _filterJournalsForSelectedMonth(journals);
    });
  }

  void _filterJournalsForSelectedMonth(List<Journal> allJournals) {
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

    _applyTagFilter();
    notifyListeners();
  }

  Future<void> _loadAllTags() async {
    final result = await _getAllTagsUseCase.call();
    switch (result) {
      case Ok<List<Tag>>():
        _availableTags = result.value;
        notifyListeners();
      case Failure<List<Tag>>():
        _log.warning('Failed to load tags: ${result.error}');
    }
  }

  void setTagFilter(Tag? tag) {
    _selectedTagFilter = tag;
    _applyTagFilter();
    notifyListeners();
  }

  void clearTagFilter() {
    _selectedTagFilter = null;
    _applyTagFilter();
    notifyListeners();
  }

  Future<void> _applyTagFilter() async {
    if (_selectedTagFilter == null) {
      _entries = _allMonthEntries;
      return;
    }

    final filteredEntries = <Journal>[];
    for (final journal in _allMonthEntries) {
      final tagsResult = await _getTagsByJournalUseCase.call(journal.id);
      switch (tagsResult) {
        case Ok<List<Tag>>():
          if (tagsResult.value.any((tag) => tag.id == _selectedTagFilter!.id)) {
            filteredEntries.add(journal);
          }
        case Failure<List<Tag>>():
          _log.warning('Failed to get tags for journal ${journal.id}');
      }
    }
    _entries = filteredEntries;
  }

  @override
  void dispose() {
    _journalSubscription?.cancel();
    super.dispose();
  }
}
