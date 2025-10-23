import 'package:flutter/foundation.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/mixins/async_state_mixin.dart';
import 'package:moodlog/core/mixins/step_mixin.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/models/create_check_in_request.dart';
import 'package:moodlog/domain/models/update_check_in_request.dart';
import 'package:moodlog/domain/use_cases/check_in_use_case.dart';
import 'package:moodlog/domain/use_cases/get_current_location_use_case.dart';
import 'package:moodlog/domain/use_cases/weather_use_case.dart';

class QuickCheckInViewModel extends ChangeNotifier
    with StepMixin, AsyncStateMixin {
  final CheckInUseCase _checkInUseCase;
  final GetCurrentLocationUseCase _getCurrentLocationUseCase;
  final WeatherUseCase _weatherUseCase;
  final int? _checkInId;

  QuickCheckInViewModel({
    required int totalSteps,
    required CheckInUseCase checkInUseCase,
    required GetCurrentLocationUseCase getCurrentLocationUseCase,
    required WeatherUseCase weatherUseCase,
    int? checkInId,
    DateTime? selectedDate,
  })  : _checkInUseCase = checkInUseCase,
        _getCurrentLocationUseCase = getCurrentLocationUseCase,
        _weatherUseCase = weatherUseCase,
        _checkInId = checkInId {
    initStep(totalSteps);
    _createdAt = selectedDate ?? DateTime.now();

    if (isEditMode) {
      _loadExistingCheckIn();
    } else {
      _checkFirstCheckIn();
      _loadWeatherData();
    }
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
  bool _isFirstCheckInToday = true;
  bool _isCheckingFirstCheckIn = true;

  MoodType get selectedMood => _selectedMood;
  int? get sleepQuality => _sleepQuality;
  List<String> get selectedTags => List.unmodifiable(_selectedTags);
  List<String> get selectedEmotions => List.unmodifiable(_selectedEmotions);
  String get memo => _memo;
  DateTime get createdAt => _createdAt;
  double? get temperature => _temperature;
  String? get weatherDescription => _weatherDescription;
  bool get isLoadingWeather => _isLoadingWeather;
  bool get isFirstCheckInToday => _isFirstCheckInToday;
  bool get isCheckingFirstCheckIn => _isCheckingFirstCheckIn;
  bool get isEditMode => _checkInId != null;

  bool get canProceedFromMoodPage => true;

  void selectMood(MoodType mood) {
    _selectedMood = mood;
    notifyListeners();
  }

  void setSleepQuality(int quality) {
    _sleepQuality = quality;
    notifyListeners();
  }

  void addActivity(String tag) {
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

  Future<void> _checkFirstCheckIn() async {
    _isCheckingFirstCheckIn = true;
    notifyListeners();

    try {
      final result = await _checkInUseCase.hasTodayCheckIn();

      switch (result) {
        case Ok<bool>():
          _isFirstCheckInToday = !result.value;
        case Error<bool>():
          debugPrint('Failed to check first check-in: ${result.error}');
          _isFirstCheckInToday = true;
      }
    } catch (e) {
      debugPrint('Failed to check first check-in: $e');
      _isFirstCheckInToday = true;
    } finally {
      _isCheckingFirstCheckIn = false;
      notifyListeners();
    }
  }

  Future<void> _loadExistingCheckIn() async {
    if (_checkInId == null) return;

    _isCheckingFirstCheckIn = true;
    notifyListeners();

    try {
      final result = await _checkInUseCase.getCheckInById(_checkInId);

      switch (result) {
        case Ok():
          final checkIn = result.value;
          if (checkIn == null) {
            debugPrint('CheckIn not found');
            break;
          }
          _selectedMood = checkIn.moodType;
          _sleepQuality = checkIn.sleepQuality;
          _selectedTags.clear();
          if (checkIn.activityNames != null) {
            _selectedTags.addAll(checkIn.activityNames!);
          }
          _selectedEmotions.clear();
          if (checkIn.emotionNames != null) {
            _selectedEmotions.addAll(checkIn.emotionNames!);
          }
          _memo = checkIn.memo ?? '';
          _createdAt = checkIn.createdAt;
          _latitude = checkIn.latitude;
          _longitude = checkIn.longitude;
          _address = checkIn.address;
          _temperature = checkIn.temperature;
          _weatherIcon = checkIn.weatherIcon;
          _weatherDescription = checkIn.weatherDescription;
          _isFirstCheckInToday = false;
        case Error():
          debugPrint('Failed to load existing check-in: ${result.error}');
      }
    } catch (e) {
      debugPrint('Failed to load existing check-in: $e');
    } finally {
      _isCheckingFirstCheckIn = false;
      notifyListeners();
    }
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
      if (isEditMode) {
        final updateRequest = UpdateCheckInRequest(
          id: _checkInId!,
          moodType: _selectedMood,
          sleepQuality: _sleepQuality,
          emotionNames: _selectedEmotions.isEmpty ? null : _selectedEmotions,
          activityNames: _selectedTags.isEmpty ? null : _selectedTags,
          memo: _memo.isEmpty ? null : _memo,
          latitude: _latitude,
          longitude: _longitude,
          address: _address,
          temperature: _temperature,
          weatherIcon: _weatherIcon,
          weatherDescription: _weatherDescription,
        );

        final result = await _checkInUseCase.updateCheckIn(updateRequest);

        switch (result) {
          case Ok<int>():
            setSuccess();
            return true;
          case Error<int>():
            setError(result.error);
            return false;
        }
      } else {
        final request = CreateCheckInRequest(
          moodType: _selectedMood,
          createdAt: _createdAt,
          sleepQuality: _sleepQuality,
          emotionNames: _selectedEmotions.isEmpty ? null : _selectedEmotions,
          activityNames: _selectedTags.isEmpty ? null : _selectedTags,
          memo: _memo.isEmpty ? null : _memo,
          latitude: _latitude,
          longitude: _longitude,
          address: _address,
          temperature: _temperature,
          weatherIcon: _weatherIcon,
          weatherDescription: _weatherDescription,
        );

        final result = await _checkInUseCase.createCheckIn(request);

        switch (result) {
          case Ok<int>():
            setSuccess();
            return true;
          case Error<int>():
            setError(result.error);
            return false;
        }
      }
    } catch (e) {
      debugPrint('Failed to submit check-in: $e');
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
