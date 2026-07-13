import 'dart:async';

import 'package:flutter/foundation.dart';

import '../core/constants/enums.dart';
import '../core/utils/date_x.dart';
import '../data/database/database.dart';
import '../data/repositories/habit_repository.dart';

/// View-model for the day-oriented habit tracker screen. Keeps a live snapshot
/// of the active habits and the log statuses for the currently selected day.
class HabitProvider extends ChangeNotifier {
  HabitProvider(this._repo) {
    _habitsSub = _repo.watchHabits().listen(_onHabits);
    _subscribeLogs();
  }

  final HabitRepository _repo;

  StreamSubscription<List<Habit>>? _habitsSub;
  StreamSubscription<List<HabitLog>>? _logsSub;

  List<Habit> _habits = const [];
  Map<int, HabitLog> _logsByHabit = const {};
  DateTime _selectedDay = DateTime.now().dateOnly;
  bool _loading = true;

  bool get isLoading => _loading;
  DateTime get selectedDay => _selectedDay;
  List<Habit> get habits => _habits;

  /// Habits scheduled to occur on [selectedDay].
  List<Habit> get habitsForSelectedDay => _habits
      .where((h) => isDueOn(
            frequency: h.frequency,
            day: _selectedDay,
            weekdaysMask: h.weekdaysMask,
            intervalDays: h.intervalDays,
            anchorDate: h.createdAt,
          ))
      .toList();

  LogStatus? statusFor(int habitId) => _logsByHabit[habitId]?.status;

  int get completedCount => habitsForSelectedDay
      .where((h) => statusFor(h.id)?.isAccomplished ?? false)
      .length;

  void _onHabits(List<Habit> habits) {
    _habits = habits;
    _loading = false;
    notifyListeners();
  }

  void _subscribeLogs() {
    _logsSub?.cancel();
    _logsSub = _repo.watchLogsForDay(_selectedDay).listen((logs) {
      _logsByHabit = {for (final log in logs) log.habitId: log};
      notifyListeners();
    });
  }

  void selectDay(DateTime day) {
    final normalised = day.dateOnly;
    if (normalised == _selectedDay) return;
    _selectedDay = normalised;
    _subscribeLogs();
    notifyListeners();
  }

  // --- Actions ------------------------------------------------------------

  Future<void> setStatus(int habitId, LogStatus status) async {
    // Tapping the active status again clears it back to "pending".
    if (statusFor(habitId) == status) {
      await _repo.clearLog(habitId, _selectedDay);
    } else {
      await _repo.logHabit(habitId, _selectedDay, status);
    }
  }

  Future<Habit?> createHabit(HabitsCompanion companion) =>
      _repo.createHabit(companion);

  Future<void> updateHabit(Habit habit) => _repo.updateHabit(habit);

  Future<void> deleteHabit(int habitId) => _repo.deleteHabit(habitId);

  Future<void> archiveHabit(int habitId) => _repo.setArchived(habitId, true);

  @override
  void dispose() {
    _habitsSub?.cancel();
    _logsSub?.cancel();
    super.dispose();
  }
}
