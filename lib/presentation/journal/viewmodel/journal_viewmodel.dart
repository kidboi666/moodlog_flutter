import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

import '../../../core/constants/enum.dart';
import '../../../core/routing/routes.dart';
import '../../../core/utils/result.dart';
import '../../../domain/entities/journal.dart';
import '../../../domain/repositories/ai_generation_repository.dart';
import '../../../domain/repositories/journal_repository.dart';
import '../widgets/delete_confirm_dialog.dart';

class JournalViewModel extends ChangeNotifier {
  final JournalRepository _journalRepository;
  final AiGenerationRepository _aiGenerationRepository;
  final String source;
  final int id;

  JournalViewModel({
    required JournalRepository journalRepository,
    required AiGenerationRepository aiGenerationRepository,
    required this.source,
    required this.id,
  }) : _journalRepository = journalRepository,
       _aiGenerationRepository = aiGenerationRepository {
    _load();
    _aiGenerationRepository.addListener(_load);
  }

  final Logger _log = Logger('JournalViewModel');
  late Journal _journal;
  SimpleTextAlign _currentAlign = SimpleTextAlign.left;
  bool _isLoading = false;

  bool get shouldReplaceOnPop => source == 'write';

  Journal get journal => _journal;

  bool get isLoading => _isLoading;

  SimpleTextAlign get currentAlign => _currentAlign;

  bool get isGeneratingAiResponse =>
      _aiGenerationRepository.isGeneratingAiResponse;

  void handleBackNavigation(BuildContext context) {
    if (shouldReplaceOnPop) {
      context.replace(Routes.home);
    } else {
      context.pop();
    }
  }

  void changeAlign() {
    _currentAlign = _currentAlign.next;
    notifyListeners();
  }

  Future<void> handleDelete(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => DeleteConfirmDialog(viewModel: this, id: id),
    );
  }

  Future<Result<void>> delete() async {
    _isLoading = true;
    notifyListeners();

    final result = await _journalRepository.deleteJournalById(id);
    switch (result) {
      case Ok<void>():
        _log.fine('Deleted Journal', journal.id);
        _isLoading = false;
        notifyListeners();
        return Result.ok(null);
      case Error<void>():
        _log.warning('Failed to delete Journal', result.error);
        _isLoading = false;
        notifyListeners();
        return Result.error(result.error);
    }
  }

  Future<Result<void>> _load() async {
    _isLoading = true;
    notifyListeners();

    final journal = await _journalRepository.getJournalById(id);
    switch (journal) {
      case Ok<Journal>():
        _journal = journal.value;
        _isLoading = false;
        _log.fine('Loaded Journal', journal.value.id);
        notifyListeners();
        return Result.ok(null);
      case Error<Journal>():
        _log.warning('Failed to load Journal', journal.error);
        _isLoading = false;
        notifyListeners();
        return Result.error(journal.error);
    }
  }

  @override
  void dispose() {
    _aiGenerationRepository.removeListener(_load);
    super.dispose();
  }
}
