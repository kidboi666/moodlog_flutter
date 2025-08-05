import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../common/constants/enum.dart';
import '../../../common/mixins/async_state_mixin.dart';
import '../../../common/mixins/step_mixin.dart';
import '../../../common/providers/app_state_provider.dart';
import '../../../common/utils/result.dart';
import '../../../data/repositories/analytics_repository_impl.dart';
import '../../../domain/entities/create_journal_dto.dart';
import '../../../domain/entities/location_info.dart';
import '../../../domain/entities/tag.dart';
import '../../../domain/entities/update_journal_dto.dart';
import '../../../domain/entities/weather_info.dart';
import '../../../domain/repositories/ai_generation_repository.dart';
import '../../../domain/repositories/app_state_repository.dart';
import '../../../domain/repositories/gemini_repository.dart';
import '../../../domain/use_cases/ai/check_ai_usage_limit_use_case.dart';
import '../../../domain/use_cases/image/pick_image_usecase.dart';
import '../../../domain/use_cases/journal/add_journal_use_case.dart';
import '../../../domain/use_cases/journal/update_journal_use_case.dart';
import '../../../domain/use_cases/location/get_current_location_use_case.dart';
import '../../../domain/use_cases/tag/add_tag_use_case.dart';
import '../../../domain/use_cases/tag/get_all_tags_use_case.dart';
import '../../../domain/use_cases/tag/update_journal_tags_use_case.dart';
import '../../../domain/use_cases/weather/get_current_weather_use_case.dart';
import '../../../domain/entities/journal.dart';
import '../../../domain/repositories/journal_repository.dart';

class WriteViewModel extends ChangeNotifier with StepMixin, AsyncStateMixin {
  final GeminiRepository _geminiRepository;
  final AppStateProvider _appStateProvider;
  final AiGenerationRepository _aiGenerationRepository;
  final PickImageUseCase _pickImageUseCase;
  final SettingsRepository _settingsRepository;
  final GetCurrentLocationUseCase _getCurrentLocationUseCase;
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;
  final AddJournalUseCase _addJournalUseCase;
  final UpdateJournalUseCase _updateJournalUseCase;
  final CheckAiUsageLimitUseCase _checkAiUsageLimitUseCase;
  final AddTagUseCase _addTagUseCase;
  final GetAllTagsUseCase _getAllTagsUseCase;
  final UpdateJournalTagsUseCase _updateJournalTagsUseCase;
  final JournalRepository _journalRepository;

  WriteViewModel({
    required GeminiRepository geminiRepository,
    required AppStateProvider appStateProvider,
    required AiGenerationRepository aiGenerationRepository,
    required PickImageUseCase pickImageUseCase,
    required SettingsRepository settingsRepository,
    required GetCurrentLocationUseCase getCurrentLocationUseCase,
    required GetCurrentWeatherUseCase getCurrentWeatherUseCase,
    required AddJournalUseCase addJournalUseCase,
    required UpdateJournalUseCase updateJournalUseCase,
    required CheckAiUsageLimitUseCase checkAiUsageLimitUseCase,
    required AddTagUseCase addTagUseCase,
    required GetAllTagsUseCase getAllTagsUseCase,
    required UpdateJournalTagsUseCase updateJournalTagsUseCase,
    required JournalRepository journalRepository,
    required int totalSteps,
    required DateTime selectedDate,
    int? editJournalId,
  }) : _geminiRepository = geminiRepository,
       _appStateProvider = appStateProvider,
       _aiGenerationRepository = aiGenerationRepository,
       _pickImageUseCase = pickImageUseCase,
       _settingsRepository = settingsRepository,
       _getCurrentLocationUseCase = getCurrentLocationUseCase,
       _getCurrentWeatherUseCase = getCurrentWeatherUseCase,
       _addJournalUseCase = addJournalUseCase,
       _updateJournalUseCase = updateJournalUseCase,
       _checkAiUsageLimitUseCase = checkAiUsageLimitUseCase,
       _addTagUseCase = addTagUseCase,
       _getAllTagsUseCase = getAllTagsUseCase,
       _updateJournalTagsUseCase = updateJournalTagsUseCase,
       _journalRepository = journalRepository {
    initStep(totalSteps);
    _checkAiUsageLimit();
    _loadCurrentLocationOnInit();
    _loadCurrentWeatherOnInit();
    _loadAllTags();
    _selectedDate = selectedDate;
    if (editJournalId != null) {
      _editJournalId = editJournalId;
      _isEditMode = true;
      _loadJournalForEdit(editJournalId);
    }
  }

  @override
  void setStep(int step) {
    super.setStep(step);
    if (step > 0) {
      _hasVisitedContentPage = true;
    }
  }

  final Logger _log = Logger('WriteViewModel');
  String? _content;
  MoodType _selectedMood = MoodType.neutral;
  List<String> _imageFileList = [];
  bool _isSubmitted = false;
  int? _submittedJournalId;
  bool _aiEnabled = true;
  late DateTime _selectedDate;
  bool _hasVisitedContentPage = false;
  bool _canUseAiToday = true;
  LocationInfo? _locationInfo;
  bool _isLoadingLocation = false;
  WeatherInfo? _weatherInfo;
  bool _isLoadingWeather = false;
  List<Tag> _availableTags = [];
  List<Tag> _selectedTags = [];
  bool _isEditMode = false;
  int? _editJournalId;

  String? get content => _content;

  bool get aiEnabled => _aiEnabled;

  MoodType get selectedMood => _selectedMood;

  DateTime get selectedDate => _selectedDate;

  List<String> get imageUri => _imageFileList;

  bool get isSubmitted => _isSubmitted;

  int? get submittedJournalId => _submittedJournalId;

  bool get shouldAutoNavigateOnMoodSelect => !_hasVisitedContentPage;

  bool get canUseAiToday => _canUseAiToday;

  bool get isAiAvailable => _aiEnabled && _canUseAiToday;

  LocationInfo? get locationInfo => _locationInfo;

  bool get isLoadingLocation => _isLoadingLocation;

  WeatherInfo? get weatherInfo => _weatherInfo;

  bool get isLoadingWeather => _isLoadingWeather;

  List<Tag> get availableTags => _availableTags;

  bool get isEditMode => _isEditMode;

  List<Tag> get selectedTags => _selectedTags;

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

  void resetForm() {
    _content = null;
    _selectedMood = MoodType.neutral;
    _imageFileList = [];
    _isSubmitted = false;
    _submittedJournalId = null;
    _aiEnabled = true;
    _hasVisitedContentPage = false;
    _locationInfo = null;
    _isLoadingLocation = false;
    _weatherInfo = null;
    _isLoadingWeather = false;
    _selectedTags.clear();
    _checkAiUsageLimit();
    clearError();
    notifyListeners();
  }

  bool get isFormValid {
    return _content != null &&
        _content!.trim().isNotEmpty &&
        !_isLoadingLocation;
  }

  Future<void> _loadJournalForEdit(int journalId) async {
    try {
      _log.info('Loading journal for edit: $journalId');
      final result = await _journalRepository.getJournalById(journalId);
      switch (result) {
        case Ok<Journal>():
          final journal = result.value;
          _log.info('Journal loaded successfully: ${journal.content}');
          _content = journal.content;
          _selectedMood = journal.moodType;
          _imageFileList = journal.imageUri ?? [];
          _aiEnabled = journal.aiResponseEnabled;
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
          
          _selectedTags = journal.tags ?? [];
          notifyListeners();
        case Failure<Journal>():
          _log.warning('Failed to load journal for edit: ${result.error}');
      }
    } catch (e) {
      _log.warning('Error loading journal for edit: $e');
    }
  }

  Future<Result<void>> submitJournal() async {
    if (!isFormValid) {
      _log.warning('Content is required');
      return Result.failure(Exception('Content is required'));
    }

    setLoading();
    _isSubmitted = false;
    _submittedJournalId = null;

    if (_isEditMode && _editJournalId != null) {
      return _updateExistingJournal();
    } else {
      return _createNewJournal();
    }
  }

  Future<Result<void>> _createNewJournal() async {
    final newJournal = CreateJournalDto(
      content: _content,
      moodType: _selectedMood,
      imageUri: _imageFileList,
      aiResponseEnabled: _aiEnabled,
      createdAt: _selectedDate,
      latitude: _locationInfo?.latitude,
      longitude: _locationInfo?.longitude,
      address: _locationInfo?.address,
      temperature: _weatherInfo?.temperature,
      weatherIcon: _weatherInfo?.icon,
      weatherDescription: _weatherInfo?.description,
    );
    final result = await _addJournalUseCase.execute(newJournal);

    switch (result) {
      case Ok<Map<String, dynamic>>():
        _log.fine('Journal added successfully');
        _isSubmitted = true;
        _submittedJournalId = result.value['id'];
        final aiResponseEnabled = result.value['aiResponseEnabled'];

        if (_selectedTags.isNotEmpty) {
          await _updateJournalTagsUseCase.call(
            result.value['id'],
            _selectedTags.map((tag) => tag.id).toList(),
          );
        }

        AnalyticsRepositoryImpl().logMoodEntry(
          moodType: _selectedMood.name,
          entryType: 'manual',
          hasImage: _imageFileList.isNotEmpty,
          hasTag: _selectedTags.isNotEmpty,
        );

        if (aiResponseEnabled == true) {
          _generateAiResponse();
        }
        setSuccess();
        return Result.ok(null);
      case Failure<Map<String, dynamic>>():
        _log.warning('Failed to add journal: ${result.error}');
        setError(result.error);
        return Result.failure(result.error);
    }
  }

  Future<Result<void>> _updateExistingJournal() async {
    final updateJournal = UpdateJournalDto(
      id: _editJournalId!,
      content: _content,
      imageUri: _imageFileList,
      latitude: _locationInfo?.latitude,
      longitude: _locationInfo?.longitude,
      address: _locationInfo?.address,
    );
    
    final result = await _updateJournalUseCase.execute(updateJournal);
    
    switch (result) {
      case Ok<int>():
        _log.fine('Journal updated successfully');
        _isSubmitted = true;
        _submittedJournalId = _editJournalId;
        
        if (_selectedTags.isNotEmpty) {
          await _updateJournalTagsUseCase.call(
            _editJournalId!,
            _selectedTags.map((tag) => tag.id).toList(),
          );
        }
        
        AnalyticsRepositoryImpl().logMoodEntry(
          moodType: _selectedMood.name,
          entryType: 'edit',
          hasImage: _imageFileList.isNotEmpty,
          hasTag: _selectedTags.isNotEmpty,
        );
        
        setSuccess();
        return Result.ok(null);
      case Failure<int>():
        _log.warning('Failed to update journal: ${result.error}');
        setError(result.error);
        return Result.failure(result.error);
    }
  }

  Future<void> pickImage() async {
    setLoading();
    final result = await _pickImageUseCase.pickImage();
    switch (result) {
      case Ok<String?>():
        _log.fine('Image picked successfully');
        _imageFileList.add(result.value!);
        setSuccess();
      case Failure<String?>():
        _log.warning('Failed to pick image: ${result.error}');
        setError(result.error);
    }
  }

  void updateSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  Future<void> _checkAiUsageLimit() async {
    final result = await _checkAiUsageLimitUseCase.execute();

    switch (result) {
      case Ok<bool>():
        _canUseAiToday = result.value;
        _log.info('AI usage check result: canUseAiToday = $_canUseAiToday');

        if (!_canUseAiToday) {
          _aiEnabled = false;
        }

        notifyListeners();
      case Failure<bool>():
        _log.warning('Failed to check AI usage limit: ${result.error}');
        _canUseAiToday = false;
        _aiEnabled = false;
        notifyListeners();
    }
  }

  void _generateAiResponse() async {
    _aiGenerationRepository.setGeneratingAiResponse();

    // Record AI usage
    await _settingsRepository.updateLastAiUsageDate(DateTime.now());
    _canUseAiToday = false;
    notifyListeners();

    final aiPersonality = _appStateProvider.appState.aiPersonality;
    await _geminiRepository.init(aiPersonality);
    final aiResponse = await _geminiRepository.generateResponse(
      prompt: content!,
      moodType: selectedMood,
    );

    switch (aiResponse) {
      case Ok<String>():
        _log.fine('AI response generated successfully');
        final newJournal = UpdateJournalDto(
          id: _submittedJournalId!,
          aiResponse: aiResponse.value,
        );
        await _updateJournalUseCase.execute(newJournal);
        _aiGenerationRepository.setSuccessGeneratingAiResponse();
      case Failure<String>():
        _log.warning('Failed to add AI response: ${aiResponse.error}');
        _aiGenerationRepository.setErrorGeneratingAiResponse(aiResponse.error);
    }
  }

  Future<void> getCurrentLocation() async {
    _isLoadingLocation = true;
    notifyListeners();

    final result = await _getCurrentLocationUseCase.execute();

    switch (result) {
      case Ok<LocationInfo>():
        _log.fine('Location retrieved successfully');
        _locationInfo = result.value;
      case Failure<LocationInfo>():
        _log.warning('Failed to get location: ${result.error}');
        setError(result.error);
    }

    _isLoadingLocation = false;
    notifyListeners();
  }

  Future<void> _loadCurrentLocationOnInit() async {
    _isLoadingLocation = true;
    notifyListeners();

    final result = await _getCurrentLocationUseCase.execute();

    switch (result) {
      case Ok<LocationInfo>():
        _log.fine('Location retrieved successfully on init');
        _locationInfo = result.value;
        // 위치 정보가 로드되면 자동으로 날씨 정보도 로드
        _loadWeatherAfterLocation();
      case Failure<LocationInfo>():
        _log.info('Failed to get location on init: ${result.error}');
    }

    _isLoadingLocation = false;
    notifyListeners();
  }

  Future<void> _loadWeatherAfterLocation() async {
    // getCurrentWeather 메서드가 기본 위치 처리를 포함하므로 직접 호출
    await getCurrentWeather();
  }

  void clearLocation() {
    _locationInfo = null;
    notifyListeners();
  }

  Future<void> getCurrentWeather() async {
    double latitude = 37.5665; // 서울 기본 위치
    double longitude = 126.9780;

    // 위치 정보가 있으면 사용, 없으면 서울 기본 위치 사용
    if (_locationInfo != null) {
      latitude = _locationInfo!.latitude;
      longitude = _locationInfo!.longitude;
      _log.info('Using actual location: $latitude, $longitude');
    } else {
      _log.info('Using default location (Seoul): $latitude, $longitude');
    }

    _isLoadingWeather = true;
    notifyListeners();

    final result = await _getCurrentWeatherUseCase.execute(
      latitude: latitude,
      longitude: longitude,
    );

    switch (result) {
      case Ok<WeatherInfo>():
        _log.fine('Weather retrieved successfully');
        _weatherInfo = result.value;
      case Failure<WeatherInfo>():
        _log.warning('Failed to get weather: ${result.error}');
        setError(result.error);
    }

    _isLoadingWeather = false;
    notifyListeners();
  }

  Future<void> _loadCurrentWeatherOnInit() async {
    // 위치 정보 로드를 잠시 기다렸다가 날씨 정보 로드 (기본 위치 사용)
    await Future.delayed(Duration(milliseconds: 500));
    await getCurrentWeather();
  }

  void clearWeather() {
    _weatherInfo = null;
    notifyListeners();
    getCurrentWeather();
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

  void addExistingTag(Tag tag) {
    if (!_selectedTags.contains(tag)) {
      _selectedTags.add(tag);
      notifyListeners();
    }
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

    final result = await _addTagUseCase.call(trimmedName, null);
    switch (result) {
      case Ok<int>():
        final newTag = Tag(
          id: result.value,
          name: trimmedName,
          createdAt: DateTime.now(),
        );
        _availableTags.add(newTag);
        addExistingTag(newTag);
      case Failure<int>():
        _log.warning('Failed to add tag: ${result.error}');
        setError(result.error);
    }
  }
}
