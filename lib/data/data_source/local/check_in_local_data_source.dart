import 'package:drift/drift.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/data/data_source/local/database/database.dart';
import 'package:moodlog/domain/entities/journal/check_in.dart';
import 'package:moodlog/domain/entities/journal/emotion.dart';
import 'package:moodlog/domain/entities/journal/activity.dart';
import 'package:moodlog/domain/models/create_check_in_request.dart';
import 'package:moodlog/domain/models/update_check_in_request.dart';

class CheckInLocalDataSource {
  final MoodLogDatabase _db;

  CheckInLocalDataSource(this._db);

  Future<int> createCheckIn(CreateCheckInRequest request) async {
    return await _db.into(_db.checkIns).insert(
          CheckInsCompanion.insert(
            moodType: request.moodType,
            createdAt: request.createdAt,
            sleepQuality: Value(request.sleepQuality),
            emotionNames: Value(request.emotionNames),
            activityNames: Value(request.activityNames),
            memo: Value(request.memo),
            latitude: Value(request.latitude),
            longitude: Value(request.longitude),
            address: Value(request.address),
            temperature: Value(request.temperature),
            weatherIcon: Value(request.weatherIcon),
            weatherDescription: Value(request.weatherDescription),
          ),
        );
  }

  Future<int> updateCheckIn(UpdateCheckInRequest request) async {
    return await (_db.update(_db.checkIns)..where((t) => t.id.equals(request.id)))
        .write(
      CheckInsCompanion(
        moodType: Value(request.moodType),
        sleepQuality: request.sleepQuality == null
            ? const Value.absent()
            : Value(request.sleepQuality),
        emotionNames: Value(request.emotionNames),
        activityNames: Value(request.activityNames),
        memo: Value(request.memo),
        latitude: Value(request.latitude),
        longitude: Value(request.longitude),
        address: Value(request.address),
        temperature: Value(request.temperature),
        weatherIcon: Value(request.weatherIcon),
        weatherDescription: Value(request.weatherDescription),
      ),
    );
  }

  Future<void> deleteCheckIn(int id) async {
    await (_db.delete(_db.checkIns)..where((t) => t.id.equals(id))).go();
  }

  Future<CheckIn?> getCheckInById(int id) async {
    final checkIn = await (_db.select(_db.checkIns)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();

    if (checkIn == null) return null;

    final tags = await getTagsForCheckIn(id);
    final emotions = await getEmotionsForCheckIn(id);

    return checkIn.attachActivities(tags).attachEmotions(emotions);
  }

  Stream<List<CheckIn>> watchCheckInsByDate(DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    return (_db.select(_db.checkIns)
          ..where((t) => t.createdAt.isBetweenValues(startOfDay, endOfDay))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();
  }

  Future<List<CheckIn>> getAllCheckIns() async {
    return await (_db.select(_db.checkIns)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Stream<List<CheckIn>> watchAllCheckIns() {
    return (_db.select(_db.checkIns)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();
  }

  Future<bool> hasTodayCheckIn() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

    final count = await (_db.selectOnly(_db.checkIns)
          ..addColumns([_db.checkIns.id.count()])
          ..where(_db.checkIns.createdAt.isBetweenValues(startOfDay, endOfDay)))
        .getSingle();

    final countValue = count.read(_db.checkIns.id.count()) ?? 0;
    return countValue > 0;
  }

  Future<bool> hasCheckInOnDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    final count = await (_db.selectOnly(_db.checkIns)
          ..addColumns([_db.checkIns.id.count()])
          ..where(_db.checkIns.createdAt.isBetweenValues(startOfDay, endOfDay)))
        .getSingle();

    final countValue = count.read(_db.checkIns.id.count()) ?? 0;
    return countValue > 0;
  }

  Future<Map<MoodType, int>> getMoodCountsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final results = await (_db.select(_db.checkIns)
          ..where((t) => t.createdAt.isBetweenValues(startDate, endDate)))
        .get();

    final Map<MoodType, int> counts = {};
    for (final moodType in MoodType.values) {
      counts[moodType] = 0;
    }

    for (final checkIn in results) {
      counts[checkIn.moodType] = (counts[checkIn.moodType] ?? 0) + 1;
    }

    return counts;
  }

  Future<List<Activity>> getTagsForCheckIn(int checkInId) async {
    final query = _db.select(_db.activities).join([
      innerJoin(
        _db.checkInActivities,
        _db.checkInActivities.activityId.equalsExp(_db.activities.id),
      ),
    ])
      ..where(_db.checkInActivities.checkInId.equals(checkInId));

    final results = await query.get();
    return results.map((row) => row.readTable(_db.activities)).toList();
  }

  Future<List<Emotion>> getEmotionsForCheckIn(int checkInId) async {
    final query = _db.select(_db.emotions).join([
      innerJoin(
        _db.checkInEmotions,
        _db.checkInEmotions.emotionId.equalsExp(_db.emotions.id),
      ),
    ])
      ..where(_db.checkInEmotions.checkInId.equals(checkInId));

    final results = await query.get();
    return results.map((row) => row.readTable(_db.emotions)).toList();
  }

  Future<void> updateCheckInActivities(int checkInId, List<int> activityIds) async {
    await _db.transaction(() async {
      await (_db.delete(_db.checkInActivities)
            ..where((t) => t.checkInId.equals(checkInId)))
          .go();

      for (final activityId in activityIds) {
        await _db.into(_db.checkInActivities).insert(
              CheckInActivitiesCompanion.insert(
                checkInId: checkInId,
                activityId: activityId,
              ),
            );
      }
    });
  }

  Future<void> updateCheckInEmotions(int checkInId, List<int> emotionIds) async {
    await _db.transaction(() async {
      await (_db.delete(_db.checkInEmotions)
            ..where((t) => t.checkInId.equals(checkInId)))
          .go();

      for (final emotionId in emotionIds) {
        await _db.into(_db.checkInEmotions).insert(
              CheckInEmotionsCompanion.insert(
                checkInId: checkInId,
                emotionId: emotionId,
              ),
            );
      }
    });
  }
}
