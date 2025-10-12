import 'package:flutter/material.dart';

import '../../core/constants/enum.dart';
import '../../core/mixins/async_state_mixin.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/ai/ai_usage.dart';
import '../../domain/entities/journal/journal.dart';
import '../../domain/entities/journal/location_info.dart';
import '../../domain/entities/journal/tag.dart';
import '../../domain/entities/journal/weather_info.dart';
import '../../domain/models/create_journal_request.dart';
import '../../domain/models/update_journal_ai_response_request.dart';
import '../../domain/models/update_journal_request.dart';
import '../../domain/use_cases/check_ai_usage_use_case.dart';
import '../../domain/use_cases/gemini_use_case.dart';
import '../../domain/use_cases/get_current_location_use_case.dart';
import '../../domain/use_cases/journal_use_case.dart';
import '../../domain/use_cases/log_mood_entry_use_case.dart';
import '../../domain/use_cases/pick_image_use_case.dart';
import '../../domain/use_cases/settings_use_case.dart';
import '../../domain/use_cases/tag_use_case.dart';
import '../../domain/use_cases/weather_use_case.dart';
import '../../presentation/providers/app_state_provider.dart';
import '../providers/ai_generation_provider.dart';

class WriteViewModel extends ChangeNotifier with AsyncStateMixin {
  final GeminiUseCase _geminiUseCase;
  final AppStateProvider _appStateProvider;
  final AiGenerationProvider _aiGenerationProvider;
  final PickImageUseCase _pickImageUseCase;
  final SettingsUseCase _settingsUseCase;
  final GetCurrentLocationUseCase _getCurrentLocationUseCase;
  final WeatherUseCase _weatherUseCase;
  final JournalUseCase _journalUseCase;
  final CheckAiUsageUseCase _checkAiUsageUseCase;
  final LogMoodEntryUseCase _logMoodEntryUseCase;
  final TagUseCase _tagUseCase;

  WriteViewModel({
    required GeminiUseCase geminiUseCase,
    required AppStateProvider appStateProvider,
    required AiGenerationProvider aiGenerationProvider,
    required PickImageUseCase pickImageUseCase,
    required SettingsUseCase settingsUseCase,
    required GetCurrentLocationUseCase getCurrentLocationUseCase,
    required WeatherUseCase weatherUseCase,
    required JournalUseCase journalUseCase,
    required CheckAiUsageUseCase checkAiUsageUseCase,
    required TagUseCase tagUseCase,
    required LogMoodEntryUseCase logMoodEntryUseCase,
    DateTime? selectedDate,
    int? editJournalId,
  })  : _geminiUseCase = geminiUseCase,
        _appStateProvider = appStateProvider,
        _aiGenerationProvider = aiGenerationProvider,
        _pickImageUseCase = pickImageUseCase,
        _settingsUseCase = settingsUseCase,
        _getCurrentLocationUseCase = getCurrentLocationUseCase,
        _weatherUseCase = weatherUseCase,
        _journalUseCase = journalUseCase,
        _logMoodEntryUseCase = logMoodEntryUseCase,
        _checkAiUsageUseCase = checkAiUsageUseCase,
        _tagUseCase = tagUseCase,
        _selectedDate = selectedDate ?? DateTime.now(),
        _editJournalId = editJournalId,
        _isEditMode = editJournalId != null {
    _initialize();
  }

  late TextEditingController _textEditingController;
  String? _content;
  MoodType _selectedMood = MoodType.neutral;
  List<String> _selectedImageList = [];
  bool _isSubmitted = false;
  int? _submittedJournalId;
  bool _aiEnabled = true;
  DateTime _selectedDate;
  bool _canUseAiToday = true;
  int _aiUsageCount = 0;

  LocationInfo? _locationInfo;
  bool _isLoadingLocation = false;
  WeatherInfo? _weatherInfo;
  bool _isLoadingWeather = false;
  List<Tag> _availableTags = [];
  List<Tag> _selectedTags = [];
  final bool _isEditMode;
  final int? _editJournalId;

  TextEditingController get textEditingController => _textEditingController;

  String? get content => _content;

  bool get aiEnabled => _aiEnabled;

  MoodType get selectedMood => _selectedMood;

  DateTime get selectedDate => _selectedDate;

  List<String> get selectedImageList => _selectedImageList;

  bool get isSubmitted => _isSubmitted;

  int? get submittedJournalId => _submittedJournalId;

  bool get canUseAiToday => _canUseAiToday;

  int get aiUsageCount => _aiUsageCount;

  bool get isAiAvailable => _aiEnabled && _canUseAiToday;

  LocationInfo? get locationInfo => _locationInfo;

  bool get isLoadingLocation => _isLoadingLocation;

  WeatherInfo? get weatherInfo => _weatherInfo;

  bool get isLoadingWeather => _isLoadingWeather;

  List<Tag> get availableTags => _availableTags;

  bool get isEditMode => _isEditMode;

  List<Tag> get selectedTags => _selectedTags;

  bool get isFormValid {
    return true;
  }

  void _initialize() {
    _textEditingController = TextEditingController();
    _textEditingController.addListener(_onTextChanged);
    _checkAiUsage();
    _loadCurrentLocationOnInit();
    _loadCurrentWeatherOnInit();
    _loadAllTags();
    if (_isEditMode) {
      _loadJournalForEdit(_editJournalId!);
    }
  }

  void _onTextChanged() {
    final plainText = _textEditingController.text;
    updateContent(plainText);
  }

  void updateAiEnabled(bool value) {
    if (_canUseAiToday) {
      _aiEnabled = value;
      notifyListeners();
    }
  }

  void updateMoodType(MoodType value) {
    if (_selectedMood != value) {
      _selectedMood = value;
      notifyListeners();
    }
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
    _selectedMood = MoodType.neutral;
    _selectedImageList = [];
    _isSubmitted = false;
    _submittedJournalId = null;
    _aiEnabled = true;
    _locationInfo = null;
    _isLoadingLocation = false;
    _weatherInfo = null;
    _isLoadingWeather = false;
    _selectedTags.clear();
    _checkAiUsage();
    clearState();
    notifyListeners();
  }

  Future<void> pickImage() async {
    setLoading();
    final result = await _pickImageUseCase.fromGallery();
    switch (result) {
      case Ok<String?>():
        debugPrint('Image picked successfully');
        _selectedImageList = [..._selectedImageList, result.value!];
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

  void removeTag(Tag tag) {
    _selectedTags.remove(tag);
    notifyListeners();
  }

  Future<void> addNewTag(String tagName) async {
    final trimmedName = tagName.trim();
    if (trimmedName.isEmpty) return;

    final existingTag = _availableTags.firstWhere(
      (tag) => tag.name.toLowerCase() == trimmedName.toLowerCase(),
      orElse: () => Tag(id: -1, name: '', createdAt: DateTime.now()),
    );

    if (existingTag.id != -1) {
      addExistingTag(existingTag);
      return;
    }

    final result = await _tagUseCase.addTag(trimmedName, null);
    switch (result) {
      case Ok<Tag>():
        _availableTags.add(result.value);
        addExistingTag(result.value);
      case Error<Tag>():
        debugPrint('Failed to add tag: ${result.error}');
        setError(result.error);
    }
  }

  void addExistingTag(Tag tag) {
    if (!_selectedTags.contains(tag)) {
      _selectedTags.add(tag);
      notifyListeners();
    }
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
      content: _content,
      moodType: _selectedMood,
      imageUri: _selectedImageList,
      aiResponseEnabled: _aiEnabled,
      createdAt: _selectedDate,
      latitude: _locationInfo?.latitude,
      longitude: _locationInfo?.longitude,
      address: _locationInfo?.address,
      temperature: _weatherInfo?.temperature,
      weatherIcon: _weatherInfo?.icon,
      weatherDescription: _weatherInfo?.description,
      tagNames: _selectedTags.map((tag) => tag.name).toList(),
    );
    final result = await _journalUseCase.addJournal(newJournal);

    switch (result) {
      case Ok<Map<String, dynamic>>():
        debugPrint('Journal added successfully');
        _isSubmitted = true;
        _submittedJournalId = result.value['id'];
        final aiResponseEnabled = result.value['aiResponseEnabled'];

        if (_selectedTags.isNotEmpty) {
          await _tagUseCase.updateJournalTags(
            result.value['id'],
            _selectedTags.map((tag) => tag.id).toList(),
          );
        }

        _logMoodEntryUseCase(
          moodType: _selectedMood.name,
          entryType: 'manual',
          hasImage: _selectedImageList.isNotEmpty,
          hasTag: _selectedTags.isNotEmpty,
        );

        if (aiResponseEnabled == true) {
          _generateAiResponse();
        }
        setSuccess();
        return Result.ok(null);
      case Error<Map<String, dynamic>>():
        debugPrint('Failed to add journal: ${result.error}');
        setError(result.error);
        return Result.error(result.error);
    }
  }

  Future<Result<void>> _updateExistingJournal() async {
    final updateJournal = UpdateJournalRequest(
      id: _editJournalId!,
      aiResponseEnabled: _aiEnabled,
      content: _content,
      imageUri: _selectedImageList,
      latitude: _locationInfo?.latitude,
      longitude: _locationInfo?.longitude,
      address: _locationInfo?.address,
      moodType: _selectedMood,
      tagNames: _selectedTags.map((tag) => tag.name).toList(),
    );

    final result = await _journalUseCase.updateJournal(updateJournal);

    switch (result) {
      case Ok<int>():
        debugPrint('Journal updated successfully');
        _isSubmitted = true;
        _submittedJournalId = _editJournalId;

        // 태그 업데이트
        await _tagUseCase.updateJournalTags(
          _editJournalId,
          _selectedTags.map((tag) => tag.id).toList(),
        );

        // 태그 업데이트 후 journal stream에 변경사항 알림
        await _journalUseCase.notifyJournalUpdate();

        _logMoodEntryUseCase.call(
          moodType: _selectedMood.name,
          entryType: 'edit',
          hasImage: _selectedImageList.isNotEmpty,
          hasTag: _selectedTags.isNotEmpty,
        );

        setSuccess();
        return Result.ok(null);
      case Error<int>():
        debugPrint('Failed to update journal: ${result.error}');
        setError(result.error);
        return Result.error(result.error);
    }
  }

  Future<void> _checkAiUsage() async {
    _canUseAiToday = await _checkAiUsageUseCase();
    final usage = await _settingsUseCase.getAiUsage();
    final now = DateTime.now();

    if (usage != null) {
      final isSameDay =
          usage.date.year == now.year &&
          usage.date.month == now.month &&
          usage.date.day == now.day;
      if (isSameDay) {
        _aiUsageCount = usage.count;
      } else {
        _aiUsageCount = 0;
      }
    } else {
      _aiUsageCount = 0;
    }

    if (!_canUseAiToday) {
      _aiEnabled = false;
    }

    notifyListeners();
  }

  void _generateAiResponse() async {
    _aiGenerationProvider.setGeneratingAiResponse();

    // Record AI usage
    final now = DateTime.now();
    final usage = await _settingsUseCase.getAiUsage();
    if (usage != null) {
      final isSameDay =
          usage.date.year == now.year &&
          usage.date.month == now.month &&
          usage.date.day == now.day;
      if (isSameDay) {
        await _settingsUseCase.updateAiUsage(
          AiUsage(date: now, count: usage.count + 1),
        );
      } else {
        await _settingsUseCase.updateAiUsage(AiUsage(date: now, count: 1));
      }
    } else {
      await _settingsUseCase.updateAiUsage(AiUsage(date: now, count: 1));
    }
    _checkAiUsage();

    final aiPersonality = _appStateProvider.appState.aiPersonality;
    await _geminiUseCase.initialize(aiPersonality);
    final aiResponse = await _geminiUseCase.generateResponse(
      prompt: content!,
      moodType: selectedMood,
    );

    switch (aiResponse) {
      case Ok<String>():
        debugPrint('AI response generated successfully');
        final dto = UpdateJournalAiResponseRequest(
          id: _submittedJournalId!,
          aiResponseEnabled: true,
          aiResponse: aiResponse.value,
        );
        await _journalUseCase.updateJournalAiResponse(dto);
        _aiGenerationProvider.setSuccessGeneratingAiResponse();
      case Error<String>():
        debugPrint('Failed to add AI response: ${aiResponse.error}');
        _aiGenerationProvider.setErrorGeneratingAiResponse(aiResponse.error);
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

  Future<void> _loadAllTags() async {
    final result = await _tagUseCase.getAllTags();
    switch (result) {
      case Ok<List<Tag>>():
        _availableTags = result.value;
        notifyListeners();
      case Error<List<Tag>>():
        debugPrint('Failed to load tags: ${result.error}');
    }
  }

  Future<void> _loadJournalForEdit(int journalId) async {
    try {
      debugPrint('Loading journal for edit: $journalId');
      final result = await _journalUseCase.getJournalById(journalId);
      switch (result) {
        case Ok<Journal>():
          final journal = result.value;
          debugPrint('Journal loaded successfully: ${journal.content}');
          _content = journal.content;
          if (journal.content != null) {
            _textEditingController.text = journal.content!;
          }
          _selectedMood = journal.moodType;
          _selectedImageList = journal.imageUri ?? [];
          _aiEnabled = journal.aiResponseEnabled;
          _selectedDate = journal.createdAt;
          _selectedTags = journal.tags ?? [];

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
        case Error<Journal>():
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