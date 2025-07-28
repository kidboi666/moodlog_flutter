import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/data/models/request/add_journal_request.dart';
import 'package:moodlog/data/models/request/update_journal_request.dart';

import '../../../core/constants/enum.dart';
import '../../../core/mixins/async_state_mixin.dart';
import '../../../core/mixins/step_mixin.dart';
import '../../../core/providers/app_state_provider.dart';
import '../../../core/utils/result.dart';
import '../../../domain/entities/location_info.dart';
import '../../../domain/repositories/ai_generation_repository.dart';
import '../../../domain/repositories/app_state_repository.dart';
import '../../../domain/repositories/gemini_repository.dart';
import '../../../domain/use_cases/ai/check_ai_usage_limit_use_case.dart';
import '../../../domain/use_cases/image/pick_image_usecase.dart';
import '../../../domain/use_cases/journal/add_journal_use_case.dart';
import '../../../domain/use_cases/journal/update_journal_use_case.dart';
import '../../../domain/use_cases/location/get_current_location_use_case.dart';

class WriteViewModel extends ChangeNotifier with StepMixin, AsyncStateMixin {
  final GeminiRepository _geminiRepository;
  final AppStateProvider _appStateProvider;
  final AiGenerationRepository _aiGenerationRepository;
  final PickImageUseCase _pickImageUseCase;
  final SettingsRepository _settingsRepository;
  final GetCurrentLocationUseCase _getCurrentLocationUseCase;
  final AddJournalUseCase _addJournalUseCase;
  final UpdateJournalUseCase _updateJournalUseCase;
  final CheckAiUsageLimitUseCase _checkAiUsageLimitUseCase;

  WriteViewModel({
    required GeminiRepository geminiRepository,
    required AppStateProvider appStateProvider,
    required AiGenerationRepository aiGenerationRepository,
    required PickImageUseCase pickImageUseCase,
    required SettingsRepository settingsRepository,
    required GetCurrentLocationUseCase getCurrentLocationUseCase,
    required AddJournalUseCase addJournalUseCase,
    required UpdateJournalUseCase updateJournalUseCase,
    required CheckAiUsageLimitUseCase checkAiUsageLimitUseCase,
    required int totalSteps,
  }) : _geminiRepository = geminiRepository,
       _appStateProvider = appStateProvider,
       _aiGenerationRepository = aiGenerationRepository,
       _pickImageUseCase = pickImageUseCase,
       _settingsRepository = settingsRepository,
       _getCurrentLocationUseCase = getCurrentLocationUseCase,
       _addJournalUseCase = addJournalUseCase,
       _updateJournalUseCase = updateJournalUseCase,
       _checkAiUsageLimitUseCase = checkAiUsageLimitUseCase {
    initStep(totalSteps);
    _checkAiUsageLimit();
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
  DateTime _selectedDate = DateTime.now();
  bool _hasVisitedContentPage = false;
  bool _canUseAiToday = true;
  LocationInfo? _locationInfo;

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
    _checkAiUsageLimit();
    clearError();
    notifyListeners();
  }

  bool get isFormValid {
    return _content != null && _content!.trim().isNotEmpty;
  }

  Future<Result<void>> submitJournal() async {
    if (!isFormValid) {
      _log.warning('Content is required');
      return Result.failure(Exception('Content is required'));
    }

    setLoading();
    _isSubmitted = false;
    _submittedJournalId = null;

    final newJournal = AddJournalRequest(
      content: _content,
      moodType: _selectedMood,
      imageUri: _imageFileList,
      aiResponseEnabled: _aiEnabled,
      createdAt: _selectedDate,
      latitude: _locationInfo?.latitude,
      longitude: _locationInfo?.longitude,
      address: _locationInfo?.address,
    );
    final result = await _addJournalUseCase.execute(newJournal);

    switch (result) {
      case Ok<Map<String, dynamic>>():
        _log.fine('Journal added successfully');
        _isSubmitted = true;
        _submittedJournalId = result.value['id'];
        final aiResponseEnabled = result.value['aiResponseEnabled'];
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
        final newJournal = UpdateJournalRequest(
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
    setLoading();
    final result = await _getCurrentLocationUseCase.execute();

    switch (result) {
      case Ok<LocationInfo>():
        _log.fine('Location retrieved successfully');
        _locationInfo = result.value;
        setSuccess();
      case Failure<LocationInfo>():
        _log.warning('Failed to get location: ${result.error}');
        setError(result.error);
    }
  }

  void clearLocation() {
    _locationInfo = null;
    notifyListeners();
  }
}
