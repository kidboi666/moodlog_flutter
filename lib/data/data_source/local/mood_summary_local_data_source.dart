import 'package:drift/drift.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/data/data_source/local/database/database.dart';
import 'package:moodlog/domain/entities/mood_summary/mood_summary.dart';

class MoodSummaryLocalDataSource {
  final MoodLogDatabase db;

  MoodSummaryLocalDataSource({required this.db});

  Future<MoodSummary?> getLatestSummaryByPeriod(
    MoodSummaryPeriod period,
  ) async {
    final query = db.select(db.moodSummaries)
      ..where((tbl) => tbl.period.equals(period.index))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.generatedAt)])
      ..limit(1);

    final results = await query.get();
    return results.isEmpty ? null : results.first;
  }

  Future<List<MoodSummary>> getSummariesByPeriod(
    MoodSummaryPeriod period, {
    int limit = 10,
  }) async {
    final query = db.select(db.moodSummaries)
      ..where((tbl) => tbl.period.equals(period.index))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.generatedAt)])
      ..limit(limit);

    return await query.get();
  }

  Future<int> insertSummary(MoodSummary summary) async {
    return await db.into(db.moodSummaries).insert(
      MoodSummariesCompanion.insert(
        period: summary.period,
        startDate: summary.startDate,
        endDate: summary.endDate,
        generatedAt: summary.generatedAt,
        emotionalFlow: summary.emotionalFlow,
        dominantMoods: summary.dominantMoods,
        activityPatterns: summary.activityPatterns,
        personalAdvice: summary.personalAdvice,
        keyPoints: summary.keyPoints,
        metadata: summary.metadata,
      ),
    );
  }

  Future<void> deleteSummary(int id) async {
    await (db.delete(db.moodSummaries)
      ..where((tbl) => tbl.id.equals(id))
    ).go();
  }

  Future<MoodSummary?> getSummaryByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    final query = db.select(db.moodSummaries)
      ..where((tbl) =>
        tbl.startDate.isBiggerOrEqualValue(start) &
        tbl.endDate.isSmallerOrEqualValue(end))
      ..limit(1);

    final results = await query.get();
    return results.isEmpty ? null : results.first;
  }

  Future<List<MoodSummary>> getAllSummaries() async {
    final query = db.select(db.moodSummaries)
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.generatedAt)]);

    return await query.get();
  }
}
