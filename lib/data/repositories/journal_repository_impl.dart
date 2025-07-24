import 'dart:async';

import 'package:drift/drift.dart';

import '../../core/utils/result.dart';
import '../../domain/entities/journal.dart';
import '../../domain/repositories/journal_repository.dart';
import '../data_source/database.dart';
import '../models/request/add_journal_request.dart';
import '../models/request/update_journal_request.dart';

class JournalRepositoryImpl implements JournalRepository {
  final MoodLogDatabase _db;

  JournalRepositoryImpl({required MoodLogDatabase db}) : _db = db;

  List<Journal>? _cachedJournals;
  final _journalStreamController = StreamController<List<Journal>>.broadcast();

  Stream<List<Journal>> get journalStream => _journalStreamController.stream;

  @override
  Future<Result<List<Journal>>> getAllJournals() async {
    if (_cachedJournals != null) {
      return Result.ok(_cachedJournals!);
    }
    final journals = await _db.select(_db.journals).get();
    _cachedJournals = journals;
    return Result.ok(journals);
  }

  @override
  Future<Result<List<Journal>>> getJournalsByMonth(DateTime date) async {
    final startOfMonth = DateTime(date.year, date.month, 1);
    final endOfMonth = DateTime(date.year, date.month + 1, 0);

    final journals =
        await (_db.select(_db.journals)..where(
              (t) => t.createdAt.isBetween(
                Variable(startOfMonth),
                Variable(endOfMonth),
              ),
            ))
            .get();

    return Result.ok(journals);
  }

  @override
  Future<Result<List<Journal>>> getJournalsByDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
    final journals =
        await (_db.select(_db.journals)..where(
              (t) => t.createdAt.isBetween(
                Variable(startOfDay),
                Variable(endOfDay),
              ),
            ))
            .get();
    return Result.ok(journals);
  }

  @override
  Future<Result<Journal>> getJournalById(int id) async {
    final journal = await (_db.select(
      _db.journals,
    )..where((t) => t.id.equals(id))).getSingleOrNull();

    if (journal == null) {
      return Result.error(Exception('Journal with ID $id not found.'));
    } else {
      return Result.ok(journal);
    }
  }

  @override
  Future<Result<Map<String, dynamic>>> addJournal(AddJournalRequest dto) async {
    final journal = await _db
        .into(_db.journals)
        .insertReturningOrNull(
          JournalsCompanion(
            content: Value(dto.content),
            moodType: Value(dto.moodType),
            imageUri: Value(dto.imageUri),
            createdAt: Value(dto.createdAt),
            aiResponseEnabled: Value(dto.aiResponseEnabled),
          ),
        );

    if (journal == null) {
      return Result.error(Exception('Failed to add journal'));
    }
    final response = {
      'id': journal.id,
      'aiResponseEnabled': journal.aiResponseEnabled,
    };
    _cachedJournals = null;
    return Result.ok(response);
  }

  @override
  Future<Result<int>> updateJournal(UpdateJournalRequest dto) async {
    final updatedRows =
        await (_db.update(
          _db.journals,
        )..where((t) => t.id.equals(dto.id))).write(
          JournalsCompanion(
            content: dto.content == null ? Value.absent() : Value(dto.content),
            imageUri: dto.imageUri == null
                ? Value.absent()
                : Value(dto.imageUri),
            aiResponse: dto.aiResponse == null
                ? Value.absent()
                : Value(dto.aiResponse),
          ),
        );
    if (updatedRows == 0) {
      return Result.error(Exception('Failed to update journal'));
    }
    _cachedJournals = null;
    return Result.ok(updatedRows);
  }

  @override
  Future<Result<void>> deleteJournalById(int id) async {
    final deletedRows = await (_db.delete(
      _db.journals,
    )..where((t) => t.id.equals(id))).go();

    if (deletedRows == 0) {
      return Result.error(Exception('Failed to delete journal'));
    }
    // 일기가 삭제되었으므로 캐시 무효화
    _cachedJournals = null;
    return Result.ok(null);
  }

  @override
  void clearCache() {
    _cachedJournals = null;
  }
}
