import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:moodlog/data/data_source/local/database/database.dart';
import 'package:moodlog/domain/entities/journal/activity.dart';
import 'package:moodlog/domain/entities/journal/activity_with_count.dart';

class ActivityLocalDataSource {
  final MoodLogDatabase _db;

  ActivityLocalDataSource({MoodLogDatabase? db}) : _db = db ?? MoodLogDatabase();

  Future<List<ActivityWithCount>> getActivitiesWithCount() async {
    final query = _db.customSelect(
      'SELECT t.*, COUNT(ct.activity_id) AS check_in_count FROM activities AS t LEFT JOIN check_in_activities AS ct ON t.id = ct.activity_id GROUP BY t.id ORDER BY t.created_at ASC',
      readsFrom: {_db.activities, _db.checkInActivities},
    );

    return query.map((row) {
      final activity = Activity(
        id: row.read<int>('id'),
        name: row.read<String>('name'),
        color: row.read<String?>('color'),
        createdAt: row.read<DateTime>('created_at'),
      );
      final count = row.read<int>('check_in_count');
      return ActivityWithCount(activity: activity, count: count);
    }).get();
  }

  Future<List<Activity>> getAllActivities() async {
    try {
      return await (_db.select(
        _db.activities,
      )..orderBy([(t) => OrderingTerm.asc(t.createdAt)])).get();
    } on SqliteException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Activity?> getActivityById(int id) async {
    try {
      return await (_db.select(
        _db.activities,
      )..where((t) => t.id.equals(id))).getSingleOrNull();
    } on SqliteException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Activity> addActivity(String name, String? color) async {
    try {
      return await (_db
          .into(_db.activities)
          .insertReturning(
            ActivitiesCompanion(
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

  Future<List<int>> getOrCreateActivities(List<String> activityNames) async {
    try {
      final activityIds = <int>[];

      for (final activityName in activityNames) {
        final trimmedName = activityName.trim();
        if (trimmedName.isEmpty) continue;

        final existingActivity = await (_db.select(_db.activities)
              ..where((t) => t.name.equals(trimmedName)))
            .getSingleOrNull();

        if (existingActivity != null) {
          activityIds.add(existingActivity.id);
        } else {
          final newActivity = await addActivity(trimmedName, null);
          activityIds.add(newActivity.id);
        }
      }

      return activityIds;
    } on SqliteException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<int> updateActivity(int id, String name, String? color) async {
    try {
      return await (_db.update(_db.activities)..where((t) => t.id.equals(id))).write(
        ActivitiesCompanion(name: Value(name), color: Value(color)),
      );
    } on SqliteException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<int> deleteActivity(int id) async {
    try {
      return await (_db.delete(_db.activities)..where((t) => t.id.equals(id))).go();
    } on SqliteException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
