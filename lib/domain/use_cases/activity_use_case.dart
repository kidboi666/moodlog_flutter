import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/journal/activity.dart';
import 'package:moodlog/domain/entities/journal/activity_with_count.dart';
import 'package:moodlog/domain/repositories/activity_repository.dart';

class ActivityUseCase {
  final ActivityRepository _activityRepository;

  ActivityUseCase(this._activityRepository);

  Future<Result<List<ActivityWithCount>>> getActivitiesWithCount() async {
    return await _activityRepository.getActivitiesWithCount();
  }

  Future<Result<Activity>> addActivity(String name, String? color) async {
    return await _activityRepository.addActivity(name, color);
  }

  Future<Result<void>> deleteActivity(int id) async {
    return await _activityRepository.deleteActivity(id);
  }

  Future<Result<List<Activity>>> getAllActivities() async {
    return await _activityRepository.getAllActivities();
  }

  Future<Result<Activity?>> getActivityById(int id) async {
    return await _activityRepository.getActivityById(id);
  }

  Future<Result<void>> updateActivity(int id, String name, String? color) async {
    return _activityRepository.updateActivity(id, name, color);
  }
}
