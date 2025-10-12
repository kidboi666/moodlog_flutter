import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:logging/logging.dart';

import '../../../domain/entities/journal/journal_tag.dart';
import '../../../domain/entities/journal/tag.dart';
import 'database/database.dart';

class TagLocalDataSource {
  final MoodLogDatabase _db;
  final Logger _log = Logger('TagLocalDataSource');

  TagLocalDataSource({MoodLogDatabase? db}) : _db = db ?? MoodLogDatabase();

  Future<List<Tag>> getAllTags() async {
    try {
      return await (_db.select(
        _db.tags,
      )..orderBy([(t) => OrderingTerm.asc(t.createdAt)])).get();
    } on SqliteException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Tag?> getTagById(int id) async {
    try {
      return await (_db.select(
        _db.tags,
      )..where((t) => t.id.equals(id))).getSingleOrNull();
    } on SqliteException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Tag>> getTagsByJournalId(int journalId) async {
    try {
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
    } on SqliteException catch (e, s) {
      _log.severe('Error in getTagsByJournalId', e, s);
      throw Exception(e);
    } catch (e, s) {
      _log.severe('Error in getTagsByJournalId', e, s);
      throw Exception(e);
    }
  }

  Future<Tag> addTag(String name, String? color) async {
    try {
      return await (_db
          .into(_db.tags)
          .insertReturning(
            TagsCompanion(
              name: Value(name),
              color: Value(color),
              createdAt: Value(DateTime.now()),
            ),
          ));
    } on SqliteException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<int> updateTag(int id, String name, String? color) async {
    try {
      return await (_db.update(_db.tags)..where((t) => t.id.equals(id))).write(
        TagsCompanion(name: Value(name), color: Value(color)),
      );
    } on SqliteException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<int> deleteTag(int id) async {
    try {
      return await (_db.delete(_db.tags)..where((t) => t.id.equals(id))).go();
    } on SqliteException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<JournalTag?> addTagToJournal(int journalId, int tagId) async {
    try {
      return await (_db
          .into(_db.journalTags)
          .insertReturningOrNull(
            JournalTagsCompanion(
              journalId: Value(journalId),
              tagId: Value(tagId),
              createdAt: Value(DateTime.now()),
            ),
          ));
    } on SqliteException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<int> removeTagFromJournal(int journalId, int tagId) async {
    try {
      return await (_db.delete(_db.journalTags)..where(
            (t) => t.journalId.equals(journalId) & t.tagId.equals(tagId),
          ))
          .go();
    } on SqliteException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateJournalTags(int journalId, List<int> tagIds) async {
    try {
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
    } on SqliteException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
