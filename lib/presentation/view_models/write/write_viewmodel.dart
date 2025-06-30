import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/data/models/request/add_journal_request.dart';
import 'package:moodlog/domain/repositories/journal_repository.dart';

import '../../../core/constants/enum.dart';

class WriteViewModel extends ChangeNotifier {
  final JournalRepository _journalRepository;

  WriteViewModel({required JournalRepository journalRepository})
    : _journalRepository = journalRepository;

  final Logger _log = Logger('WriteViewModel');
  String? _content;
  MoodType _moodType = MoodType.neutral;
  List<String> _imageFileList = [];
  bool _isSubmitted = false;
  int? _submittedJournalId;
  bool _aiEnabled = true;
  DateTime _selectedDate = DateTime.now();

  final ImagePicker _picker = ImagePicker();

  String? get content => _content;

  bool get aiEnabled => _aiEnabled;

  MoodType get moodType => _moodType;

  DateTime get selectedDate => _selectedDate;

  List<String> get imageUri => _imageFileList;

  bool get isSubmitted => _isSubmitted;

  int? get submittedJournalId => _submittedJournalId;

  void updateAiEnabled(bool value) {
    _aiEnabled = value;
    notifyListeners();
  }

  void updateMoodType(MoodType value) {
    if (_moodType != value) {
      _moodType = value;
      notifyListeners();
    }
  }

  void updateContent(String? value) {
    if (_content != value) {
      _content = value;
      notifyListeners();
    }
  }

  void updateImageUri(XFile? imageFile) {}

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
    _moodType = MoodType.neutral;
    _imageFileList = [];
    _isSubmitted = false;
    _submittedJournalId = null;
    _aiEnabled = true;
    notifyListeners();
  }

  bool get isFormValid {
    return _content != null && _content!.trim().isNotEmpty;
  }

  Future<Result<void>> onSubmit() async {
    if (!isFormValid) {
      _log.warning('Content is required');
      return Result.error(Exception('Content is required'));
    }

    _isSubmitted = false;
    _submittedJournalId = null;

    final newJournal = AddJournalRequest(
      content: content,
      moodType: moodType,
      imageUri: imageUri,
      aiEnabled: aiEnabled,
      createdAt: selectedDate,
    );

    final result = await _journalRepository.addJournal(newJournal);

    switch (result) {
      case Ok<int>():
        _log.fine('Journal added successfully');
        _isSubmitted = true;
        _submittedJournalId = result.value;
        notifyListeners();
        return Result.ok(null);
      case Error<int>():
        _log.warning('Failed to add journal: ${result.error}');
        return Result.error(result.error);
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now(),
      initialDate: selectedDate,
    );

    if (pickedDate != selectedDate) {
      _selectedDate = pickedDate ?? DateTime.now();
      notifyListeners();
    }
  }
}
