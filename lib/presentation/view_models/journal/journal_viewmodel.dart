import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

import '../../../core/constants/enum.dart';
import '../../../core/utils/result.dart';
import '../../../domain/entities/journal.dart';
import '../../../domain/repositories/journal_repository.dart';
import '../../../router/routes.dart';
import '../../views/journal/widgets/delete_confirm.dart';

class JournalViewModel extends ChangeNotifier {
  final JournalRepository _journalRepository;
  final String source;
  final int id;

  JournalViewModel({
    required JournalRepository journalRepository,
    required this.source,
    required this.id,
  }) : _journalRepository = journalRepository {
    _load();
  }

  final Logger _log = Logger('JournalViewModel');
  Journal? _journal;
  SimpleTextAlign _currentAlign = SimpleTextAlign.left;
  bool _isLoading = true;

  bool get shouldReplaceOnPop => source == 'write';

  Journal? get journal => _journal;

  bool get isLoading => _isLoading;

  SimpleTextAlign get currentAlign => _currentAlign;

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
      builder: (context) => DeleteConfirm(viewModel: this, id: id),
    );
  }

  Future<Result<void>> delete() async {
    _isLoading = true;
    notifyListeners();

    final result = await _journalRepository.deleteJournalById(id);
    switch (result) {
      case Ok<void>():
        _log.fine('Deleted Journal');
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
        _log.fine('Loaded Journal', journal.value.createdAt);
        notifyListeners();
        return Result.ok(null);
      case Error<Journal>():
        _log.warning('Failed to load Journal', journal.error);
        _isLoading = false;
        notifyListeners();
        return Result.error(journal.error);
    }
  }
}
