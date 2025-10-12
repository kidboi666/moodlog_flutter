import 'package:flutter/material.dart';
import 'package:moodlog/core/mixins/async_state_mixin.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';
import 'package:moodlog/domain/entities/journal/tag.dart';
import 'package:moodlog/domain/use_cases/journal_use_case.dart';
import 'package:moodlog/domain/use_cases/tag_use_case.dart';
import 'package:moodlog/presentation/mixins/journal_selection_mixin.dart';

class TagDetailViewModel extends ChangeNotifier
    with AsyncStateMixin, JournalSelectionMixin {
  @override
  final JournalUseCase journalUseCase;
  final TagUseCase _tagUseCase;
  final int _tagId;

  TagDetailViewModel({
    required this.journalUseCase,
    required TagUseCase tagUseCase,
    required int tagId,
  }) : _tagUseCase = tagUseCase,
       _tagId = tagId {
    _load();
  }

  List<Journal> _journals = [];

  List<Journal> get journals => _journals;

  Tag? _tag;

  Tag? get tag => _tag;

  Future<void> _load() async {
    setLoading();
    await _loadTagDetails();
    await _loadJournals();
    setSuccess();
  }

  Future<void> _loadTagDetails() async {
    final result = await _tagUseCase.getTagById(_tagId);
    switch (result) {
      case Ok(value: final tag):
        _tag = tag;
        break;
      case Error():
        // Handle or log error if necessary
        break;
    }
  }

  Future<void> _loadJournals() async {
    final result = await journalUseCase.getJournalsByTagId(_tagId);
    if (result is Ok<List<Journal>>) {
      _journals = result.value;
    }
  }
}
