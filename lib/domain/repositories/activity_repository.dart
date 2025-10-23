import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/journal/activity.dart';
import 'package:moodlog/domain/entities/journal/activity_with_count.dart';

abstract class ActivityRepository {
  Future<Result<List<ActivityWithCount>>> getActivitiesWithCount();
  Future<Result<List<Activity>>> getAllActivities();
  Future<Result<Activity?>> getActivityById(int id);
  Future<Result<Activity>> addActivity(String name, String? color);
  Future<Result<void>> updateActivity(int id, String name, String? color);
  Future<Result<void>> deleteActivity(int id);
}
