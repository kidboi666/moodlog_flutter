import 'package:flutter/foundation.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/mixins/async_state_mixin.dart';
import 'package:moodlog/core/mixins/step_mixin.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/models/create_quick_check_in_request.dart';
import 'package:moodlog/domain/use_cases/create_quick_check_in_use_case.dart';
import 'package:moodlog/domain/use_cases/get_current_location_use_case.dart';
import 'package:moodlog/domain/use_cases/weather_use_case.dart';

class QuickCheckInViewModel extends ChangeNotifier
    with StepMixin, AsyncStateMixin {
  final CreateQuickCheckInUseCase _createQuickCheckInUseCase;
  final GetCurrentLocationUseCase _getCurrentLocationUseCase;
  final WeatherUseCase _weatherUseCase;

  QuickCheckInViewModel({
    required int totalSteps,
    required CreateQuickCheckInUseCase createQuickCheckInUseCase,
    required GetCurrentLocationUseCase getCurrentLocationUseCase,
    required WeatherUseCase weatherUseCase,
  })  : _createQuickCheckInUseCase = createQuickCheckInUseCase,
        _getCurrentLocationUseCase = getCurrentLocationUseCase,
        _weatherUseCase = weatherUseCase {
    initStep(totalSteps);
    _createdAt = DateTime.now();
    _loadWeatherData();
  }

  MoodType _selectedMood = MoodType.neutral;
  int? _sleepQuality;
  final List<String> _selectedTags = [];
  final List<String> _selectedEmotions = [];
  String _memo = '';
  late DateTime _createdAt;

  double? _latitude;
  double? _longitude;
  String? _address;
  double? _temperature;
  String? _weatherIcon;
  String? _weatherDescription;
  bool _isLoadingWeather = false;

  MoodType get selectedMood => _selectedMood;
  int? get sleepQuality => _sleepQuality;
  List<String> get selectedTags => List.unmodifiable(_selectedTags);
  List<String> get selectedEmotions => List.unmodifiable(_selectedEmotions);
  String get memo => _memo;
  DateTime get createdAt => _createdAt;
  double? get temperature => _temperature;
  String? get weatherDescription => _weatherDescription;
  bool get isLoadingWeather => _isLoadingWeather;

  bool get canProceedFromMoodPage => true;

  void selectMood(MoodType mood) {
    _selectedMood = mood;
    notifyListeners();
  }

  void setSleepQuality(int quality) {
    _sleepQuality = quality;
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

  Future<void> _loadWeatherData() async {
    _isLoadingWeather = true;
    notifyListeners();

    try {
      final locationResult = await _getCurrentLocationUseCase.call();

      switch (locationResult) {
        case Ok():
          final location = locationResult.value;
          _latitude = location.latitude;
          _longitude = location.longitude;
          _address = location.address;

          final weatherResult = await _weatherUseCase.getCurrentWeather(
            latitude: location.latitude,
            longitude: location.longitude,
          );

          switch (weatherResult) {
            case Ok():
              final weather = weatherResult.value;
              _temperature = weather.temperature;
              _weatherIcon = weather.icon;
              _weatherDescription = weather.description;
            case Error():
              break;
          }
        case Error():
          break;
      }
    } catch (e) {
      debugPrint('Failed to load weather data: $e');
    } finally {
      _isLoadingWeather = false;
      notifyListeners();
    }
  }

  Future<bool> submitCheckIn() async {
    setLoading();
    try {
      final request = CreateQuickCheckInRequest(
        moodType: _selectedMood,
        content: _memo.isEmpty ? null : _memo,
        tagNames: _selectedTags.isEmpty ? null : _selectedTags,
        emotionNames: _selectedEmotions.isEmpty ? null : _selectedEmotions,
        createdAt: _createdAt,
        latitude: _latitude,
        longitude: _longitude,
        address: _address,
        temperature: _temperature,
        weatherIcon: _weatherIcon,
        weatherDescription: _weatherDescription,
      );

      final result = await _createQuickCheckInUseCase.createQuickCheckIn(
        request,
      );

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
    _selectedMood = MoodType.neutral;
    _sleepQuality = null;
    _selectedTags.clear();
    _selectedEmotions.clear();
    _memo = '';
    _createdAt = DateTime.now();
    _latitude = null;
    _longitude = null;
    _address = null;
    _temperature = null;
    _weatherIcon = null;
    _weatherDescription = null;
    _isLoadingWeather = false;
    setStep(0);
    clearState();
    _loadWeatherData();
  }
}
