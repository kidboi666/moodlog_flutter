import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/core/mixins/async_state_mixin.dart';

import '../../../core/constants/enum.dart';
import '../../../core/providers/app_state_provider.dart';
import '../../../core/routing/routes.dart';
import '../../../core/utils/result.dart';
import '../../../domain/entities/journal.dart';
import '../../../domain/repositories/ai_generation_repository.dart';
import '../../../domain/repositories/journal_repository.dart';

class JournalViewModel extends ChangeNotifier with AsyncStateMixin {
  final JournalRepository _journalRepository;
  final AiGenerationRepository _aiGenerationRepository;
  final AppStateProvider _appStateProvider;
  final JournalSource source;
  final int id;

  JournalViewModel({
    required JournalRepository journalRepository,
    required AiGenerationRepository aiGenerationRepository,
    required AppStateProvider appStateProvider,
    required this.source,
    required this.id,
  }) : _journalRepository = journalRepository,
       _aiGenerationRepository = aiGenerationRepository,
       _appStateProvider = appStateProvider {
    _load();
    _aiGenerationRepository.addListener(_load);
  }

  final Logger _log = Logger('JournalViewModel');
  late Journal _journal;

  bool get shouldReplaceOnPop => source == JournalSource.write;

  Journal get journal => _journal;

  SimpleTextAlign get currentAlign => _appStateProvider.appState.textAlign;

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
    final nextAlign = currentAlign.next;
    _appStateProvider.updateTextAlign(nextAlign);
    notifyListeners();
  }

  Future<Result<void>> delete() async {
    setLoading();
    final result = await _journalRepository.deleteJournalById(id);
    switch (result) {
      case Ok<void>():
        _log.fine('Deleted Journal', journal.id);
        setSuccess();
        return Result.ok(null);
      case Failure<void>():
        _log.warning('Failed to delete Journal', result.error);
        setError(result.error);
        return Result.failure(result.error);
    }
  }

  Future<Result<void>> _load() async {
    setLoading();
    final journal = await _journalRepository.getJournalById(id);
    switch (journal) {
      case Ok<Journal>():
        _journal = journal.value;
        _log.fine('Loaded Journal', journal.value.id);
        setSuccess();
        return Result.ok(null);
      case Failure<Journal>():
        _log.warning('Failed to load Journal', journal.error);
        setError(journal.error);
        return Result.failure(journal.error);
    }
  }

  @override
  void dispose() {
    _aiGenerationRepository.removeListener(_load);
    super.dispose();
  }
}
