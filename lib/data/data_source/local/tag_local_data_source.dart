import 'package:drift/drift.dart';

import '../../../domain/entities/journal/tag.dart';
import 'database/database.dart';

class TagLocalDataSource {
  final MoodLogDatabase _db;

  TagLocalDataSource({MoodLogDatabase? db}) : _db = db ?? MoodLogDatabase();

  Future<List<Tag>> getAllTags() async {
    return await (_db.select(
      _db.tags,
    )..orderBy([(t) => OrderingTerm.asc(t.createdAt)])).get();
  }

  Future<Tag?> getTagById(int id) async {
    return await (_db.select(
      _db.tags,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<List<Tag>> getTagsByJournalId(int journalId) async {
    return await (_db.select(_db.tags).join([
            innerJoin(
              _db.journalTags,
              _db.journalTags.tagId.equalsExp(_db.tags.id),
            ),
          ])
          ..where(_db.journalTags.journalId.equals(journalId))
          ..orderBy([OrderingTerm.asc(_db.tags.name)]))
        .map((row) => row.readTable(_db.tags))
        .get();
  }

  Future<int> addTag(String name, String? color) async {
    return await (_db
        .into(_db.tags)
        .insert(
          TagsCompanion(
            name: Value(name),
            color: Value(color),
            createdAt: Value(DateTime.now()),
          ),
        ));
  }

  Future<int> updateTag(int id, String name, String? color) async {
    return await (_db.update(_db.tags)..where((t) => t.id.equals(id))).write(
      TagsCompanion(name: Value(name), color: Value(color)),
    );
  }

  Future<int> deleteTag(int id) async {
    return await (_db.delete(_db.tags)..where((t) => t.id.equals(id))).go();
  }

  Future<void> addTagToJournal(int journalId, int tagId) async {
    await (_db
        .into(_db.journalTags)
        .insert(
          JournalTagsCompanion(
            journalId: Value(journalId),
            tagId: Value(tagId),
            createdAt: Value(DateTime.now()),
          ),
        ));
  }

  Future<int> removeTagFromJournal(int journalId, int tagId) async {
    return await (_db.delete(_db.journalTags)
          ..where((t) => t.journalId.equals(journalId) & t.tagId.equals(tagId)))
        .go();
  }

  Future<void> updateJournalTags(int journalId, List<int> tagIds) async {
    await _db.transaction(() async {
      await (_db.delete(
        _db.journalTags,
      )..where((v) => v.journalId.equals(journalId))).go();

      for (final tagId in tagIds) {
        await _db
            .into(_db.journalTags)
            .insert(
              JournalTagsCompanion(
                journalId: Value(journalId),
                tagId: Value(tagId),
                createdAt: Value(DateTime.now()),
              ),
            );
      }
    });
  }
}
