import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/journal/check_in.dart';
import 'package:moodlog/domain/entities/mood_summary/mood_summary.dart';
import 'package:moodlog/domain/repositories/check_in_repository.dart';
import 'package:moodlog/domain/repositories/gemini_repository.dart';
import 'package:moodlog/domain/repositories/mood_summary_repository.dart';

class MoodSummaryUseCase {
  final MoodSummaryRepository _moodSummaryRepository;
  final GeminiRepository _geminiRepository;
  final CheckInRepository _checkInRepository;

  MoodSummaryUseCase({
    required MoodSummaryRepository moodSummaryRepository,
    required GeminiRepository geminiRepository,
    required CheckInRepository checkInRepository,
  }) : _moodSummaryRepository = moodSummaryRepository,
       _geminiRepository = geminiRepository,
       _checkInRepository = checkInRepository;

  Future<Result<MoodSummary>> generateDailySummary(DateTime date) async {
    final startDate = DateTime(date.year, date.month, date.day);
    final endDate = startDate.add(const Duration(days: 1));

    return _generateSummary(
      period: MoodSummaryPeriod.daily,
      startDate: startDate,
      endDate: endDate,
    );
  }

  Future<Result<MoodSummary>> generateWeeklySummary(DateTime weekStart) async {
    final startDate = DateTime(weekStart.year, weekStart.month, weekStart.day);
    final endDate = startDate.add(const Duration(days: 7));

    return _generateSummary(
      period: MoodSummaryPeriod.weekly,
      startDate: startDate,
      endDate: endDate,
    );
  }

  Future<Result<MoodSummary>> generateMonthlySummary(DateTime month) async {
    final startDate = DateTime(month.year, month.month, 1);
    final endDate = DateTime(month.year, month.month + 1, 1);

    return _generateSummary(
      period: MoodSummaryPeriod.monthly,
      startDate: startDate,
      endDate: endDate,
    );
  }

  Future<Result<MoodSummary>> _generateSummary({
    required MoodSummaryPeriod period,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final checkInsResult = await _checkInRepository.getAllCheckIns();

    return switch (checkInsResult) {
      Ok<List<CheckIn>>() => await _processCheckInsAndGenerate(
        checkIns: checkInsResult.value,
        period: period,
        startDate: startDate,
        endDate: endDate,
      ),
      Error<List<CheckIn>>() => Result.error(checkInsResult.error),
    };
  }

  Future<Result<MoodSummary>> _processCheckInsAndGenerate({
    required List<CheckIn> checkIns,
    required MoodSummaryPeriod period,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final filteredCheckIns = checkIns.where((checkIn) {
      return checkIn.createdAt.isAfter(startDate) &&
          checkIn.createdAt.isBefore(endDate);
    }).toList();

    if (filteredCheckIns.isEmpty) {
      return Result.error(
        Exception('No check-ins found for the specified period'),
      );
    }

    if (period == MoodSummaryPeriod.daily && filteredCheckIns.length < 3) {
      return Result.error(
        Exception('Daily summary requires at least 3 check-ins'),
      );
    }

    final summaryResult = await _geminiRepository.generateMoodSummary(
      checkIns: filteredCheckIns,
      period: period,
      startDate: startDate,
      endDate: endDate,
    );

    return switch (summaryResult) {
      Ok<Map<String, String>>() => await _saveSummary(
        summaryData: summaryResult.value,
        period: period,
        startDate: startDate,
        endDate: endDate,
      ),
      Error<Map<String, String>>() => Result.error(summaryResult.error),
    };
  }

  Future<Result<MoodSummary>> _saveSummary({
    required Map<String, String> summaryData,
    required MoodSummaryPeriod period,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final summary = MoodSummary(
      id: 0,
      period: period,
      startDate: startDate,
      endDate: endDate,
      generatedAt: DateTime.now(),
      emotionalFlow: summaryData['emotionalFlow'] ?? '',
      dominantMoods: summaryData['dominantMoods'] ?? '',
      activityPatterns: summaryData['activityPatterns'] ?? '',
      personalAdvice: summaryData['personalAdvice'] ?? '',
      keyPoints: summaryData['keyPoints'] ?? '',
      metadata: {},
    );

    final saveResult = await _moodSummaryRepository.saveSummary(summary);

    return switch (saveResult) {
      Ok<int>() => Result.ok(summary.copyWith(id: saveResult.value)),
      Error<int>() => Result.error(saveResult.error),
    };
  }

  Future<Result<MoodSummary?>> getLatestSummary(
    MoodSummaryPeriod period,
  ) async {
    return _moodSummaryRepository.getLatestSummary(period);
  }

  Future<Result<List<MoodSummary>>> getSummariesByPeriod(
    MoodSummaryPeriod period,
  ) async {
    return _moodSummaryRepository.getSummariesByPeriod(period);
  }

  Future<Result<bool>> shouldGenerateSummary(MoodSummaryPeriod period) async {
    final now = DateTime.now();

    switch (period) {
      case MoodSummaryPeriod.daily:
        return _shouldGenerateDailySummary(now);
      case MoodSummaryPeriod.weekly:
        return _shouldGenerateWeeklySummary(now);
      case MoodSummaryPeriod.monthly:
        return _shouldGenerateMonthlySummary(now);
    }
  }

  Future<Result<bool>> _shouldGenerateDailySummary(DateTime now) async {
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));

    final existingResult = await _moodSummaryRepository.getSummaryByDateRange(
      today,
      tomorrow,
    );

    return switch (existingResult) {
      Error<MoodSummary?>(:final error) => Result.error(error),
      Ok<MoodSummary?>(value: final summary) => await _checkDailyCheckIns(
        today: today,
        tomorrow: tomorrow,
        hasExistingSummary: summary != null,
      ),
    };
  }

  Future<Result<bool>> _checkDailyCheckIns({
    required DateTime today,
    required DateTime tomorrow,
    required bool hasExistingSummary,
  }) async {
    if (hasExistingSummary) {
      return Result.ok(false);
    }

    final checkInsResult = await _checkInRepository.getAllCheckIns();

    return switch (checkInsResult) {
      Error<List<CheckIn>>(:final error) => Result.error(error),
      Ok<List<CheckIn>>(value: final checkIns) => Result.ok(
        checkIns.where((checkIn) {
          return checkIn.createdAt.isAfter(today) &&
              checkIn.createdAt.isBefore(tomorrow);
        }).length >= 3,
      ),
    };
  }

  Future<Result<bool>> _shouldGenerateWeeklySummary(DateTime now) async {
    if (now.weekday != DateTime.sunday) {
      return Result.ok(false);
    }

    final weekStart = now.subtract(Duration(days: now.weekday % 7));
    final weekStartDate = DateTime(
      weekStart.year,
      weekStart.month,
      weekStart.day,
    );
    final weekEnd = weekStartDate.add(const Duration(days: 7));

    final existingResult = await _moodSummaryRepository.getSummaryByDateRange(
      weekStartDate,
      weekEnd,
    );

    return switch (existingResult) {
      Ok<MoodSummary?>() => Result.ok(existingResult.value == null),
      Error<MoodSummary?>() => Result.error(existingResult.error),
    };
  }

  Future<Result<bool>> _shouldGenerateMonthlySummary(DateTime now) async {
    final nextMonth = DateTime(now.year, now.month + 1, 1);
    final isLastDayOfMonth = now.day == nextMonth.subtract(const Duration(days: 1)).day;

    if (!isLastDayOfMonth) {
      return Result.ok(false);
    }

    final monthStart = DateTime(now.year, now.month, 1);
    final monthEnd = DateTime(now.year, now.month + 1, 1);

    final existingResult = await _moodSummaryRepository.getSummaryByDateRange(
      monthStart,
      monthEnd,
    );

    return switch (existingResult) {
      Ok<MoodSummary?>() => Result.ok(existingResult.value == null),
      Error<MoodSummary?>() => Result.error(existingResult.error),
    };
  }

  Future<Result<void>> checkAndAutoGenerate() async {
    final now = DateTime.now();

    final dailyCheck = await shouldGenerateSummary(MoodSummaryPeriod.daily);
    if (dailyCheck is Ok<bool> && dailyCheck.value) {
      await generateDailySummary(now);
    }

    final weeklyCheck = await shouldGenerateSummary(MoodSummaryPeriod.weekly);
    if (weeklyCheck is Ok<bool> && weeklyCheck.value) {
      final weekStart = now.subtract(Duration(days: now.weekday % 7));
      await generateWeeklySummary(weekStart);
    }

    final monthlyCheck = await shouldGenerateSummary(MoodSummaryPeriod.monthly);
    if (monthlyCheck is Ok<bool> && monthlyCheck.value) {
      await generateMonthlySummary(now);
    }

    return Result.ok(null);
  }

  Future<Result<int>> getTodayCheckInCount() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));

    final checkInsResult = await _checkInRepository.getAllCheckIns();

    return switch (checkInsResult) {
      Error<List<CheckIn>>(:final error) => Result.error(error),
      Ok<List<CheckIn>>(value: final checkIns) => Result.ok(
        checkIns.where((checkIn) {
          return checkIn.createdAt.isAfter(today) &&
              checkIn.createdAt.isBefore(tomorrow);
        }).length,
      ),
    };
  }

  Future<Result<int>> getCurrentWeekDailySummaryCount() async {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday % 7));
    final weekStartDate = DateTime(
      weekStart.year,
      weekStart.month,
      weekStart.day,
    );
    final weekEnd = weekStartDate.add(const Duration(days: 7));

    final summariesResult = await _moodSummaryRepository.getSummariesByPeriod(
      MoodSummaryPeriod.daily,
    );

    return switch (summariesResult) {
      Error<List<MoodSummary>>(:final error) => Result.error(error),
      Ok<List<MoodSummary>>(value: final summaries) => Result.ok(
        summaries.where((summary) {
          return summary.startDate.isAfter(weekStartDate) &&
              summary.startDate.isBefore(weekEnd);
        }).length,
      ),
    };
  }

  Future<Result<int>> getCurrentMonthWeeklySummaryCount() async {
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);
    final monthEnd = DateTime(now.year, now.month + 1, 1);

    final summariesResult = await _moodSummaryRepository.getSummariesByPeriod(
      MoodSummaryPeriod.weekly,
    );

    return switch (summariesResult) {
      Error<List<MoodSummary>>(:final error) => Result.error(error),
      Ok<List<MoodSummary>>(value: final summaries) => Result.ok(
        summaries.where((summary) {
          return summary.startDate.isAfter(monthStart) &&
              summary.startDate.isBefore(monthEnd);
        }).length,
      ),
    };
  }
}
