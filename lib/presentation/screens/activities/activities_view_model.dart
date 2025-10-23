import 'package:flutter/material.dart';
import 'package:moodlog/core/mixins/async_state_mixin.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/journal/activity_with_count.dart';
import 'package:moodlog/domain/use_cases/activity_use_case.dart';

class ActivitiesViewModel extends ChangeNotifier with AsyncStateMixin {
  final ActivityUseCase _activityUseCase;

  ActivitiesViewModel(this._activityUseCase) {
    _loadActivities();
  }

  List<ActivityWithCount> _activities = [];

  List<ActivityWithCount> get activities => _filteredActivities;

  List<ActivityWithCount> _filteredActivities = [];
  String _searchQuery = '';

  Future<void> _loadActivities() async {
    setLoading();
    final result = await _activityUseCase.getActivitiesWithCount();
    switch (result) {
      case Ok(value: final activities):
        _activities = activities;
        _filteredActivities = activities;
        setSuccess();
      case Error(error: final error):
        setError(error);
    }
  }

  void searchActivities(String query) {
    _searchQuery = query;
    if (_searchQuery.isEmpty) {
      _filteredActivities = _activities;
    } else {
      _filteredActivities = _activities
          .where(
            (activityWithCount) => activityWithCount.activity.name.toLowerCase().contains(
              _searchQuery.toLowerCase(),
            ),
          )
          .toList();
    }
    notifyListeners();
  }

  Future<void> addActivity(String name) async {
    final result = await _activityUseCase.addActivity(name, null);
    if (result is Ok) {
      await _loadActivities();
    }
  }

  Future<void> deleteActivity(int id) async {
    final result = await _activityUseCase.deleteActivity(id);
    if (result is Ok) {
      await _loadActivities();
    }
  }

  Future<void> updateActivity(int id, String newName) async {
    final result = await _activityUseCase.updateActivity(id, newName, null);
    if (result is Ok) {
      await _loadActivities();
    }
  }
}
