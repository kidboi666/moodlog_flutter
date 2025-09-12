import 'dart:async';

import '../../core/utils/result.dart';
import '../../domain/dto/create_journal_request.dart';
import '../../domain/dto/update_journal_request.dart';
import '../../domain/entities/journal/journal.dart';
import '../../domain/repositories/journal_repository.dart';
import '../data_source/local/journal_local_data_source.dart';
import '../models/request/add_journal_request.dart';

class JournalRepositoryImpl implements JournalRepository {
  final JournalLocalDataSource _localDataSource;

  JournalRepositoryImpl({required JournalLocalDataSource localDataSource})
    : _localDataSource = localDataSource;

  final _journalStreamController = StreamController<List<Journal>>.broadcast();

  @override
  Stream<List<Journal>> get journalStream => _journalStreamController.stream;

  @override
  Future<Result<List<Journal>>> getJournals() async {
    try {
      final journals = await _localDataSource.getJournals();
      return Result.ok(journals);
    } catch (e) {
      return Result.error(Exception('Failed to get journals: $e'));
    }
  }

  @override
  Future<Result<List<Journal>>> getJournalsByMonth(DateTime date) async {
    final startOfMonth = DateTime(date.year, date.month, 1);
    final endOfMonth = DateTime(date.year, date.month + 1, 0);
    try {
      final journals = await _localDataSource.getJournalsByMonth(
        startOfMonth,
        endOfMonth,
      );
      return Result.ok(journals);
    } catch (e) {
      return Result.error(Exception('Failed to get journals: $e'));
    }
  }

  @override
  Future<Result<List<Journal>>> getJournalsByDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
    try {
      final journals = await _localDataSource.getJournalsByDate(
        startOfDay,
        endOfDay,
      );
      return Result.ok(journals);
    } catch (e) {
      return Result.error(Exception('Failed to get journals: $e'));
    }
  }

  @override
  Future<Result<Journal>> getJournalById(int id) async {
    try {
      final journal = await _localDataSource.getJournalById(id);
      if (journal == null) {
        return Result.error(Exception('Journal not found'));
      }
      return Result.ok(journal);
    } catch (e) {
      return Result.error(Exception('Failed to get journal: $e'));
    }
  }

  @override
  Future<Result<Map<String, dynamic>>> createJournal(
    CreateJournalRequest dto,
  ) async {
    final request = AddJournalRequest(
      content: dto.content,
      moodType: dto.moodType,
      imageUri: dto.imageUri,
      aiResponseEnabled: dto.aiResponseEnabled,
      aiResponse: dto.aiResponse,
      createdAt: dto.createdAt,
      latitude: dto.latitude,
      longitude: dto.longitude,
      address: dto.address,
      temperature: dto.temperature,
      tagNames: dto.tagNames,
      weatherIcon: dto.weatherIcon,
      weatherDescription: dto.weatherDescription,
    );
    try {
      final journal = await _localDataSource.addJournal(request);
      final response = {
        'id': journal?.id,
        'aiResponseEnabled': journal?.aiResponseEnabled,
      };
      _notifyJournalUpdate();
      return Result.ok(response);
    } catch (e) {
      return Result.error(Exception('Failed to add journal: $e'));
    }
  }

  @override
  Future<Result<int>> updateJournal(UpdateJournalRequest dto) async {
    try {
      final updatedRows = await _localDataSource.updateJournal(dto);
      if (updatedRows == 0) {
        return Result.error(Exception('Failed to update journal'));
      }
      _notifyJournalUpdate();
      return Result.ok(updatedRows);
    } catch (e) {
      return Result.error(Exception('Failed to update journal: $e'));
    }
  }

  @override
  Future<Result<void>> deleteJournalById(int id) async {
    try {
      final deletedRows = await _localDataSource.deleteJournalById(id);
      if (deletedRows == 0) {
        return Result.error(Exception('Failed to delete journal'));
      }
      _notifyJournalUpdate();
      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Failed to delete journal: $e'));
    }
  }

  Future<void> _notifyJournalUpdate() async {
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
