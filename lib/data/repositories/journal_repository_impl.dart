import 'dart:async';

import 'package:logging/logging.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/data/data_source/local/journal_local_data_source.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';
import 'package:moodlog/domain/models/create_journal_request.dart';
import 'package:moodlog/domain/models/update_journal_request.dart';
import 'package:moodlog/domain/repositories/journal_repository.dart';

class JournalRepositoryImpl implements JournalRepository {
  final JournalLocalDataSource _journalLocalDataSource;
  final Logger _log = Logger('JournalRepositoryImpl');

  JournalRepositoryImpl({
    required JournalLocalDataSource localDataSource,
  }) : _journalLocalDataSource = localDataSource;

  final _journalStreamController = StreamController<List<Journal>>.broadcast();

  @override
  Stream<List<Journal>> get journalStream => _journalStreamController.stream;

  @override
  Future<Result<List<Journal>>> getJournals() async {
    try {
      final journals = await _journalLocalDataSource.getJournals();
      return Result.ok(journals);
    } catch (e, s) {
      _log.severe('Failed to get journals', e, s);
      return Result.error(Exception('Failed to get journals: $e'));
    }
  }

  @override
  Future<Result<List<Journal>>> getJournalsByMonth(DateTime date) async {
    final startOfMonth = DateTime(date.year, date.month, 1);
    final endOfMonth = DateTime(date.year, date.month + 1, 0);
    try {
      final journals = await _journalLocalDataSource.getJournalsByMonth(
        startOfMonth,
        endOfMonth,
      );
      return Result.ok(journals);
    } catch (e, s) {
      _log.severe('Failed to get journals by month', e, s);
      return Result.error(Exception('Failed to get journals: $e'));
    }
  }

  @override
  Future<Result<List<Journal>>> getJournalsByDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
    try {
      final journals = await _journalLocalDataSource.getJournalsByDate(
        startOfDay,
        endOfDay,
      );
      return Result.ok(journals);
    } catch (e, s) {
      _log.severe('Failed to get journals by date', e, s);
      return Result.error(Exception('Failed to get journals: $e'));
    }
  }

  @override
  Future<Result<Journal?>> getJournalById(int id) async {
    try {
      final journal = await _journalLocalDataSource.getJournalById(id);
      return Result.ok(journal);
    } catch (e, s) {
      _log.severe('Failed to get journal by id', e, s);
      return Result.error(Exception('Failed to get journal: $e'));
    }
  }

  @override
  Future<Result<int>> createJournal(CreateJournalRequest request) async {
    try {
      final journal = await _journalLocalDataSource.addJournal(request);
      notifyJournalUpdate();
      return Result.ok(journal?.id ?? 0);
    } catch (e, s) {
      _log.severe('Failed to create journal', e, s);
      return Result.error(Exception('Failed to add journal: $e'));
    }
  }

  @override
  Future<Result<int>> updateJournal(UpdateJournalRequest request) async {
    try {
      final updatedRows = await _journalLocalDataSource.updateJournal(request);
      if (updatedRows == 0) {
        return Result.error(Exception('Failed to update journal'));
      }
      notifyJournalUpdate();
      return Result.ok(updatedRows);
    } catch (e, s) {
      _log.severe('Failed to update journal', e, s);
      return Result.error(Exception('Failed to update journal: $e'));
    }
  }

  @override
  Future<Result<void>> deleteJournalById(int id) async {
    try {
      final deletedRows = await _journalLocalDataSource.deleteJournalById(id);
      if (deletedRows == 0) {
        return Result.error(Exception('Failed to delete journal'));
      }
      notifyJournalUpdate();
      return Result.ok(null);
    } catch (e, s) {
      _log.severe('Failed to delete journal', e, s);
      return Result.error(Exception('Failed to delete journal: $e'));
    }
  }

  @override
  Future<void> notifyJournalUpdate() async {
    if (!_journalStreamController.isClosed) {
      final result = await getJournals();
      if (result is Ok<List<Journal>>) {
        _journalStreamController.add(result.value);
      }
    }
  }

  void dispose() {
    _journalStreamController.close();
  }
}
