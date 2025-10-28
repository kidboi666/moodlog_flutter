import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/mixins/async_state_mixin.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/mood_summary/mood_summary.dart';
import 'package:moodlog/domain/use_cases/mood_summary_use_case.dart';

class MoodSummaryViewModel extends ChangeNotifier with AsyncStateMixin {
  final MoodSummaryUseCase _moodSummaryUseCase;

  MoodSummaryViewModel({
    required MoodSummaryUseCase moodSummaryUseCase,
  }) : _moodSummaryUseCase = moodSummaryUseCase {
    _load();
  }

  MoodSummary? _dailySummary;
  MoodSummary? _weeklySummary;
  MoodSummary? _monthlySummary;
  bool _isGenerating = false;
  String? _errorMessage;
  int? _todayCheckInCount;
  int? _currentWeekDailySummaryCount;
  int? _currentMonthWeeklySummaryCount;

  MoodSummary? get dailySummary => _dailySummary;
  MoodSummary? get weeklySummary => _weeklySummary;
  MoodSummary? get monthlySummary => _monthlySummary;
  bool get isGenerating => _isGenerating;
  String? get errorMessage => _errorMessage;
  int? get todayCheckInCount => _todayCheckInCount;
  int? get currentWeekDailySummaryCount => _currentWeekDailySummaryCount;
  int? get currentMonthWeeklySummaryCount => _currentMonthWeeklySummaryCount;

  void _load() async {
    setLoading();
    await _loadAllSummaries();
    await _loadTodayCheckInCount();
    await _loadCurrentWeekDailySummaryCount();
    await _loadCurrentMonthWeeklySummaryCount();
    setSuccess();
  }

  Future<void> _loadAllSummaries() async {
    await Future.wait([
      _loadSummary(MoodSummaryPeriod.daily),
      _loadSummary(MoodSummaryPeriod.weekly),
      _loadSummary(MoodSummaryPeriod.monthly),
    ]);
  }

  Future<void> _loadTodayCheckInCount() async {
    final result = await _moodSummaryUseCase.getTodayCheckInCount();
    switch (result) {
      case Ok(value: final count):
        _todayCheckInCount = count;
        notifyListeners();
      case Error(error: final e):
        debugPrint('Failed to load today check-in count: $e');
    }
  }

  Future<void> _loadCurrentWeekDailySummaryCount() async {
    final result = await _moodSummaryUseCase.getCurrentWeekDailySummaryCount();
    switch (result) {
      case Ok(value: final count):
        _currentWeekDailySummaryCount = count;
        notifyListeners();
      case Error(error: final e):
        debugPrint('Failed to load current week daily summary count: $e');
    }
  }

  Future<void> _loadCurrentMonthWeeklySummaryCount() async {
    final result =
        await _moodSummaryUseCase.getCurrentMonthWeeklySummaryCount();
    switch (result) {
      case Ok(value: final count):
        _currentMonthWeeklySummaryCount = count;
        notifyListeners();
      case Error(error: final e):
        debugPrint('Failed to load current month weekly summary count: $e');
    }
  }

  Future<void> _loadSummary(MoodSummaryPeriod period) async {
    final result = await _moodSummaryUseCase.getLatestSummary(period);
    switch (result) {
      case Ok(value: final summary):
        _setSummary(period, summary);
      case Error(error: final e):
        debugPrint('Failed to load $period summary: $e');
    }
  }

  void _setSummary(MoodSummaryPeriod period, MoodSummary? summary) {
    switch (period) {
      case MoodSummaryPeriod.daily:
        _dailySummary = summary;
      case MoodSummaryPeriod.weekly:
        _weeklySummary = summary;
      case MoodSummaryPeriod.monthly:
        _monthlySummary = summary;
    }
    notifyListeners();
  }

  Future<void> generateSummary(MoodSummaryPeriod period) async {
    _isGenerating = true;
    _errorMessage = null;
    notifyListeners();

    final now = DateTime.now();
    Result<MoodSummary> result;
    switch (period) {
      case MoodSummaryPeriod.daily:
        result = await _moodSummaryUseCase.generateDailySummary(now);
      case MoodSummaryPeriod.weekly:
        final weekStart = now.subtract(Duration(days: now.weekday - 1));
        result = await _moodSummaryUseCase.generateWeeklySummary(weekStart);
      case MoodSummaryPeriod.monthly:
        final monthStart = DateTime(now.year, now.month, 1);
        result = await _moodSummaryUseCase.generateMonthlySummary(monthStart);
    }

    switch (result) {
      case Ok(value: final summary):
        _setSummary(period, summary);
        _errorMessage = null;
      case Error(error: final e):
        debugPrint('Failed to generate $period summary: $e');
        _errorMessage = e.toString();
    }

    _isGenerating = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    await _loadAllSummaries();
    await _loadTodayCheckInCount();
    await _loadCurrentWeekDailySummaryCount();
    await _loadCurrentMonthWeeklySummaryCount();
  }

  Future<void> checkAndAutoGenerate() async {
    setLoading();
    final result = await _moodSummaryUseCase.checkAndAutoGenerate();
    switch (result) {
      case Ok():
        await _loadAllSummaries();
      case Error(error: final e):
        debugPrint('Auto-generation check failed: $e');
    }
    setSuccess();
  }

  MoodSummary? getSummaryByPeriod(MoodSummaryPeriod period) {
    return switch (period) {
      MoodSummaryPeriod.daily => _dailySummary,
      MoodSummaryPeriod.weekly => _weeklySummary,
      MoodSummaryPeriod.monthly => _monthlySummary,
    };
  }

  bool shouldShowGenerateButton(MoodSummaryPeriod period) {
    final summary = getSummaryByPeriod(period);
    if (summary == null) return true;

    final now = DateTime.now();
    final lastGenerated = summary.generatedAt;

    return switch (period) {
      MoodSummaryPeriod.daily => !lastGenerated.isSameDay(now),
      MoodSummaryPeriod.weekly => !lastGenerated.isSameWeek(now),
      MoodSummaryPeriod.monthly => !lastGenerated.isSameMonth(now),
    };
  }

  String getTimeRemainingText(MoodSummaryPeriod period) {
    final now = DateTime.now();

    switch (period) {
      case MoodSummaryPeriod.daily:
        final tomorrow = DateTime(now.year, now.month, now.day + 1);
        final remaining = tomorrow.difference(now);
        final hours = remaining.inHours;
        return '$hours시간 후 생성 가능';

      case MoodSummaryPeriod.weekly:
        final daysUntilSunday = (7 - now.weekday) % 7;
        if (daysUntilSunday == 0) return '오늘 생성 가능';
        return '$daysUntilSunday일 후 생성 가능';

      case MoodSummaryPeriod.monthly:
        final lastDayOfMonth = DateTime(now.year, now.month + 1, 0).day;
        final daysRemaining = lastDayOfMonth - now.day;
        if (daysRemaining == 0) return '오늘 생성 가능';
        return '$daysRemaining일 후 생성 가능';
    }
  }
}

extension _DateTimeExtension on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isSameWeek(DateTime other) {
    final thisMonday = subtract(Duration(days: weekday - 1));
    final otherMonday = other.subtract(Duration(days: other.weekday - 1));
    return thisMonday.year == otherMonday.year &&
        thisMonday.month == otherMonday.month &&
        thisMonday.day == otherMonday.day;
  }

  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
  }
}
