import 'package:drift/native.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/data/data_source/local/activity_local_data_source.dart';
import 'package:moodlog/domain/entities/journal/activity.dart';
import 'package:moodlog/domain/entities/journal/activity_with_count.dart';
import 'package:moodlog/domain/repositories/activity_repository.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  final ActivityLocalDataSource _localDataSource;

  ActivityRepositoryImpl({required ActivityLocalDataSource localDataSource})
    : _localDataSource = localDataSource;

  @override
  Future<Result<List<ActivityWithCount>>> getActivitiesWithCount() async {
    try {
      final tagsWithCount = await _localDataSource.getActivitiesWithCount();
      return Result.ok(tagsWithCount);
    } catch (e) {
      return Result.error(Exception('태그 목록을 가져오는데 실패했습니다: $e'));
    }
  }

  @override
  Future<Result<List<Activity>>> getAllActivities() async {
    try {
      final tags = await _localDataSource.getAllActivities();
      return Result.ok(tags);
    } catch (e) {
      return Result.error(Exception('태그 목록을 가져오는데 실패했습니다: $e'));
    }
  }

  @override
  Future<Result<Activity?>> getActivityById(int id) async {
    try {
      final tag = await _localDataSource.getActivityById(id);
      return Result.ok(tag);
    } catch (e) {
      return Result.error(Exception('태그를 찾는데 실패했습니다: $e'));
    }
  }

  @override
  Future<Result<Activity>> addActivity(String name, String? color) async {
    try {
      final tag = await _localDataSource.addActivity(name, color);
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
  Future<Result<void>> updateActivity(
    int id,
    String name,
    String? color,
  ) async {
    try {
      final affectedRows = await _localDataSource.updateActivity(
        id,
        name,
        color,
      );

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
  Future<Result<void>> deleteActivity(int id) async {
    try {
      final affectedRows = await _localDataSource.deleteActivity(id);

      if (affectedRows == 0) {
        return Result.error(Exception('존재하지 않는 태그입니다'));
      }

      return Result.ok(null);
    } on SqliteException catch (e) {
      if (e.extendedResultCode == 787) {
        return Result.error(Exception('사용 중인 태그는 삭제할 수 없습니다'));
      }

      return Result.error(Exception('태그 삭제에 실패했습니다: $e'));
    } catch (e) {
      return Result.error(Exception('태그 삭제에 실패했습니다: $e'));
    }
  }
}
