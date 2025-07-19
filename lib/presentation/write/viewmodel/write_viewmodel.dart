import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../core/constants/enum.dart';
import '../../../core/mixins/async_state_mixin.dart';
import '../../../core/mixins/step_mixin.dart';
import '../../../core/providers/app_state_provider.dart';
import '../../../core/utils/result.dart';
import '../../../data/models/request/add_journal_request.dart';
import '../../../data/models/request/update_journal_request.dart';
import '../../../domain/repositories/ai_generation_repository.dart';
import '../../../domain/repositories/gemini_repository.dart';
import '../../../domain/repositories/journal_repository.dart';
import '../../../domain/use_cases/image/pick_image_use_case.dart';

class WriteViewModel extends ChangeNotifier with StepMixin, AsyncStateMixin {
  final JournalRepository _journalRepository;
  final GeminiRepository _geminiRepository;
  final AppStateProvider _appStateProvider;
  final AiGenerationRepository _aiGenerationRepository;
  final PickImageUseCase _pickImageUseCase;

  WriteViewModel({
    required JournalRepository journalRepository,
    required GeminiRepository geminiRepository,
    required AppStateProvider appStateProvider,
    required AiGenerationRepository aiGenerationRepository,
    required PickImageUseCase pickImageUseCase,
    required int totalSteps,
  }) : _journalRepository = journalRepository,
       _geminiRepository = geminiRepository,
       _appStateProvider = appStateProvider,
       _aiGenerationRepository = aiGenerationRepository,
       _pickImageUseCase = pickImageUseCase {
    initStep(totalSteps);
  }

  final Logger _log = Logger('WriteViewModel');
  String? _content;
  MoodType _selectedMood = MoodType.neutral;
  List<String> _imageFileList = [];
  bool _isSubmitted = false;
  int? _submittedJournalId;
  bool _aiEnabled = true;
  DateTime _selectedDate = DateTime.now();

  String? get content => _content;

  bool get aiEnabled => _aiEnabled;

  MoodType get selectedMood => _selectedMood;

  DateTime get selectedDate => _selectedDate;

  List<String> get imageUri => _imageFileList;

  bool get isSubmitted => _isSubmitted;

  int? get submittedJournalId => _submittedJournalId;

  void updateAiEnabled(bool value) {
    _aiEnabled = value;
    notifyListeners();
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
    notifyListeners();
  }

  bool get isFormValid {
    return _content != null && _content!.trim().isNotEmpty;
  }

  Future<Result<void>> submitJournal() async {
    if (!isFormValid) {
      _log.warning('Content is required');
      return Result.error(Exception('Content is required'));
    }

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
        notifyListeners();
        return Result.ok(null);
      case Error<Map<String, dynamic>>():
        _log.warning('Failed to add journal: ${result.error}');
        return Result.error(result.error);
    }
  }

  Future<void> pickImage() async {
    final result = await _pickImageUseCase.pickImage();
    switch (result) {
      case Ok<String?>():
        _log.fine('Image picked successfully');
        _imageFileList.add(result.value!);
        notifyListeners();
      case Error<String?>():
        _log.warning('Failed to pick image: ${result.error}');
        notifyListeners();
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

  void _generateAiResponse() async {
    _aiGenerationRepository.setGeneratingAiResponse();

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
      case Error<String>():
        _log.warning('Failed to add AI response: ${aiResponse.error}');
        _aiGenerationRepository.setErrorGeneratingAiResponse(aiResponse.error);
    }
  }
}
