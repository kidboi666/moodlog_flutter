import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../../../common/constants/enum.dart';
import '../../../common/providers/user_provider.dart';
import '../../../common/utils/result.dart';
import '../../../data/repositories/analytics_repository_impl.dart';
import '../../../domain/entities/journal.dart';
import '../../../domain/repositories/journal_repository.dart';

class StatisticsViewModel extends ChangeNotifier {
  final JournalRepository _journalRepository;
  final UserProvider _userProvider;

  StatisticsViewModel({
    required JournalRepository journalRepository,
    required UserProvider userProvider,
  }) : _journalRepository = journalRepository,
       _userProvider = userProvider {
    _loadStatistics();
  }

  List<Journal> _allJournals = [];
  Map<MoodType, int> _moodCounts = {};
  int _totalJournals = 0;
  int _currentStreak = 0;
  int _maxStreak = 0;
  Map<DateTime, MoodType> _moodCalendar = {};
  List<Journal> _recentJournals = [];
  Map<DateTime, double> _moodTrendData = {};

  String? get profileImage => _userProvider.user?.photoURL;

  List<Journal> get allJournals => _allJournals;

  Map<MoodType, int> get moodCounts => _moodCounts;

  int get totalJournals => _totalJournals;

  int get currentStreak => _currentStreak;

  int get maxStreak => _maxStreak;

  Map<DateTime, MoodType> get moodCalendar => _moodCalendar;

  List<Journal> get recentJournals => _recentJournals;

  Map<DateTime, double> get moodTrendData => _moodTrendData;

  Future<void> _loadStatistics() async {
    final result = await _journalRepository.getAllJournals();
    if (result is Ok<List<Journal>>) {
      _allJournals = result.value;
      _totalJournals = _allJournals.length;
      _calculateMoodCounts();
      _calculateStreak();
      _calculateMoodCalendar();
      _calculateMoodTrend();
      _recentJournals = _allJournals
          .sorted((a, b) => b.createdAt.compareTo(a.createdAt))
          .take(5)
          .toList();

      AnalyticsRepositoryImpl().logMoodView(
        viewType: 'statistics',
        period: 'all_time',
      );

      notifyListeners();
    } else if (result is Failure<List<Journal>>) {
      debugPrint('Error loading journals: ${result.error}');
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
}
