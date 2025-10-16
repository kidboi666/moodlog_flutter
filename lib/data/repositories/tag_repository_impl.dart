import 'package:drift/native.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/data/data_source/local/tag_local_data_source.dart';
import 'package:moodlog/domain/entities/journal/tag.dart';
import 'package:moodlog/domain/entities/journal/tag_with_count.dart';
import 'package:moodlog/domain/repositories/tag_repository.dart';

class TagRepositoryImpl implements TagRepository {
  final TagLocalDataSource _localDataSource;

  TagRepositoryImpl({required TagLocalDataSource localDataSource})
    : _localDataSource = localDataSource;

  @override
  Future<Result<List<TagWithCount>>> getTagsWithCount() async {
    try {
      final tagsWithCount = await _localDataSource.getTagsWithCount();
      return Result.ok(tagsWithCount);
    } catch (e) {
      return Result.error(Exception('태그 목록을 가져오는데 실패했습니다: $e'));
    }
  }

  @override
  Future<Result<List<Tag>>> getAllTags() async {
    try {
      final tags = await _localDataSource.getAllTags();
      return Result.ok(tags);
    } catch (e) {
      return Result.error(Exception('태그 목록을 가져오는데 실패했습니다: $e'));
    }
  }

  @override
  Future<Result<Tag?>> getTagById(int id) async {
    try {
      final tag = await _localDataSource.getTagById(id);
      return Result.ok(tag);
    } catch (e) {
      return Result.error(Exception('태그를 찾는데 실패했습니다: $e'));
    }
  }

  @override
  Future<Result<Tag>> addTag(String name, String? color) async {
    try {
      final tag = await _localDataSource.addTag(name, color);
      return Result.ok(tag);
    } on SqliteException catch (e) {
      if (e.extendedResultCode == 2067) {
        // UNIQUE constraint failed
        return Result.error(Exception('이미 존재하는 태그 이름입니다'));
      }
      return Result.error(Exception('태그 생성에 실패했습니다: $e'));
    } catch (e) {
      return Result.error(Exception('태그 생성에 실패했습니다: $e'));
    }
  }

  @override
  Future<Result<void>> updateTag(int id, String name, String? color) async {
    try {
      final affectedRows = await _localDataSource.updateTag(id, name, color);

      if (affectedRows == 0) {
        return Result.error(Exception('존재하지 않는 태그입니다'));
      }

      return Result.ok(null);
    } on SqliteException catch (e) {
      if (e.extendedResultCode == 2067) {
        // UNIQUE constraint failed
        return Result.error(Exception('이미 존재하는 태그 이름입니다'));
      }

      return Result.error(Exception('태그 수정에 실패했습니다: $e'));
    } catch (e) {
      return Result.error(Exception('태그 수정에 실패했습니다: $e'));
    }
  }

  @override
  Future<Result<void>> deleteTag(int id) async {
    try {
      final affectedRows = await _localDataSource.deleteTag(id);

      if (affectedRows == 0) {
        return Result.error(Exception('존재하지 않는 태그입니다'));
      }

      return Result.ok(null);
    } on SqliteException catch (e) {
      if (e.extendedResultCode == 787) {
        // FOREIGN KEY constraint failed
        return Result.error(Exception('사용 중인 태그는 삭제할 수 없습니다'));
      }

      return Result.error(Exception('태그 삭제에 실패했습니다: $e'));
    } catch (e) {
      return Result.error(Exception('태그 삭제에 실패했습니다: $e'));
    }
  }
}
