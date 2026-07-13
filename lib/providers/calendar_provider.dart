import 'dart:async';

import 'package:flutter/foundation.dart';

import '../core/constants/enums.dart';
import '../core/utils/date_x.dart';
import '../data/database/database.dart';
import '../data/repositories/habit_repository.dart';

/// Completion tally for a single calendar day.
class DayCompletion {
  const DayCompletion({
    this.due = 0,
    this.accomplished = 0,
    this.skipped = 0,
  });

  final int due;
  final int accomplished;
  final int skipped;

  int get pending => (due - accomplished - skipped).clamp(0, due);
  double get ratio => due == 0 ? 0 : accomplished / due;
  bool get isComplete => due > 0 && accomplished >= due;
  bool get isPartial => accomplished > 0 && !isComplete;
  bool get hasAnyLog => accomplished > 0 || skipped > 0;
}

/// Backs the calendar screen (FR-3.1): resolves, for every visible day, how
/// many scheduled habits were accomplished/skipped so days can be colour-coded.
class CalendarProvider extends ChangeNotifier {
  CalendarProvider(this._repo) {
    _habitsSub = _repo.watchHabits().listen((habits) {
      _habits = habits;
      notifyListeners();
    });
    _focusedMonth = DateTime.now().dateOnly;
    _selectedDay = DateTime.now().dateOnly;
    _subscribeLogs();
  }

  final HabitRepository _repo;

  StreamSubscription<List<Habit>>? _habitsSub;
  StreamSubscription<List<HabitLog>>? _logsSub;

  List<Habit> _habits = const [];
  // date -> (habitId -> log)
  Map<DateTime, Map<int, HabitLog>> _logs = const {};
  late DateTime _focusedMonth;
  late DateTime _selectedDay;

  DateTime get focusedMonth => _focusedMonth;
  DateTime get selectedDay => _selectedDay;
  List<Habit> get habits => _habits;

  void _subscribeLogs() {
    final start = DateTime(_focusedMonth.year, _focusedMonth.month, 1)
        .subtract(const Duration(days: 7));
    final end = DateTime(_focusedMonth.year, _focusedMonth.month + 1, 0)
        .add(const Duration(days: 7));
    _logsSub?.cancel();
    _logsSub = _repo.watchLogsInRange(start, end).listen((logs) {
      final grouped = <DateTime, Map<int, HabitLog>>{};
      for (final log in logs) {
        grouped.putIfAbsent(log.date.dateOnly, () => {})[log.habitId] = log;
      }
      _logs = grouped;
      notifyListeners();
    });
  }

  int _dueCountOn(DateTime day) => _habits
      .where((h) => isDueOn(
            frequency: h.frequency,
            day: day,
            weekdaysMask: h.weekdaysMask,
            intervalDays: h.intervalDays,
            anchorDate: h.createdAt,
          ))
      .length;

  /// Aggregated completion for [day] used to colour the calendar cell.
  DayCompletion completionFor(DateTime day) {
    final d = day.dateOnly;
    final due = _dueCountOn(d);
    final dayLogs = _logs[d];
    if (dayLogs == null || dayLogs.isEmpty) {
      return DayCompletion(due: due);
    }
    var accomplished = 0;
    var skipped = 0;
    for (final log in dayLogs.values) {
      if (log.status.isAccomplished) {
        accomplished++;
      } else {
        skipped++;
      }
    }
    return DayCompletion(due: due, accomplished: accomplished, skipped: skipped);
  }

  /// Habits scheduled on [day] paired with their recorded status (if any).
  List<({Habit habit, LogStatus? status})> habitsOn(DateTime day) {
    final d = day.dateOnly;
    final dayLogs = _logs[d] ?? const {};
    return _habits
        .where((h) => isDueOn(
              frequency: h.frequency,
              day: d,
              weekdaysMask: h.weekdaysMask,
              intervalDays: h.intervalDays,
              anchorDate: h.createdAt,
            ))
        .map((h) => (habit: h, status: dayLogs[h.id]?.status))
        .toList();
  }

  void selectDay(DateTime day) {
    _selectedDay = day.dateOnly;
    notifyListeners();
  }

  void focusMonth(DateTime month) {
    if (month.year == _focusedMonth.year &&
        month.month == _focusedMonth.month) {
      return;
    }
    _focusedMonth = month.dateOnly;
    _subscribeLogs();
    notifyListeners();
  }

  Future<void> setStatus(int habitId, DateTime day, LogStatus status) async {
    final current = _logs[day.dateOnly]?[habitId]?.status;
    if (current == status) {
      await _repo.clearLog(habitId, day);
    } else {
      await _repo.logHabit(habitId, day, status);
    }
  }

  @override
  void dispose() {
    _habitsSub?.cancel();
    _logsSub?.cancel();
    super.dispose();
  }
}
