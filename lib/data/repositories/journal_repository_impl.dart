import 'dart:async';

import 'package:drift/drift.dart';

import '../../core/utils/result.dart';
import '../../domain/dto/create_journal_request.dart';
import '../../domain/entities/journal.dart';
import '../../domain/entities/tag.dart';
import '../../domain/dto/update_journal_request.dart';
import '../../domain/repositories/journal_repository.dart';
import '../data_source/database.dart';
import '../models/request/add_journal_request.dart';

class JournalRepositoryImpl implements JournalRepository {
  final MoodLogDatabase _db;

  JournalRepositoryImpl({required MoodLogDatabase db}) : _db = db;

  List<Journal>? _cachedJournals;
  final _journalStreamController = StreamController<List<Journal>>.broadcast();

  @override
  Stream<List<Journal>> get journalStream => _journalStreamController.stream;

  @override
  Future<Result<List<Journal>>> getAllJournals() async {
    if (_cachedJournals != null) {
      return Result.ok(_cachedJournals!);
    }
    final journals = await _db.select(_db.journals).get();
    final journalsWithTags = await _attachTagsToJournals(journals);
    _cachedJournals = journalsWithTags;
    return Result.ok(journalsWithTags);
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

    final journalsWithTags = await _attachTagsToJournals(journals);
    return Result.ok(journalsWithTags);
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
    final journalsWithTags = await _attachTagsToJournals(journals);
    return Result.ok(journalsWithTags);
  }

  @override
  Future<Result<Journal>> getJournalById(int id) async {
    final journal = await (_db.select(
      _db.journals,
    )..where((t) => t.id.equals(id))).getSingleOrNull();

    if (journal == null) {
      return Result.failure(Exception('Journal with ID $id not found.'));
    } else {
      final journalsWithTags = await _attachTagsToJournals([journal]);
      return Result.ok(journalsWithTags.first);
    }
  }

  @override
  Future<Result<Map<String, dynamic>>> addJournal(CreateJournalRequest dto) async {
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
    final journal = await _db
        .into(_db.journals)
        .insertReturningOrNull(
          JournalsCompanion(
            content: Value(request.content),
            moodType: Value(request.moodType),
            imageUri: Value(request.imageUri),
            createdAt: Value(request.createdAt),
            aiResponseEnabled: Value(request.aiResponseEnabled),
            latitude: Value(request.latitude),
            longitude: Value(request.longitude),
            address: Value(request.address),
            temperature: Value(request.temperature),
            weatherIcon: Value(request.weatherIcon),
            weatherDescription: Value(request.weatherDescription),
          ),
        );

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
    final updatedRows =
        await (_db.update(
          _db.journals,
        )..where((t) => t.id.equals(request.id))).write(
          JournalsCompanion(
            content: request.content == null
                ? Value.absent()
                : Value(request.content),
            imageUri: request.imageUri == null
                ? Value.absent()
                : Value(request.imageUri),
            aiResponse: request.aiResponse == null
                ? Value.absent()
                : Value(request.aiResponse),
          ),
        );
    if (updatedRows == 0) {
      return Result.failure(Exception('Failed to update journal'));
    }
    _cachedJournals = null;
    _notifyJournalUpdate();
    return Result.ok(updatedRows);
  }

  @override
  Future<Result<void>> deleteJournalById(int id) async {
    final deletedRows = await (_db.delete(
      _db.journals,
    )..where((t) => t.id.equals(id))).go();

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

  Future<List<Journal>> _attachTagsToJournals(List<Journal> journals) async {
    if (journals.isEmpty) return journals;

    final journalIds = journals.map((j) => j.id).toList();

    final query = _db.select(_db.journalTags).join([
      leftOuterJoin(_db.tags, _db.tags.id.equalsExp(_db.journalTags.tagId)),
    ])..where(_db.journalTags.journalId.isIn(journalIds));

    final results = await query.get();

    final journalTagMap = <int, List<Tag>>{};

    for (final row in results) {
      final journalTag = row.readTable(_db.journalTags);
      final tag = row.readTableOrNull(_db.tags);

      if (tag != null) {
        journalTagMap.putIfAbsent(journalTag.journalId, () => []).add(tag);
      }
    }

    return journals.map((journal) {
      final tags = journalTagMap[journal.id] ?? [];
      return Journal(
        id: journal.id,
        content: journal.content,
        moodType: journal.moodType,
        imageUri: journal.imageUri,
        createdAt: journal.createdAt,
        aiResponseEnabled: journal.aiResponseEnabled,
        aiResponse: journal.aiResponse,
        latitude: journal.latitude,
        longitude: journal.longitude,
        address: journal.address,
        temperature: journal.temperature,
        weatherIcon: journal.weatherIcon,
        weatherDescription: journal.weatherDescription,
        tags: tags,
      );
    }).toList();
  }

  void dispose() {
    _journalStreamController.close();
  }
}
