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

  List<Journal>? _cachedJournals;
  final _journalStreamController = StreamController<List<Journal>>.broadcast();

  @override
  Stream<List<Journal>> get journalStream => _journalStreamController.stream;

  @override
  Future<Result<List<Journal>>> getAllJournals() async {
    if (_cachedJournals != null) {
      return Result.ok(_cachedJournals!);
    }
    final journals = await _localDataSource.getAllJournals();
    _cachedJournals = journals;
    return Result.ok(journals);
  }

  @override
  Future<Result<List<Journal>>> getJournalsByMonth(DateTime date) async {
    final startOfMonth = DateTime(date.year, date.month, 1);
    final endOfMonth = DateTime(date.year, date.month + 1, 0);
    final journals = await _localDataSource.getJournalsByMonth(
      startOfMonth,
      endOfMonth,
    );
    return Result.ok(journals);
  }

  @override
  Future<Result<List<Journal>>> getJournalsByDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
    final journals = await _localDataSource.getJournalsByDate(
      startOfDay,
      endOfDay,
    );
    return Result.ok(journals);
  }

  @override
  Future<Result<Journal>> getJournalById(int id) async {
    final journal = await _localDataSource.getJournalById(id);

    if (journal == null) {
      return Result.failure(Exception('Journal with ID $id not found.'));
    } else {
      return Result.ok(journal);
    }
  }

  @override
  Future<Result<Map<String, dynamic>>> addJournal(
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
      weatherIcon: dto.weatherIcon,
      weatherDescription: dto.weatherDescription,
    );
    final journal = await _localDataSource.addJournal(request);

    if (journal == null) {
      return Result.failure(Exception('Failed to add journal'));
    }
    final response = {
      'id': journal.id,
      'aiResponseEnabled': journal.aiResponseEnabled,
    };
    _cachedJournals = null;
    _notifyJournalUpdate();
    return Result.ok(response);
  }

  @override
  Future<Result<int>> updateJournal(UpdateJournalRequest dto) async {
    final request = UpdateJournalRequest(
      id: dto.id,
      content: dto.content,
      imageUri: dto.imageUri,
      aiResponse: dto.aiResponse,
      latitude: dto.latitude,
      longitude: dto.longitude,
      address: dto.address,
    );
    final updatedRows = await _localDataSource.updateJournal(request);
    if (updatedRows == 0) {
      return Result.failure(Exception('Failed to update journal'));
    }
    _cachedJournals = null;
    _notifyJournalUpdate();
    return Result.ok(updatedRows);
  }

  @override
  Future<Result<void>> deleteJournalById(int id) async {
    final deletedRows = await _localDataSource.deleteJournalById(id);
    if (deletedRows == 0) {
      return Result.failure(Exception('Failed to delete journal'));
    }

    _cachedJournals = null;
    _notifyJournalUpdate();
    return Result.ok(null);
  }

  @override
  void clearCache() {
    _cachedJournals = null;
  }

  Future<void> _notifyJournalUpdate() async {
    if (!_journalStreamController.isClosed) {
      final result = await getAllJournals();
      if (result is Ok<List<Journal>>) {
        _journalStreamController.add(result.value);
      }
    }
  }

  void dispose() {
    _journalStreamController.close();
  }
}
