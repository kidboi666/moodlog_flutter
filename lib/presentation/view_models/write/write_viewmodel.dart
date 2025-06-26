import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/data/models/request/add_journal_request.dart';
import 'package:moodlog/domain/repositories/journal_repository.dart';

class WriteViewModel extends ChangeNotifier {
  final JournalRepository _journalRepository;

  WriteViewModel({required JournalRepository journalRepository})
    : _journalRepository = journalRepository;

  final Logger _log = Logger('WriteViewModel');
  String? _content;
  String _moodName = '';
  String? _imageUri;
  bool _isSubmitted = false;
  int? _submittedJournalId;

  String? get content => _content;

  String get moodName => _moodName;

  String? get imageUri => _imageUri;

  bool get isSubmitted => _isSubmitted;

  int? get submittedJournalId => _submittedJournalId;

  void onContentChange(String value) {
    _content = value;
    notifyListeners();
  }

  void onMoodNameChange(String value) {
    _moodName = value;
    notifyListeners();
  }

  void onImageUriChange(String value) {
    _imageUri = value;
    notifyListeners();
  }

  Future<Result<void>> onSubmit() async {
    _isSubmitted = false;
    _submittedJournalId = null;
    final newJournal = AddJournalRequest(
      content: content,
      moodName: moodName,
      imageUri: imageUri,
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
        _log.warning('Failed to add journal');
        return Result.error(result.error);
    }
  }
}
