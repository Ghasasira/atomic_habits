import 'dart:async';

import 'package:flutter/foundation.dart';

import '../core/constants/enums.dart';
import '../core/utils/date_x.dart';
import '../data/database/database.dart';
import '../data/repositories/habit_repository.dart';

/// Completion figures for a single day, used by the trend chart.
class DailyAdherence {
  const DailyAdherence(this.date, this.due, this.accomplished);
  final DateTime date;
  final int due;
  final int accomplished;
  double get ratio => due == 0 ? 0 : accomplished / due;
}

/// Streak + adherence summary for one habit.
class HabitStreak {
  const HabitStreak(this.habit, this.currentStreak, this.completionRate);
  final Habit habit;
  final int currentStreak;
  final double completionRate; // over the analysis window
}

/// Aggregates habit logs into the analytics shown on the dashboard (FR-6.1):
/// streaks, weekly completion percentage and a rolling trend.
class DashboardProvider extends ChangeNotifier {
  DashboardProvider(this._repo) {
    _habitsSub = _repo.watchHabits().listen((habits) {
      _habits = habits;
      notifyListeners();
    });
    final now = DateTime.now().dateOnly;
    _logsSub = _repo
        .watchLogsInRange(
          now.subtract(const Duration(days: _windowDays)),
          now.add(const Duration(days: 1)),
        )
        .listen((logs) {
      final byHabit = <int, Map<DateTime, LogStatus>>{};
      for (final log in logs) {
        byHabit.putIfAbsent(log.habitId, () => {})[log.date.dateOnly] =
            log.status;
      }
      _logsByHabit = byHabit;
      _loading = false;
      notifyListeners();
    });
  }

  static const int _windowDays = 370;

  final HabitRepository _repo;
  StreamSubscription<List<Habit>>? _habitsSub;
  StreamSubscription<List<HabitLog>>? _logsSub;

  List<Habit> _habits = const [];
  Map<int, Map<DateTime, LogStatus>> _logsByHabit = const {};
  bool _loading = true;

  bool get isLoading => _loading;
  List<Habit> get habits => _habits;
  int get activeHabitCount => _habits.length;

  bool _due(Habit h, DateTime day) => isDueOn(
        frequency: h.frequency,
        day: day,
        weekdaysMask: h.weekdaysMask,
        intervalDays: h.intervalDays,
        anchorDate: h.createdAt,
      );

  /// Per-day accomplished-vs-due totals for the last [days] days (oldest first).
  List<DailyAdherence> trend({int days = 7}) {
    final today = DateTime.now().dateOnly;
    final result = <DailyAdherence>[];
    for (var i = days - 1; i >= 0; i--) {
      final day = today.subtract(Duration(days: i));
      var due = 0;
      var done = 0;
      for (final habit in _habits) {
        if (!_due(habit, day)) continue;
        due++;
        if (_logsByHabit[habit.id]?[day]?.isAccomplished ?? false) done++;
      }
      result.add(DailyAdherence(day, due, done));
    }
    return result;
  }

  /// Accomplished / due across the last [days] days.
  double completionRate({int days = 7}) {
    var due = 0;
    var done = 0;
    for (final day in trend(days: days)) {
      due += day.due;
      done += day.accomplished;
    }
    return due == 0 ? 0 : done / due;
  }

  double get weeklyCompletionRate => completionRate(days: 7);
  double get monthlyCompletionRate => completionRate(days: 30);

  /// Current consecutive-day streak for [habit]. A still-pending "today" does
  /// not break the streak.
  int currentStreak(Habit habit) {
    final logs = _logsByHabit[habit.id] ?? const {};
    final today = DateTime.now().dateOnly;
    var streak = 0;
    var day = today;
    for (var i = 0; i <= _windowDays; i++) {
      if (_due(habit, day)) {
        final status = logs[day];
        if (status?.isAccomplished ?? false) {
          streak++;
        } else if (day == today && status == null) {
          // Today not logged yet — keep looking back without breaking.
        } else {
          break;
        }
      }
      day = day.subtract(const Duration(days: 1));
    }
    return streak;
  }

  double _habitCompletion(Habit habit, {int days = 30}) {
    final today = DateTime.now().dateOnly;
    final logs = _logsByHabit[habit.id] ?? const {};
    var due = 0;
    var done = 0;
    for (var i = 0; i < days; i++) {
      final day = today.subtract(Duration(days: i));
      if (!_due(habit, day)) continue;
      due++;
      if (logs[day]?.isAccomplished ?? false) done++;
    }
    return due == 0 ? 0 : done / due;
  }

  /// Per-habit streak cards, sorted by longest current streak.
  List<HabitStreak> get habitStreaks {
    final list = _habits
        .map((h) => HabitStreak(h, currentStreak(h), _habitCompletion(h)))
        .toList()
      ..sort((a, b) => b.currentStreak.compareTo(a.currentStreak));
    return list;
  }

  int get bestStreak =>
      habitStreaks.fold(0, (max, s) => s.currentStreak > max ? s.currentStreak : max);

  @override
  void dispose() {
    _habitsSub?.cancel();
    _logsSub?.cancel();
    super.dispose();
  }
}
