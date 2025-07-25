import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../core/constants/enum.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/mixins/async_state_mixin.dart';
import '../../../core/mixins/step_mixin.dart';
import '../../../core/providers/app_state_provider.dart';
import '../../../core/utils/result.dart';
import '../../../data/models/request/add_journal_request.dart';
import '../../../data/models/request/update_journal_request.dart';
import '../../../domain/repositories/ai_generation_repository.dart';
import '../../../domain/repositories/app_state_repository.dart';
import '../../../domain/repositories/gemini_repository.dart';
import '../../../domain/repositories/journal_repository.dart';
import '../../../domain/use_cases/image/pick_image_usecase.dart';

class WriteViewModel extends ChangeNotifier with StepMixin, AsyncStateMixin {
  final JournalRepository _journalRepository;
  final GeminiRepository _geminiRepository;
  final AppStateProvider _appStateProvider;
  final AiGenerationRepository _aiGenerationRepository;
  final PickImageUseCase _pickImageUseCase;
  final SettingsRepository _settingsRepository;

  WriteViewModel({
    required JournalRepository journalRepository,
    required GeminiRepository geminiRepository,
    required AppStateProvider appStateProvider,
    required AiGenerationRepository aiGenerationRepository,
    required PickImageUseCase pickImageUseCase,
    required SettingsRepository settingsRepository,
    required int totalSteps,
  }) : _journalRepository = journalRepository,
       _geminiRepository = geminiRepository,
       _appStateProvider = appStateProvider,
       _aiGenerationRepository = aiGenerationRepository,
       _pickImageUseCase = pickImageUseCase,
       _settingsRepository = settingsRepository {
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

  void updateAiEnabled(bool value) {
    if (_canUseAiToday) {
      _aiEnabled = value;
      notifyListeners();
    }
  }

  void showAiLimitMessage(BuildContext context) {
    if (!_canUseAiToday) {
      final t = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.write_ai_limit_reached),
          behavior: SnackBarBehavior.floating,
        ),
      );
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
      content: content,
      moodType: selectedMood,
      imageUri: imageUri,
      aiResponseEnabled: aiEnabled,
      createdAt: selectedDate,
    );

    final result = await _journalRepository.addJournal(newJournal);

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

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime.now(),
      initialDate: _selectedDate,
    );

    if (pickedDate != null && context.mounted) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDate),
      );

      _log.info('Picked time: $pickedTime');

      if (pickedTime != null) {
        _selectedDate = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        notifyListeners();
      }
    }
  }

  Future<void> _checkAiUsageLimit() async {
    final lastUsageDate = await _settingsRepository.getLastAiUsageDate();
    final now = DateTime.now();

    _log.info(
      'Checking AI usage limit: lastUsageDate = $lastUsageDate, now = $now',
    );

    if (lastUsageDate == null) {
      _canUseAiToday = true;
    } else {
      final isSameDay =
          lastUsageDate.year == now.year &&
          lastUsageDate.month == now.month &&
          lastUsageDate.day == now.day;
      _canUseAiToday = !isSameDay;
    }

    _log.info('AI usage result: canUseAiToday = $_canUseAiToday');

    if (!_canUseAiToday) {
      _aiEnabled = false;
    }

    notifyListeners();
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
        await _journalRepository.updateJournal(newJournal);
        _aiGenerationRepository.setSuccessGeneratingAiResponse();
      case Failure<String>():
        _log.warning('Failed to add AI response: ${aiResponse.error}');
        _aiGenerationRepository.setErrorGeneratingAiResponse(aiResponse.error);
    }
  }
}
