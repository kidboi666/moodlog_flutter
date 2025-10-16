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
