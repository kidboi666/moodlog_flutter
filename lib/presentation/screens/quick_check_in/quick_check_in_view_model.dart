import 'package:flutter/foundation.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/mixins/async_state_mixin.dart';
import 'package:moodlog/core/mixins/step_mixin.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/models/create_quick_check_in_request.dart';
import 'package:moodlog/domain/use_cases/create_quick_check_in_use_case.dart';

class QuickCheckInViewModel extends ChangeNotifier
    with StepMixin, AsyncStateMixin {
  final CreateQuickCheckInUseCase _createQuickCheckInUseCase;

  QuickCheckInViewModel({
    required int totalSteps,
    required CreateQuickCheckInUseCase createQuickCheckInUseCase,
  }) : _createQuickCheckInUseCase = createQuickCheckInUseCase {
    initStep(totalSteps);
    _createdAt = DateTime.now();
  }

  MoodType? _selectedMood;
  final List<String> _selectedTags = [];
  final List<String> _selectedEmotions = [];
  String _memo = '';
  late DateTime _createdAt;

  MoodType? get selectedMood => _selectedMood;
  List<String> get selectedTags => List.unmodifiable(_selectedTags);
  List<String> get selectedEmotions => List.unmodifiable(_selectedEmotions);
  String get memo => _memo;
  DateTime get createdAt => _createdAt;

  bool get canProceedFromMoodPage => _selectedMood != null;

  void selectMood(MoodType mood) {
    _selectedMood = mood;
    notifyListeners();
  }

  void addTag(String tag) {
    if (!_selectedTags.contains(tag)) {
      _selectedTags.add(tag);
      notifyListeners();
    }
  }

  void removeTag(String tag) {
    _selectedTags.remove(tag);
    notifyListeners();
  }

  void clearTags() {
    _selectedTags.clear();
    notifyListeners();
  }

  void addEmotion(String emotion) {
    if (!_selectedEmotions.contains(emotion)) {
      _selectedEmotions.add(emotion);
      notifyListeners();
    }
  }

  void removeEmotion(String emotion) {
    _selectedEmotions.remove(emotion);
    notifyListeners();
  }

  void clearEmotions() {
    _selectedEmotions.clear();
    notifyListeners();
  }

  void setMemo(String value) {
    _memo = value;
    notifyListeners();
  }

  void updateDateTime(DateTime dateTime) {
    _createdAt = dateTime;
    notifyListeners();
  }

  Future<bool> submitCheckIn({
    double? latitude,
    double? longitude,
    String? address,
    double? temperature,
    String? weatherIcon,
    String? weatherDescription,
  }) async {
    if (_selectedMood == null) {
      setError(Exception('Mood is required'));
      return false;
    }

    setLoading();
    try {
      final request = CreateQuickCheckInRequest(
        moodType: _selectedMood!,
        content: _memo.isEmpty ? null : _memo,
        tagNames: _selectedTags.isEmpty ? null : _selectedTags,
        emotionNames: _selectedEmotions.isEmpty ? null : _selectedEmotions,
        createdAt: _createdAt,
        latitude: latitude,
        longitude: longitude,
        address: address,
        temperature: temperature,
        weatherIcon: weatherIcon,
        weatherDescription: weatherDescription,
      );

      final result = await _createQuickCheckInUseCase.createQuickCheckIn(request);

      switch (result) {
        case Ok<int>():
          setSuccess();
          return true;
        case Error<int>():
          setError(result.error);
          return false;
      }
    } catch (e) {
      debugPrint('Failed to submit quick check-in: $e');
      setError(e);
      return false;
    }
  }

  void reset() {
    _selectedMood = null;
    _selectedTags.clear();
    _selectedEmotions.clear();
    _memo = '';
    _createdAt = DateTime.now();
    setStep(0);
    clearState();
  }
}
