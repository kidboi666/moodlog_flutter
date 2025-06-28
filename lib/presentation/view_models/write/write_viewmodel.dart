import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/data/models/request/add_journal_request.dart';
import 'package:moodlog/domain/repositories/journal_repository.dart';

class WriteViewModel extends ChangeNotifier {
  final JournalRepository _journalRepository;
  final Logger _log = Logger('WriteViewModel');

  String? _content;
  String _moodName = 'happy';
  List<String> _imageFileList = [];
  bool _isSubmitted = false;
  int? _submittedJournalId;
  bool _aiEnabled = true;

  WriteViewModel({required JournalRepository journalRepository})
    : _journalRepository = journalRepository;

  final ImagePicker _picker = ImagePicker();

  String? get content => _content;

  bool get aiEnabled => _aiEnabled;

  String get moodName => _moodName;

  List<String> get imageUri => _imageFileList;

  bool get isSubmitted => _isSubmitted;

  int? get submittedJournalId => _submittedJournalId;

  void updateAiEnabled(bool value) {
    _aiEnabled = value;
    notifyListeners();
  }

  void updateMoodName(String value) {
    if (_moodName != value) {
      _moodName = value;
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
    _moodName = 'happy';
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
      moodName: moodName,
      imageUri: imageUri,
      aiEnabled: aiEnabled,
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
}
