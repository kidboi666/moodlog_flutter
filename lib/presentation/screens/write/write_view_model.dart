import 'package:flutter/material.dart';
import 'package:moodlog/core/mixins/async_state_mixin.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';
import 'package:moodlog/domain/entities/journal/location_info.dart';
import 'package:moodlog/domain/entities/journal/weather_info.dart';
import 'package:moodlog/domain/models/create_journal_request.dart';
import 'package:moodlog/domain/models/update_journal_request.dart';
import 'package:moodlog/domain/repositories/image_repository.dart';
import 'package:moodlog/domain/use_cases/get_current_location_use_case.dart';
import 'package:moodlog/domain/use_cases/journal_use_case.dart';
import 'package:moodlog/domain/use_cases/weather_use_case.dart';

class WriteViewModel extends ChangeNotifier with AsyncStateMixin {
  final ImageRepository _imageRepository;
  final JournalUseCase _journalUseCase;
  final GetCurrentLocationUseCase _getCurrentLocationUseCase;
  final WeatherUseCase _weatherUseCase;

  WriteViewModel({
    required ImageRepository imageRepository,
    required JournalUseCase journalUseCase,
    required GetCurrentLocationUseCase getCurrentLocationUseCase,
    required WeatherUseCase weatherUseCase,
    DateTime? selectedDate,
    int? editJournalId,
  }) : _imageRepository = imageRepository,
       _journalUseCase = journalUseCase,
       _getCurrentLocationUseCase = getCurrentLocationUseCase,
       _weatherUseCase = weatherUseCase,
       _selectedDate = selectedDate ?? DateTime.now(),
       _editJournalId = editJournalId,
       _isEditMode = editJournalId != null {
    _initialize();
  }

  late TextEditingController _textEditingController;
  String? _content;
  List<String> _selectedImageList = [];
  bool _isSubmitted = false;
  int? _submittedJournalId;
  DateTime _selectedDate;
  LocationInfo? _locationInfo;
  bool _isLoadingLocation = false;
  WeatherInfo? _weatherInfo;
  bool _isLoadingWeather = false;
  final bool _isEditMode;
  final int? _editJournalId;

  TextEditingController get textEditingController => _textEditingController;

  String? get content => _content;

  DateTime get selectedDate => _selectedDate;

  List<String> get selectedImageList => _selectedImageList;

  bool get isSubmitted => _isSubmitted;

  int? get submittedJournalId => _submittedJournalId;

  LocationInfo? get locationInfo => _locationInfo;

  bool get isLoadingLocation => _isLoadingLocation;

  WeatherInfo? get weatherInfo => _weatherInfo;

  bool get isLoadingWeather => _isLoadingWeather;

  bool get isEditMode => _isEditMode;

  bool get isFormValid {
    return _content != null && _content!.trim().isNotEmpty;
  }

  void _initialize() {
    _textEditingController = TextEditingController();
    _textEditingController.addListener(_onTextChanged);
    _loadCurrentLocationOnInit();
    _loadCurrentWeatherOnInit();
    if (_isEditMode) {
      _loadJournalForEdit(_editJournalId!);
    }
  }

  void _onTextChanged() {
    final plainText = _textEditingController.text;
    updateContent(plainText);
  }

  void updateContent(String? value) {
    if (_content != value) {
      _content = value;
      notifyListeners();
    }
  }

  void deleteImage(String imageUri) {
    _selectedImageList = _selectedImageList
        .where((uri) => uri != imageUri)
        .toList();
    notifyListeners();
  }

  void resetForm() {
    _content = null;
    _textEditingController.clear();
    _selectedImageList = [];
    _isSubmitted = false;
    _submittedJournalId = null;
    _locationInfo = null;
    _isLoadingLocation = false;
    _weatherInfo = null;
    _isLoadingWeather = false;
    clearState();
    notifyListeners();
  }

  Future<void> pickImage() async {
    setLoading();
    final result = await _imageRepository.pickImageFromGallery();
    switch (result) {
      case Ok<String?>():
        if (result.value != null) {
          debugPrint('Image picked successfully');
          _selectedImageList = [..._selectedImageList, result.value!];
        }
        setSuccess();
      case Error<String?>():
        debugPrint('Failed to pick image: ${result.error}');
        setError(result.error);
    }
  }

  void clearWeather() {
    _weatherInfo = null;
    notifyListeners();
    getCurrentWeather();
  }

  Future<void> getCurrentWeather() async {
    double latitude = 37.5665; // 서울 기본 위치
    double longitude = 126.9780;

    // 위치 정보가 있으면 사용, 없으면 서울 기본 위치 사용
    if (_locationInfo != null) {
      latitude = _locationInfo!.latitude;
      longitude = _locationInfo!.longitude;
      debugPrint('Using actual location: $latitude, $longitude');
    } else {
      debugPrint('Using default location (Seoul): $latitude, $longitude');
    }

    _isLoadingWeather = true;
    notifyListeners();

    final result = await _weatherUseCase.getCurrentWeather(
      latitude: latitude,
      longitude: longitude,
    );

    switch (result) {
      case Ok<WeatherInfo>():
        debugPrint('Weather retrieved successfully');
        _weatherInfo = result.value;
      case Error<WeatherInfo>():
        debugPrint('Failed to get weather: ${result.error}');
        setError(result.error);
    }

    _isLoadingWeather = false;
    notifyListeners();
  }

  void clearLocation() {
    _locationInfo = null;
    notifyListeners();
  }

  void updateSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  Future<void> getCurrentLocation() async {
    _isLoadingLocation = true;
    notifyListeners();

    final result = await _getCurrentLocationUseCase();

    switch (result) {
      case Ok<LocationInfo>():
        debugPrint('Location retrieved successfully');
        _locationInfo = result.value;
      case Error<LocationInfo>():
        debugPrint('Failed to get location: ${result.error}');
        setError(result.error);
    }

    _isLoadingLocation = false;
    notifyListeners();
  }

  Future<Result<void>> submitJournal() async {
    if (!isFormValid) {
      debugPrint('Content is required');
      return Result.error(Exception('Content is required'));
    }

    setLoading();
    _isSubmitted = false;
    _submittedJournalId = null;

    if (_isEditMode) {
      return _updateExistingJournal();
    } else {
      return _createNewJournal();
    }
  }

  Future<Result<void>> _createNewJournal() async {
    final newJournal = CreateJournalRequest(
      content: _content!,
      imageUri: _selectedImageList.isEmpty ? null : _selectedImageList,
      createdAt: _selectedDate,
      latitude: _locationInfo?.latitude,
      longitude: _locationInfo?.longitude,
      address: _locationInfo?.address,
      temperature: _weatherInfo?.temperature,
      weatherIcon: _weatherInfo?.icon,
      weatherDescription: _weatherInfo?.description,
    );
    final result = await _journalUseCase.createJournal(newJournal);

    switch (result) {
      case Ok<int>():
        debugPrint('Journal added successfully');
        _isSubmitted = true;
        _submittedJournalId = result.value;
        setSuccess();
        return Result.ok(null);
      case Error<int>():
        debugPrint('Failed to add journal: ${result.error}');
        setError(result.error);
        return Result.error(result.error);
    }
  }

  Future<Result<void>> _updateExistingJournal() async {
    final updateJournal = UpdateJournalRequest(
      id: _editJournalId!,
      content: _content!,
      imageUri: _selectedImageList.isEmpty ? null : _selectedImageList,
      latitude: _locationInfo?.latitude,
      longitude: _locationInfo?.longitude,
      address: _locationInfo?.address,
      temperature: _weatherInfo?.temperature,
      weatherIcon: _weatherInfo?.icon,
      weatherDescription: _weatherInfo?.description,
    );

    final result = await _journalUseCase.updateJournal(updateJournal);

    switch (result) {
      case Ok<int>():
        debugPrint('Journal updated successfully');
        _isSubmitted = true;
        _submittedJournalId = _editJournalId;
        await _journalUseCase.notifyJournalUpdate();
        setSuccess();
        return Result.ok(null);
      case Error<int>():
        debugPrint('Failed to update journal: ${result.error}');
        setError(result.error);
        return Result.error(result.error);
    }
  }

  Future<void> _loadCurrentLocationOnInit() async {
    _isLoadingLocation = true;
    notifyListeners();

    final result = await _getCurrentLocationUseCase();

    switch (result) {
      case Ok<LocationInfo>():
        debugPrint('Location retrieved successfully on init');
        _locationInfo = result.value;
        // 위치 정보가 로드되면 자동으로 날씨 정보도 로드
        await getCurrentWeather();
      case Error<LocationInfo>():
        debugPrint('Failed to get location on init: ${result.error}');
    }

    _isLoadingLocation = false;
    notifyListeners();
  }

  Future<void> _loadCurrentWeatherOnInit() async {
    // 위치 정보 로드를 잠시 기다렸다가 날씨 정보 로드 (기본 위치 사용)
    await Future.delayed(Duration(milliseconds: 500));
    await getCurrentWeather();
  }

  Future<void> _loadJournalForEdit(int journalId) async {
    try {
      debugPrint('Loading journal for edit: $journalId');
      final result = await _journalUseCase.getJournalById(journalId);
      switch (result) {
        case Ok<Journal?>():
          final journal = result.value;
          if (journal == null) {
            debugPrint('Journal not found');
            break;
          }
          debugPrint('Journal loaded successfully: ${journal.content}');
          _content = journal.content;
          _textEditingController.text = journal.content;
          _selectedImageList = journal.imageUri ?? [];
          _selectedDate = journal.createdAt;

          if (journal.latitude != null && journal.longitude != null) {
            _locationInfo = LocationInfo(
              latitude: journal.latitude!,
              longitude: journal.longitude!,
              address: journal.address,
            );
          }

          if (journal.temperature != null) {
            _weatherInfo = WeatherInfo(
              temperature: journal.temperature!,
              icon: journal.weatherIcon ?? '',
              description: journal.weatherDescription ?? '',
              humidity: 0.0,
              pressure: 0.0,
              windSpeed: 0.0,
              location: journal.address ?? '',
              timestamp: journal.createdAt,
            );
          }

          notifyListeners();
        case Error<Journal?>():
          debugPrint('Failed to load journal for edit: ${result.error}');
      }
    } catch (e) {
      debugPrint('Error loading journal for edit: $e');
    }
  }

  @override
  void dispose() {
    _textEditingController.removeListener(_onTextChanged);
    _textEditingController.dispose();
    _selectedImageList.clear();
    super.dispose();
  }
}
