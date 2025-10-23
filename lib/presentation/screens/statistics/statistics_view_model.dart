import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/mixins/async_state_mixin.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/data/repositories/analytics_repository_impl.dart';
import 'package:moodlog/domain/entities/journal/check_in.dart';
import 'package:moodlog/domain/repositories/check_in_repository.dart';
import 'package:moodlog/presentation/providers/user_provider.dart';

class StatisticsViewModel extends ChangeNotifier with AsyncStateMixin {
  final CheckInRepository _checkInRepository;
  final UserProvider _userProvider;

  StatisticsViewModel({
    required CheckInRepository checkInRepository,
    required UserProvider userProvider,
  })  : _checkInRepository = checkInRepository,
        _userProvider = userProvider {
    _loadStatistics();
  }

  List<CheckIn> _allCheckIns = [];
  Map<MoodType, int> _moodCounts = {};
  int _totalCheckIns = 0;
  int _currentStreak = 0;
  int _maxStreak = 0;
  Map<DateTime, MoodType> _moodCalendar = {};
  List<CheckIn> _recentCheckIns = [];
  Map<DateTime, double> _moodTrendData = {};
  final Map<DateTime, List<CheckIn>> _yearlyCheckIns = {};
  MoodType? _representativeMood;

  String? get profileImage => _userProvider.user?.profileImagePath;

  List<CheckIn> get allCheckIns => _allCheckIns;

  Map<MoodType, int> get moodCounts => _moodCounts;

  int get totalJournals => _totalCheckIns;

  int get currentStreak => _currentStreak;

  MoodType? get representativeMood => _representativeMood;

  int get maxStreak => _maxStreak;

  Map<DateTime, MoodType> get moodCalendar => _moodCalendar;

  List<CheckIn> get recentCheckIns => _recentCheckIns;

  Map<DateTime, List<CheckIn>> get yearlyCheckIns => _yearlyCheckIns;

  Map<DateTime, double> get moodTrendData => _moodTrendData;

  List<CheckIn> get weeklyCheckInsList {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 6));
    final startOfDay = DateTime(sevenDaysAgo.year, sevenDaysAgo.month, sevenDaysAgo.day);
    return _allCheckIns.where((checkIn) => checkIn.createdAt.isAfter(startOfDay) || checkIn.createdAt.isAtSameMomentAs(startOfDay)).toList();
  }

  List<CheckIn> get monthlyCheckInsList {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    return _allCheckIns.where((checkIn) => checkIn.createdAt.isAfter(firstDayOfMonth) || checkIn.createdAt.isAtSameMomentAs(firstDayOfMonth)).toList();
  }

  List<CheckIn> get yearlyCheckInsList {
    final now = DateTime.now();
    return _allCheckIns.where((checkIn) => checkIn.createdAt.year == now.year).toList();
  }

  double get weeklyAverageMood {
    final checkIns = weeklyCheckInsList;
    if (checkIns.isEmpty) return 0;
    return checkIns.map((c) => c.moodType.score).average;
  }

  MoodType? get weeklyMostFrequentMood {
    final checkIns = weeklyCheckInsList;
    if (checkIns.isEmpty) return null;
    final moodCounts = <MoodType, int>{};
    for (var checkIn in checkIns) {
      moodCounts[checkIn.moodType] = (moodCounts[checkIn.moodType] ?? 0) + 1;
    }
    return moodCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  Map<int, int> get weeklyDayPattern {
    final checkIns = weeklyCheckInsList;
    final pattern = <int, int>{};
    for (var i = 1; i <= 7; i++) {
      pattern[i] = 0;
    }
    for (var checkIn in checkIns) {
      final dayOfWeek = checkIn.createdAt.weekday;
      pattern[dayOfWeek] = (pattern[dayOfWeek] ?? 0) + 1;
    }
    return pattern;
  }

  List<String> get weeklyTopEmotions {
    final checkIns = weeklyCheckInsList;
    final emotionCounts = <String, int>{};
    for (var checkIn in checkIns) {
      final emotions = checkIn.emotionNames ?? [];
      for (var emotion in emotions) {
        emotionCounts[emotion] = (emotionCounts[emotion] ?? 0) + 1;
      }
    }
    final sorted = emotionCounts.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    return sorted.take(5).map((e) => e.key).toList();
  }

  int get monthlyCheckInDays {
    final checkIns = monthlyCheckInsList;
    final uniqueDays = <DateTime>{};
    for (var checkIn in checkIns) {
      final date = DateTime(checkIn.createdAt.year, checkIn.createdAt.month, checkIn.createdAt.day);
      uniqueDays.add(date);
    }
    return uniqueDays.length;
  }

  double get monthlyAverageMood {
    final checkIns = monthlyCheckInsList;
    if (checkIns.isEmpty) return 0;
    return checkIns.map((c) => c.moodType.score).average;
  }

  int get monthlyCurrentStreak {
    final checkIns = monthlyCheckInsList.sorted((a, b) => a.createdAt.compareTo(b.createdAt));
    if (checkIns.isEmpty) return 0;

    int streak = 0;
    DateTime? lastDate;

    for (var checkIn in checkIns) {
      final checkInDate = DateTime(checkIn.createdAt.year, checkIn.createdAt.month, checkIn.createdAt.day);
      if (lastDate == null) {
        streak = 1;
      } else {
        final difference = checkInDate.difference(lastDate).inDays;
        if (difference == 1) {
          streak++;
        } else if (difference > 1) {
          streak = 1;
        }
      }
      lastDate = checkInDate;
    }
    return streak;
  }

  double get monthlyVsLastMonth {
    final thisMonth = monthlyAverageMood;
    final now = DateTime.now();
    final lastMonth = DateTime(now.year, now.month - 1, 1);
    final lastMonthCheckIns = _allCheckIns.where((checkIn) {
      return checkIn.createdAt.year == lastMonth.year && checkIn.createdAt.month == lastMonth.month;
    }).toList();

    if (lastMonthCheckIns.isEmpty) return 0;
    final lastMonthAvg = lastMonthCheckIns.map((c) => c.moodType.score).average;
    return thisMonth - lastMonthAvg;
  }

  Map<int, List<CheckIn>> get monthlyWeeklyGroups {
    final checkIns = monthlyCheckInsList;
    final groups = <int, List<CheckIn>>{};

    for (var checkIn in checkIns) {
      final weekOfMonth = ((checkIn.createdAt.day - 1) ~/ 7) + 1;
      groups.putIfAbsent(weekOfMonth, () => []).add(checkIn);
    }
    return groups;
  }

  List<String> get monthlyTopActivities {
    final checkIns = monthlyCheckInsList;
    final activityCounts = <String, int>{};
    for (var checkIn in checkIns) {
      final tags = checkIn.activityNames ?? [];
      for (var activity in tags) {
        activityCounts[activity] = (activityCounts[activity] ?? 0) + 1;
      }
    }
    final sorted = activityCounts.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    return sorted.take(10).map((e) => e.key).toList();
  }

  Map<String, int> get monthlyEmotionDistribution {
    final checkIns = monthlyCheckInsList;
    int positive = 0;
    int neutral = 0;
    int negative = 0;

    for (var checkIn in checkIns) {
      if (checkIn.moodType.score >= 4) {
        positive++;
      } else if (checkIn.moodType.score >= 3) {
        neutral++;
      } else {
        negative++;
      }
    }

    return {'positive': positive, 'neutral': neutral, 'negative': negative};
  }

  int get yearlyTotalCheckIns => yearlyCheckInsList.length;

  double get yearlyAverageMood {
    final checkIns = yearlyCheckInsList;
    if (checkIns.isEmpty) return 0;
    return checkIns.map((c) => c.moodType.score).average;
  }

  String get yearlyBestMonth {
    final monthlyAverages = yearlyMonthlyAverages;
    if (monthlyAverages.isEmpty) return '';
    final bestMonth = monthlyAverages.entries.reduce((a, b) => a.value > b.value ? a : b).key;
    return '$bestMonth';
  }

  String get yearlyWorstMonth {
    final monthlyAverages = yearlyMonthlyAverages;
    if (monthlyAverages.isEmpty) return '';
    final worstMonth = monthlyAverages.entries.reduce((a, b) => a.value < b.value ? a : b).key;
    return '$worstMonth';
  }

  Map<int, double> get yearlyMonthlyAverages {
    final checkIns = yearlyCheckInsList;
    final monthlyGroups = <int, List<CheckIn>>{};

    for (var checkIn in checkIns) {
      monthlyGroups.putIfAbsent(checkIn.createdAt.month, () => []).add(checkIn);
    }

    final averages = <int, double>{};
    monthlyGroups.forEach((month, checkIns) {
      averages[month] = checkIns.map((c) => c.moodType.score).average;
    });

    return averages;
  }

  Map<int, double> get yearlyQuarterAverages {
    final checkIns = yearlyCheckInsList;
    final quarterGroups = <int, List<CheckIn>>{};

    for (var checkIn in checkIns) {
      final quarter = ((checkIn.createdAt.month - 1) ~/ 3) + 1;
      quarterGroups.putIfAbsent(quarter, () => []).add(checkIn);
    }

    final averages = <int, double>{};
    quarterGroups.forEach((quarter, checkIns) {
      averages[quarter] = checkIns.map((c) => c.moodType.score).average;
    });

    return averages;
  }

  List<String> get yearlyTopActivities {
    final checkIns = yearlyCheckInsList;
    final activityCounts = <String, int>{};
    for (var checkIn in checkIns) {
      final tags = checkIn.activityNames ?? [];
      for (var activity in tags) {
        activityCounts[activity] = (activityCounts[activity] ?? 0) + 1;
      }
    }
    final sorted = activityCounts.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    return sorted.take(20).map((e) => e.key).toList();
  }

  Future<void> _loadStatistics() async {
    setLoading();

    final result = await _checkInRepository.getAllCheckIns();
    switch (result) {
      case Ok<List<CheckIn>>():
        _allCheckIns = result.value;
        _totalCheckIns = _allCheckIns.length;
        _calculateMoodCounts();
        _calculateStreak();
        _calculateMoodCalendar();
        _calculateMoodTrend();
        _loadRecentCheckInsAndRepresentativeMood();
        _loadYearlyCheckIns();
        _recentCheckIns = _allCheckIns
            .sorted((a, b) => b.createdAt.compareTo(a.createdAt))
            .take(5)
            .toList();

        AnalyticsRepositoryImpl().logMoodView(
          viewType: 'statistics',
          period: 'all_time',
        );

        setSuccess();
      case Error<List<CheckIn>>():
        debugPrint('Error loading check-ins: ${result.error}');
        setError(result.error);
    }
  }

  void _calculateMoodCounts() {
    _moodCounts = {};
    for (var moodType in MoodType.values) {
      _moodCounts[moodType] = 0;
    }
    for (var checkIn in _allCheckIns) {
      _moodCounts[checkIn.moodType] = (_moodCounts[checkIn.moodType] ?? 0) + 1;
    }
  }

  void _calculateStreak() {
    if (_allCheckIns.isEmpty) {
      _currentStreak = 0;
      _maxStreak = 0;
      return;
    }

    final sortedCheckIns = _allCheckIns.sorted(
      (a, b) => a.createdAt.compareTo(b.createdAt),
    );
    int current = 0;
    int max = 0;
    DateTime? lastDate;

    for (var checkIn in sortedCheckIns) {
      final checkInDate = DateTime(
        checkIn.createdAt.year,
        checkIn.createdAt.month,
        checkIn.createdAt.day,
      );
      if (lastDate == null) {
        current = 1;
      } else {
        final difference = checkInDate.difference(lastDate).inDays;
        if (difference == 1) {
          current++;
        } else if (difference > 1) {
          current = 1;
        }
      }
      lastDate = checkInDate;
      if (current > max) {
        max = current;
      }
    }
    _currentStreak = current;
    _maxStreak = max;
  }

  void _calculateMoodCalendar() {
    _moodCalendar = {};
    final Map<DateTime, List<MoodType>> dailyMoods = {};

    for (var checkIn in _allCheckIns) {
      final date = DateTime(
        checkIn.createdAt.year,
        checkIn.createdAt.month,
        checkIn.createdAt.day,
      );
      dailyMoods.putIfAbsent(date, () => []).add(checkIn.moodType);
    }

    dailyMoods.forEach((date, moods) {
      final averageScore = moods.map((m) => m.score).average;
      MoodType representativeMood = MoodType.neutral;
      if (averageScore >= 4.5) {
        representativeMood = MoodType.veryHappy;
      } else if (averageScore >= 3.5) {
        representativeMood = MoodType.happy;
      } else if (averageScore >= 2.5) {
        representativeMood = MoodType.neutral;
      } else if (averageScore >= 1.5) {
        representativeMood = MoodType.sad;
      } else {
        representativeMood = MoodType.verySad;
      }
      _moodCalendar[date] = representativeMood;
    });
  }

  void _calculateMoodTrend() {
    _moodTrendData = {};
    final Map<DateTime, List<int>> dailyScores = {};

    for (var checkIn in _allCheckIns) {
      final date = DateTime(
        checkIn.createdAt.year,
        checkIn.createdAt.month,
        checkIn.createdAt.day,
      );
      dailyScores.putIfAbsent(date, () => []).add(checkIn.moodType.score);
    }

    dailyScores.forEach((date, scores) {
      _moodTrendData[date] = scores.average;
    });
  }

  Future<void> refreshRepresentativeMood() async {
    await _loadRecentCheckInsAndRepresentativeMood();
  }

  Future<void> _loadRecentCheckInsAndRepresentativeMood() async {
    final result = await _checkInRepository.getAllCheckIns();

    switch (result) {
      case Ok<List<CheckIn>>():
        final allCheckIns = result.value;

        final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
        _recentCheckIns =
            allCheckIns
                .where((checkIn) => checkIn.createdAt.isAfter(thirtyDaysAgo))
                .toList()
              ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

        _calculateRepresentativeMood();
        notifyListeners();

      case Error<List<CheckIn>>():
        debugPrint(
          'Failed to load recent check-ins for representative mood ${result.error}',
        );
        _recentCheckIns = [];
        _representativeMood = null;
        notifyListeners();
    }
  }

  bool isLightColor(Color color) {
    final luminance = color.computeLuminance();
    return luminance > 0.5;
  }

  void _calculateRepresentativeMood() {
    if (_recentCheckIns.isEmpty) {
      _representativeMood = null;
      return;
    }

    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));
    final fourteenDaysAgo = now.subtract(const Duration(days: 14));

    double totalScore = 0;
    int totalWeight = 0;

    for (final checkIn in _recentCheckIns) {
      int weight = 1;

      if (checkIn.createdAt.isAfter(sevenDaysAgo)) {
        weight = 3;
      } else if (checkIn.createdAt.isAfter(fourteenDaysAgo)) {
        weight = 2;
      }

      totalScore += checkIn.moodType.score * weight;
      totalWeight += weight;
    }

    if (totalWeight == 0) {
      _representativeMood = null;
      return;
    }

    final averageScore = totalScore / totalWeight;

    if (averageScore >= 4.5) {
      _representativeMood = MoodType.veryHappy;
    } else if (averageScore >= 3.5) {
      _representativeMood = MoodType.happy;
    } else if (averageScore >= 2.5) {
      _representativeMood = MoodType.neutral;
    } else if (averageScore >= 1.5) {
      _representativeMood = MoodType.sad;
    } else {
      _representativeMood = MoodType.verySad;
    }
  }

  Future<void> _loadYearlyCheckIns() async {
    final now = DateTime.now();
    _yearlyCheckIns.clear();

    final result = await _checkInRepository.getAllCheckIns();
    switch (result) {
      case Ok<List<CheckIn>>():
        for (final checkIn in result.value) {
          if (checkIn.createdAt.year == now.year) {
            final dateKey = DateTime(
              checkIn.createdAt.year,
              checkIn.createdAt.month,
              checkIn.createdAt.day,
            );

            if (_yearlyCheckIns.containsKey(dateKey)) {
              _yearlyCheckIns[dateKey]!.add(checkIn);
            } else {
              _yearlyCheckIns[dateKey] = [checkIn];
            }
          }
        }
        debugPrint('Loaded yearly check-ins: ${_yearlyCheckIns.length} days');
        notifyListeners();

      case Error<List<CheckIn>>():
        debugPrint('Failed to load yearly check-ins');
    }
  }
}
