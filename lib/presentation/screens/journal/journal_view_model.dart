import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/mixins/async_state_mixin.dart';
import 'package:moodlog/core/mixins/debounce_mixin.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';
import 'package:moodlog/domain/use_cases/journal_use_case.dart';
import 'package:moodlog/presentation/providers/ai_generation_provider.dart';
import 'package:moodlog/presentation/providers/app_state_provider.dart';

class JournalViewModel extends ChangeNotifier
    with AsyncStateMixin, DebounceMixin {
  final JournalUseCase _journalUseCase;
  final AiGenerationProvider _aiGenerationProvider;
  final AppStateProvider _appStateProvider;
  final JournalSource source;
  final int id;

  JournalViewModel({
    required JournalUseCase journalUseCase,
    required AiGenerationProvider aiGenerationProvider,
    required AppStateProvider appStateProvider,
    required this.source,
    required this.id,
  }) : _journalUseCase = journalUseCase,
       _aiGenerationProvider = aiGenerationProvider,
       _appStateProvider = appStateProvider {
    _load();
    _aiGenerationProvider.addListener(_load);
  }

  Journal? _journal;
  SimpleTextAlign? _pendingAlign; // 로컬 상태

  bool get shouldReplaceOnPop => source == JournalSource.write;

  Journal? get journal => _journal;

  SimpleTextAlign get currentAlign =>
      _pendingAlign ?? _appStateProvider.appState.textAlign;

  Object? get aiGenerationError =>
      _aiGenerationProvider.errorGeneratingAiResponse;

  bool get isGeneratingAiResponse =>
      _aiGenerationProvider.isGeneratingAiResponse;

  void changeAlign() {
    _pendingAlign = currentAlign.next;
    notifyListeners();

    debounce('text_align', Duration(milliseconds: 300), () {
      final settings = _appStateProvider.appState.copyWith(
        textAlign: _pendingAlign!,
      );
      _appStateProvider.update(settings);
      _pendingAlign = null; // 저장 완료 후 로컬 상태 초기화
    });
  }

  Future<Result<void>> delete() async {
    setLoading();
    final result = await _journalUseCase.deleteJournalById(id);
    switch (result) {
      case Ok<void>():
        debugPrint('Deleted Journal ${journal?.id}');
        setSuccess();
        return Result.ok(null);
      case Error<void>():
        debugPrint('Failed to delete Journal ${result.error}');
        setError(result.error);
        return Result.error(result.error);
    }
  }

  Future<Result<void>> _load() async {
    setLoading();
    final journal = await _journalUseCase.getJournalById(id);
    switch (journal) {
      case Ok<Journal>():
        _journal = journal.value;
        debugPrint('Loaded Journal ${journal.value.id}');
        setSuccess();
        return Result.ok(null);
      case Error<Journal>():
        debugPrint(
          'Failed to load Journal. Error: ${journal.error}, Type: ${journal.error.runtimeType}',
        );
        setError(journal.error);
        return Result.error(journal.error);
    }
  }

  @override
  void dispose() {
    _aiGenerationProvider.removeListener(_load);
    disposeDebounce(); // DebounceMixin의 cleanup
    super.dispose();
  }
}
