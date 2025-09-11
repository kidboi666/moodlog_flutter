import 'package:drift/native.dart';

import '../../core/utils/result.dart';
import '../../domain/entities/journal/tag.dart';
import '../../domain/repositories/tag_repository.dart';
import '../data_source/local/tag_local_data_source.dart';

class TagRepositoryImpl implements TagRepository {
  final TagLocalDataSource _localDataSource;

  TagRepositoryImpl({required TagLocalDataSource localDataSource})
    : _localDataSource = localDataSource;

  @override
  Future<Result<List<Tag>>> getAllTags() async {
    try {
      final tags = await _localDataSource.getAllTags();
      return Result.ok(tags);
    } catch (e) {
      return Result.failure(Exception('태그 목록을 가져오는데 실패했습니다: $e'));
    }
  }

  @override
  Future<Result<Tag?>> getTagById(int id) async {
    try {
      final tag = await _localDataSource.getTagById(id);
      return Result.ok(tag);
    } catch (e) {
      return Result.failure(Exception('태그를 찾는데 실패했습니다: $e'));
    }
  }

  @override
  Future<Result<List<Tag>>> getTagsByJournalId(int journalId) async {
    try {
      final tags = await _localDataSource.getTagsByJournalId(journalId);
      return Result.ok(tags);
    } catch (e) {
      return Result.failure(Exception('일기의 태그를 가져오는데 실패했습니다: $e'));
    }
  }

  @override
  Future<Result<int>> addTag(String name, String? color) async {
    try {
      final tagId = await _localDataSource.addTag(name, color);
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
      final affectedRows = await _localDataSource.updateTag(id, name, color);

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
      final affectedRows = await _localDataSource.deleteTag(id);

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
      await _localDataSource.addTagToJournal(journalId, tagId);

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
      final affectedRows = await _localDataSource.removeTagFromJournal(
        journalId,
        tagId,
      );

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
      await _localDataSource.updateJournalTags(journalId, tagIds);

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
}
