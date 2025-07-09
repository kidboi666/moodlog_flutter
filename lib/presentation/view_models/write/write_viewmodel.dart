import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/domain/repositories/ai_generation_repository.dart';
import 'package:moodlog/domain/repositories/app_state_repository.dart';

import '../../../core/constants/enum.dart';
import '../../../core/mixins/step_mixin.dart';
import '../../../core/utils/result.dart';
import '../../../data/models/request/add_journal_request.dart';
import '../../../data/models/request/update_journal_request.dart';
import '../../../domain/repositories/gemini_repository.dart';
import '../../../domain/repositories/journal_repository.dart';

class WriteViewModel extends ChangeNotifier with StepMixin {
  final JournalRepository _journalRepository;
  final GeminiRepository _geminiRepository;
  final AppStateRepository _appStateRepository;
  final AiGenerationRepository _aiGenerationRepository;

  WriteViewModel({
    required JournalRepository journalRepository,
    required GeminiRepository geminiRepository,
    required AppStateRepository appStateRepository,
    required AiGenerationRepository aiGenerationRepository,
    required int totalSteps,
  }) : _journalRepository = journalRepository,
       _geminiRepository = geminiRepository,
       _appStateRepository = appStateRepository,
       _aiGenerationRepository = aiGenerationRepository {
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
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();

  String? get content => _content;

  bool get isLoading => _isLoading;

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

  Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        _imageFileList.add(pickedFile.path);
        _log.fine('Image picked: ${pickedFile.name}');
        notifyListeners();
      }
    } catch (e) {
      _log.warning('Error picking image: $e');
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

  void _generateAiResponse() async {
    _aiGenerationRepository.setGeneratingState(true);

    final aiPersonality = _appStateRepository.appState.aiPersonality;
    await _geminiRepository.initialize(aiPersonality: aiPersonality);
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
        _aiGenerationRepository.setGeneratingState(false);
      case Error<String>():
        _log.warning('Failed to add AI response: ${aiResponse.error}');
        _aiGenerationRepository.setGeneratingState(false);
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime.now(),
      initialDate: _selectedDate,
    );

    if (pickedDate != null) {
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
}
