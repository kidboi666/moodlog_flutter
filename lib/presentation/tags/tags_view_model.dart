import 'package:flutter/material.dart';
import 'package:moodlog/core/mixins/async_state_mixin.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/journal/tag_with_count.dart';
import 'package:moodlog/domain/use_cases/tag_use_case.dart';

class TagsViewModel extends ChangeNotifier with AsyncStateMixin {
  final TagUseCase _tagUseCase;

  TagsViewModel(this._tagUseCase) {
    _loadTags();
  }

  List<TagWithCount> _tags = [];
  List<TagWithCount> get tags => _filteredTags; // UI는 필터링된 리스트를 사용

  List<TagWithCount> _filteredTags = [];
  String _searchQuery = '';

  Future<void> _loadTags() async {
    setLoading();
    final result = await _tagUseCase.getTagsWithCount();
    switch (result) {
      case Ok(value: final tags):
        _tags = tags;
        _filteredTags = tags; // 처음에는 전체 리스트를 보여줌
        setSuccess();
      case Error(error: final error):
        setError(error);
    }
  }

  void searchTags(String query) {
    _searchQuery = query;
    if (_searchQuery.isEmpty) {
      _filteredTags = _tags;
    } else {
      _filteredTags = _tags
          .where((tagWithCount) => tagWithCount.tag.name
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  Future<void> addTag(String name) async {
    final result = await _tagUseCase.addTag(name, null);
    if (result is Ok) {
      await _loadTags();
    } else {
      // Handle error if needed
    }
  }

  Future<void> deleteTag(int id) async {
    final result = await _tagUseCase.deleteTag(id);
    if (result is Ok) {
      await _loadTags();
    } else {
      // Handle error if needed
    }
  }
}
