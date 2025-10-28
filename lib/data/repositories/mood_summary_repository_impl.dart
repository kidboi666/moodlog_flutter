import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/data/data_source/local/mood_summary_local_data_source.dart';
import 'package:moodlog/domain/entities/mood_summary/mood_summary.dart';
import 'package:moodlog/domain/repositories/mood_summary_repository.dart';

class MoodSummaryRepositoryImpl implements MoodSummaryRepository {
  final MoodSummaryLocalDataSource _localDataSource;

  MoodSummaryRepositoryImpl({
    required MoodSummaryLocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;

  @override
  Future<Result<MoodSummary?>> getLatestSummary(
    MoodSummaryPeriod period,
  ) async {
    try {
      final summary = await _localDataSource.getLatestSummaryByPeriod(period);
      return Result.ok(summary);
    } catch (e) {
      return Result.error(Exception('Failed to get latest summary: $e'));
    }
  }

  @override
  Future<Result<List<MoodSummary>>> getSummariesByPeriod(
    MoodSummaryPeriod period, {
    int limit = 10,
  }) async {
    try {
      final summaries = await _localDataSource.getSummariesByPeriod(
        period,
        limit: limit,
      );
      return Result.ok(summaries);
    } catch (e) {
      return Result.error(Exception('Failed to get summaries: $e'));
    }
  }

  @override
  Future<Result<int>> saveSummary(MoodSummary summary) async {
    try {
      final id = await _localDataSource.insertSummary(summary);
      return Result.ok(id);
    } catch (e) {
      return Result.error(Exception('Failed to save summary: $e'));
    }
  }

  @override
  Future<Result<void>> deleteSummary(int id) async {
    try {
      await _localDataSource.deleteSummary(id);
      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Failed to delete summary: $e'));
    }
  }

  @override
  Future<Result<MoodSummary?>> getSummaryByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    try {
      final summary = await _localDataSource.getSummaryByDateRange(
        start,
        end,
      );
      return Result.ok(summary);
    } catch (e) {
      return Result.error(Exception('Failed to get summary by date range: $e'));
    }
  }

  @override
  Future<Result<List<MoodSummary>>> getAllSummaries() async {
    try {
      final summaries = await _localDataSource.getAllSummaries();
      return Result.ok(summaries);
    } catch (e) {
      return Result.error(Exception('Failed to get all summaries: $e'));
    }
  }
}
