import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import '../../../core/constants/enum.dart';
import '../../../core/mixins/async_state_mixin.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/utils/result.dart';
import '../../../data/repositories/analytics_repository_impl.dart';
import '../../../domain/entities/journal.dart';
import '../../../domain/repositories/journal_repository.dart';

class StatisticsViewModel extends ChangeNotifier with AsyncStateMixin {
  final JournalRepository _journalRepository;
  final UserProvider _userProvider;

  StatisticsViewModel({
    required JournalRepository journalRepository,
    required UserProvider userProvider,
  }) : _journalRepository = journalRepository,
       _userProvider = userProvider {
    _loadStatistics();
  }

  final Logger _log = Logger('StatisticsViewModel');
  List<Journal> _allJournals = [];
  Map<MoodType, int> _moodCounts = {};
  int _totalJournals = 0;
  int _currentStreak = 0;
  int _maxStreak = 0;
  Map<DateTime, MoodType> _moodCalendar = {};
  List<Journal> _recentJournals = [];
  Map<DateTime, double> _moodTrendData = {};
  final Map<DateTime, List<Journal>> _yearlyJournals = {};
  MoodType? _representativeMood;

  String? get profileImage => _userProvider.user?.photoURL;

  List<Journal> get allJournals => _allJournals;

  Map<MoodType, int> get moodCounts => _moodCounts;

  int get totalJournals => _totalJournals;

  int get currentStreak => _currentStreak;
  MoodType? get representativeMood => _representativeMood;

  int get maxStreak => _maxStreak;

  Map<DateTime, MoodType> get moodCalendar => _moodCalendar;

  List<Journal> get recentJournals => _recentJournals;

  Map<DateTime, List<Journal>> get yearlyJournals => _yearlyJournals;

  Map<DateTime, double> get moodTrendData => _moodTrendData;

  Future<void> _loadStatistics() async {
    setLoading();

    final result = await _journalRepository.getAllJournals();
    switch (result) {
      case Ok<List<Journal>>():
        _allJournals = result.value;
        _totalJournals = _allJournals.length;
        _calculateMoodCounts();
        _calculateStreak();
        _calculateMoodCalendar();
        _calculateMoodTrend();
        _loadRecentJournalsAndRepresentativeMood();
        _loadYearlyJournals();
        _recentJournals = _allJournals
            .sorted((a, b) => b.createdAt.compareTo(a.createdAt))
            .take(5)
            .toList();

        AnalyticsRepositoryImpl().logMoodView(
          viewType: 'statistics',
          period: 'all_time',
        );

        setSuccess();
      case Failure<List<Journal>>():
        debugPrint('Error loading journals: ${result.error}');
        setError(result.error);
    }
  }

  void _calculateMoodCounts() {
    _moodCounts = {};
    for (var moodType in MoodType.values) {
      _moodCounts[moodType] = 0;
    }
    for (var journal in _allJournals) {
      _moodCounts[journal.moodType] = (_moodCounts[journal.moodType] ?? 0) + 1;
    }
  }

  void _calculateStreak() {
    if (_allJournals.isEmpty) {
      _currentStreak = 0;
      _maxStreak = 0;
      return;
    }

    final sortedJournals = _allJournals.sorted(
      (a, b) => a.createdAt.compareTo(b.createdAt),
    );
    int current = 0;
    int max = 0;
    DateTime? lastDate;

    for (var journal in sortedJournals) {
      final journalDate = DateTime(
        journal.createdAt.year,
        journal.createdAt.month,
        journal.createdAt.day,
      );
      if (lastDate == null) {
        current = 1;
      } else {
        final difference = journalDate.difference(lastDate).inDays;
        if (difference == 1) {
          current++;
        } else if (difference > 1) {
          current = 1;
        }
      }
      lastDate = journalDate;
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

    for (var journal in _allJournals) {
      final date = DateTime(
        journal.createdAt.year,
        journal.createdAt.month,
        journal.createdAt.day,
      );
      dailyMoods.putIfAbsent(date, () => []).add(journal.moodType);
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

    for (var journal in _allJournals) {
      final date = DateTime(
        journal.createdAt.year,
        journal.createdAt.month,
        journal.createdAt.day,
      );
      dailyScores.putIfAbsent(date, () => []).add(journal.moodType.score);
    }

    dailyScores.forEach((date, scores) {
      _moodTrendData[date] = scores.average;
    });
  }

  Future<void> refreshRepresentativeMood() async {
    await _loadRecentJournalsAndRepresentativeMood();
  }

  Future<void> _loadRecentJournalsAndRepresentativeMood() async {
    final result = await _journalRepository.getAllJournals();

    switch (result) {
      case Ok<List<Journal>>():
        final allJournals = result.value;

        // 최근 30일 일기만 가져오기
        final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
        _recentJournals =
            allJournals
                .where((journal) => journal.createdAt.isAfter(thirtyDaysAgo))
                .toList()
              ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

        // 대표 감정 계산
        _calculateRepresentativeMood();
        notifyListeners();

      case Failure<List<Journal>>():
        _log.warning(
          'Failed to load recent journals for representative mood',
          result.error,
        );
        _recentJournals = [];
        _representativeMood = null;
        notifyListeners();
    }
  }

  bool isLightColor(Color color) {
    final luminance = color.computeLuminance();
    return luminance > 0.5;
  }

  void _calculateRepresentativeMood() {
    if (_recentJournals.isEmpty) {
      _representativeMood = null;
      return;
    }

    // 최근 7일 일기에 더 높은 가중치 적용
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));
    final fourteenDaysAgo = now.subtract(const Duration(days: 14));

    double totalScore = 0;
    int totalWeight = 0;

    for (final journal in _recentJournals) {
      int weight = 1;

      // 가중치 적용 (최근일수록 높은 가중치)
      if (journal.createdAt.isAfter(sevenDaysAgo)) {
        weight = 3; // 최근 7일: 가중치 3
      } else if (journal.createdAt.isAfter(fourteenDaysAgo)) {
        weight = 2; // 7-14일: 가중치 2
      }
      // 14-30일: 가중치 1 (기본값)

      totalScore += journal.moodType.score * weight;
      totalWeight += weight;
    }

    if (totalWeight == 0) {
      _representativeMood = null;
      return;
    }

    final averageScore = totalScore / totalWeight;

    // 평균 점수를 기반으로 대표 감정 결정
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

  Future<void> _loadYearlyJournals() async {
    final now = DateTime.now();

    // 올해 전체 데이터를 로드하기 위해 각 월별로 호출
    _yearlyJournals.clear();

    for (int month = 1; month <= 12; month++) {
      final monthDate = DateTime(now.year, month, 1);
      final result = await _journalRepository.getJournalsByMonth(monthDate);

      switch (result) {
        case Ok<List<Journal>>():
          // 날짜별로 일기들을 그룹화하여 연간 맵에 추가
          for (final journal in result.value) {
            final dateKey = DateTime(
              journal.createdAt.year,
              journal.createdAt.month,
              journal.createdAt.day,
            );

            if (_yearlyJournals.containsKey(dateKey)) {
              _yearlyJournals[dateKey]!.add(journal);
            } else {
              _yearlyJournals[dateKey] = [journal];
            }
          }
        case Failure<List<Journal>>():
          _log.warning(
            'Failed to load journals for month $month',
            result.error,
          );
      }
    }

    _log.fine('Loaded yearly journals: ${_yearlyJournals.length} days');
    notifyListeners();
  }
}
