import 'package:drift/drift.dart';

import '../../../domain/dto/update_journal_request.dart';
import '../../../domain/entities/journal/journal.dart';
import '../../../domain/entities/journal/tag.dart';
import '../../models/request/add_journal_request.dart';
import 'database/database.dart';

class JournalLocalDataSource {
  final MoodLogDatabase _db;

  JournalLocalDataSource({MoodLogDatabase? db}) : _db = db ?? MoodLogDatabase();

  Future<List<Journal>> getAllJournals() async {
    final journals = await _db.select(_db.journals).get();
    return await _attachTagsToJournals(journals);
  }

  Future<Journal?> getJournalById(int journalId) async {
    final journal = await (_db.select(
      _db.journals,
    )..where((t) => t.id.equals(journalId))).getSingleOrNull();

    if (journal == null) return null;

    final tags =
        await (_db.select(_db.tags).join([
              innerJoin(
                _db.journalTags,
                _db.journalTags.tagId.equalsExp(_db.tags.id),
              ),
            ])..where(_db.journalTags.journalId.equals(journalId)))
            .map((row) => row.readTable(_db.tags))
            .get();

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
  }

  Future<List<Journal>> getJournalsByMonth(
    DateTime startOfMonth,
    DateTime endOfMonth,
  ) async {
    final journals =
        await (_db.select(_db.journals)..where(
              (t) => t.createdAt.isBetween(
                Variable(startOfMonth),
                Variable(endOfMonth),
              ),
            ))
            .get();
    return await _attachTagsToJournals(journals);
  }

  Future<List<Journal>> getJournalsByDate(
    DateTime startOfDay,
    DateTime endOfDay,
  ) async {
    final journals =
        await (_db.select(_db.journals)..where(
              (t) => t.createdAt.isBetween(
                Variable(startOfDay),
                Variable(endOfDay),
              ),
            ))
            .get();
    return await _attachTagsToJournals(journals);
  }

  Future<Journal?> addJournal(AddJournalRequest request) async {
    return await _db
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
  }

  Future<int> updateJournal(UpdateJournalRequest request) async {
    return await (_db.update(
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
  }

  Future<int> deleteJournalById(int id) async {
    return await (_db.delete(_db.journals)..where((t) => t.id.equals(id))).go();
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
}
