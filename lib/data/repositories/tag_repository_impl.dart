import 'package:drift/drift.dart';

import '../../domain/entities/tag.dart';
import '../../domain/repositories/tag_repository.dart';
import '../data_source/database.dart';

class TagRepositoryImpl implements TagRepository {
  final MoodLogDatabase _database;

  TagRepositoryImpl(this._database);

  @override
  Future<List<Tag>> getAllTags() async {
    final query = _database.select(_database.tags)
      ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]);
    return await query.get();
  }

  @override
  Future<Tag?> getTagById(int id) async {
    final query = _database.select(_database.tags)
      ..where((t) => t.id.equals(id));
    final results = await query.get();
    return results.isNotEmpty ? results.first : null;
  }

  @override
  Future<List<Tag>> getTagsByJournalId(int journalId) async {
    final query = _database.select(_database.tags).join([
      innerJoin(_database.journalTags, _database.journalTags.tagId.equalsExp(_database.tags.id))
    ])
      ..where(_database.journalTags.journalId.equals(journalId))
      ..orderBy([OrderingTerm.asc(_database.tags.name)]);
    
    final results = await query.get();
    return results.map((row) => row.readTable(_database.tags)).toList();
  }

  @override
  Future<int> addTag(String name, String? color) async {
    return await _database.into(_database.tags).insert(
      TagsCompanion(
        name: Value(name),
        color: Value(color),
        createdAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> updateTag(int id, String name, String? color) async {
    await (_database.update(_database.tags)..where((t) => t.id.equals(id))).write(
      TagsCompanion(
        name: Value(name),
        color: Value(color),
      ),
    );
  }

  @override
  Future<void> deleteTag(int id) async {
    await (_database.delete(_database.tags)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<void> addTagToJournal(int journalId, int tagId) async {
    await _database.into(_database.journalTags).insert(
      JournalTagsCompanion(
        journalId: Value(journalId),
        tagId: Value(tagId),
        createdAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> removeTagFromJournal(int journalId, int tagId) async {
    await (_database.delete(_database.journalTags)
          ..where((jt) => jt.journalId.equals(journalId) & jt.tagId.equals(tagId)))
        .go();
  }

  @override
  Future<void> updateJournalTags(int journalId, List<int> tagIds) async {
    await _database.transaction(() async {
      await (_database.delete(_database.journalTags)
            ..where((jt) => jt.journalId.equals(journalId)))
          .go();

      for (final tagId in tagIds) {
        await _database.into(_database.journalTags).insert(
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