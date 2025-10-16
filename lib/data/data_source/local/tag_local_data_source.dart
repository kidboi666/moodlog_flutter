import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:moodlog/data/data_source/local/database/database.dart';
import 'package:moodlog/domain/entities/journal/tag.dart';
import 'package:moodlog/domain/entities/journal/tag_with_count.dart';

class TagLocalDataSource {
  final MoodLogDatabase _db;

  TagLocalDataSource({MoodLogDatabase? db}) : _db = db ?? MoodLogDatabase();

  Future<List<TagWithCount>> getTagsWithCount() async {
    final query = _db.customSelect(
      'SELECT t.*, COUNT(ct.tag_id) AS check_in_count FROM tags AS t LEFT JOIN check_in_tags AS ct ON t.id = ct.tag_id GROUP BY t.id ORDER BY t.created_at ASC',
      readsFrom: {_db.tags, _db.checkInTags},
    );

    return query.map((row) {
      final tag = Tag(
        id: row.read<int>('id'),
        name: row.read<String>('name'),
        color: row.read<String?>('color'),
        createdAt: row.read<DateTime>('created_at'),
      );
      final count = row.read<int>('check_in_count');
      return TagWithCount(tag: tag, count: count);
    }).get();
  }

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

  // Journal과 Tag 연결은 더 이상 사용하지 않음
  // CheckIn과 Tag 연결은 CheckInLocalDataSource에서 관리

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

  Future<List<int>> getOrCreateTags(List<String> tagNames) async {
    try {
      final tagIds = <int>[];

      for (final tagName in tagNames) {
        final trimmedName = tagName.trim();
        if (trimmedName.isEmpty) continue;

        final existingTag = await (_db.select(_db.tags)
              ..where((t) => t.name.equals(trimmedName)))
            .getSingleOrNull();

        if (existingTag != null) {
          tagIds.add(existingTag.id);
        } else {
          final newTag = await addTag(trimmedName, null);
          tagIds.add(newTag.id);
        }
      }

      return tagIds;
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

  // Journal-Tag 연결 메서드들은 제거됨
  // 필요시 CheckInLocalDataSource 사용
}
