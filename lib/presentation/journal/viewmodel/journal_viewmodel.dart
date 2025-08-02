import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../common/constants/enum.dart';
import '../../../common/mixins/async_state_mixin.dart';
import '../../../common/mixins/debounce_mixin.dart';
import '../../../common/providers/app_state_provider.dart';
import '../../../common/utils/result.dart';
import '../../../domain/entities/journal.dart';
import '../../../domain/repositories/ai_generation_repository.dart';
import '../../../domain/repositories/journal_repository.dart';

class JournalViewModel extends ChangeNotifier
    with AsyncStateMixin, DebounceMixin {
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
  SimpleTextAlign? _pendingAlign; // 로컬 상태

  bool get shouldReplaceOnPop => source == JournalSource.write;

  Journal get journal => _journal;

  SimpleTextAlign get currentAlign =>
      _pendingAlign ?? _appStateProvider.appState.textAlign;

  bool get isGeneratingAiResponse =>
      _aiGenerationRepository.isGeneratingAiResponse;

  void changeAlign() {
    _pendingAlign = currentAlign.next;
    notifyListeners();

    debounce('text_align', Duration(milliseconds: 300), () {
      _appStateProvider.updateTextAlign(_pendingAlign!);
      _pendingAlign = null; // 저장 완료 후 로컬 상태 초기화
    });
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
    disposeDebounce(); // DebounceMixin의 cleanup
    super.dispose();
  }
}
