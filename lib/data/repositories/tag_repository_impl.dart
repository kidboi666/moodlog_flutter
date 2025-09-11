import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import '../../core/utils/result.dart';
import '../../domain/entities/journal/tag.dart';
import '../../domain/repositories/tag_repository.dart';
import '../data_source/local/database/database.dart';

class TagRepositoryImpl implements TagRepository {
  final MoodLogDatabase _database;

  TagRepositoryImpl(this._database);

  @override
  Future<Result<List<Tag>>> getAllTags() async {
    try {
      final query = _database.select(_database.tags)
        ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]);
      final tags = await query.get();
      return Result.ok(tags);
    } catch (e) {
      return Result.failure(Exception('태그 목록을 가져오는데 실패했습니다: $e'));
    }
  }

  @override
  Future<Result<Tag?>> getTagById(int id) async {
    try {
      final query = _database.select(_database.tags)
        ..where((t) => t.id.equals(id));
      final results = await query.get();
      final tag = results.isNotEmpty ? results.first : null;
      return Result.ok(tag);
    } catch (e) {
      return Result.failure(Exception('태그를 찾는데 실패했습니다: $e'));
    }
  }

  @override
  Future<Result<List<Tag>>> getTagsByJournalId(int journalId) async {
    try {
      final query =
          _database.select(_database.tags).join([
              innerJoin(
                _database.journalTags,
                _database.journalTags.tagId.equalsExp(_database.tags.id),
              ),
            ])
            ..where(_database.journalTags.journalId.equals(journalId))
            ..orderBy([OrderingTerm.asc(_database.tags.name)]);

      final results = await query.get();
      final tags = results.map((row) => row.readTable(_database.tags)).toList();
      return Result.ok(tags);
    } catch (e) {
      return Result.failure(Exception('일기의 태그를 가져오는데 실패했습니다: $e'));
    }
  }

  @override
  Future<Result<int>> addTag(String name, String? color) async {
    try {
      final tagId = await _database
          .into(_database.tags)
          .insert(
            TagsCompanion(
              name: Value(name),
              color: Value(color),
              createdAt: Value(DateTime.now()),
            ),
          );
      return Result.ok(tagId);
    } on SqliteException catch (e) {
      if (e.extendedResultCode == 2067) {
        // UNIQUE constraint failed
        return Result.failure(Exception('이미 존재하는 태그 이름입니다'));
      }
      return Result.failure(Exception('태그 생성에 실패했습니다: $e'));
    } catch (e) {
      return Result.failure(Exception('태그 생성에 실패했습니다: $e'));
    }
  }

  @override
  Future<Result<void>> updateTag(int id, String name, String? color) async {
    try {
      final affectedRows =
          await (_database.update(_database.tags)
                ..where((t) => t.id.equals(id)))
              .write(TagsCompanion(name: Value(name), color: Value(color)));

      if (affectedRows == 0) {
        return Result.failure(Exception('존재하지 않는 태그입니다'));
      }

      return Result.ok(null);
    } on SqliteException catch (e) {
      if (e.extendedResultCode == 2067) {
        // UNIQUE constraint failed
        return Result.failure(Exception('이미 존재하는 태그 이름입니다'));
      }
      return Result.failure(Exception('태그 수정에 실패했습니다: $e'));
    } catch (e) {
      return Result.failure(Exception('태그 수정에 실패했습니다: $e'));
    }
  }

  @override
  Future<Result<void>> deleteTag(int id) async {
    try {
      final affectedRows = await (_database.delete(
        _database.tags,
      )..where((t) => t.id.equals(id))).go();

      if (affectedRows == 0) {
        return Result.failure(Exception('존재하지 않는 태그입니다'));
      }

      return Result.ok(null);
    } on SqliteException catch (e) {
      if (e.extendedResultCode == 787) {
        // FOREIGN KEY constraint failed
        return Result.failure(Exception('사용 중인 태그는 삭제할 수 없습니다'));
      }
      return Result.failure(Exception('태그 삭제에 실패했습니다: $e'));
    } catch (e) {
      return Result.failure(Exception('태그 삭제에 실패했습니다: $e'));
    }
  }

  @override
  Future<Result<void>> addTagToJournal(int journalId, int tagId) async {
    try {
      await _database
          .into(_database.journalTags)
          .insert(
            JournalTagsCompanion(
              journalId: Value(journalId),
              tagId: Value(tagId),
              createdAt: Value(DateTime.now()),
            ),
          );
      return Result.ok(null);
    } on SqliteException catch (e) {
      if (e.extendedResultCode == 2067) {
        // UNIQUE constraint failed
        return Result.failure(Exception('이미 일기에 추가된 태그입니다'));
      }
      if (e.extendedResultCode == 787) {
        // FOREIGN KEY constraint failed
        return Result.failure(Exception('존재하지 않는 일기 또는 태그입니다'));
      }
      return Result.failure(Exception('일기에 태그 추가에 실패했습니다: $e'));
    } catch (e) {
      return Result.failure(Exception('일기에 태그 추가에 실패했습니다: $e'));
    }
  }

  @override
  Future<Result<void>> removeTagFromJournal(int journalId, int tagId) async {
    try {
      final affectedRows =
          await (_database.delete(_database.journalTags)..where(
                (jt) => jt.journalId.equals(journalId) & jt.tagId.equals(tagId),
              ))
              .go();

      if (affectedRows == 0) {
        return Result.failure(Exception('일기에서 해당 태그를 찾을 수 없습니다'));
      }

      return Result.ok(null);
    } catch (e) {
      return Result.failure(Exception('일기에서 태그 제거에 실패했습니다: $e'));
    }
  }

  @override
  Future<Result<void>> updateJournalTags(
    int journalId,
    List<int> tagIds,
  ) async {
    try {
      await _database.transaction(() async {
        // 기존 태그들 모두 삭제
        await (_database.delete(
          _database.journalTags,
        )..where((jt) => jt.journalId.equals(journalId))).go();

        // 새로운 태그들 추가
        for (final tagId in tagIds) {
          await _database
              .into(_database.journalTags)
              .insert(
                JournalTagsCompanion(
                  journalId: Value(journalId),
                  tagId: Value(tagId),
                  createdAt: Value(DateTime.now()),
                ),
              );
        }
      });

      return Result.ok(null);
    } on SqliteException catch (e) {
      if (e.extendedResultCode == 787) {
        // FOREIGN KEY constraint failed
        return Result.failure(Exception('존재하지 않는 일기 또는 태그가 포함되어 있습니다'));
      }
      return Result.failure(Exception('일기 태그 업데이트에 실패했습니다: $e'));
    } catch (e) {
      return Result.failure(Exception('일기 태그 업데이트에 실패했습니다: $e'));
    }
  }

  // 추가적인 헬퍼 메서드들
  @override
  Future<Result<bool>> isTagNameExists(String name, {int? excludeId}) async {
    try {
      final query = _database.select(_database.tags)
        ..where((t) => t.name.equals(name));

      if (excludeId != null) {
        query.where((t) => t.id.equals(excludeId).not());
      }

      final results = await query.get();
      return Result.ok(results.isNotEmpty);
    } catch (e) {
      return Result.failure(Exception('태그 중복 확인에 실패했습니다: $e'));
    }
  }

  @override
  Future<Result<List<Tag>>> searchTags(String query) async {
    try {
      final searchQuery = _database.select(_database.tags)
        ..where((t) => t.name.like('%$query%'))
        ..orderBy([(t) => OrderingTerm.asc(t.name)]);

      final tags = await searchQuery.get();
      return Result.ok(tags);
    } catch (e) {
      return Result.failure(Exception('태그 검색에 실패했습니다: $e'));
    }
  }
}
