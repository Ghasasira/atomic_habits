import '../../core/constants/enums.dart';
import '../../services/notification_service.dart';
import '../database/daos/habit_dao.dart';
import '../database/database.dart';

/// Coordinates habit persistence (via [HabitDao]) with reminder scheduling
/// (via [NotificationService]) so callers deal with one habit-shaped API.
class HabitRepository {
  HabitRepository(this._dao, this._notifications);

  final HabitDao _dao;
  final NotificationService _notifications;

  // --- Reads --------------------------------------------------------------

  Stream<List<Habit>> watchHabits() => _dao.watchActiveHabits();

  Stream<List<HabitLog>> watchLogsForDay(DateTime day) =>
      _dao.watchLogsForDay(day);

  Stream<List<HabitLog>> watchLogsInRange(DateTime start, DateTime end) =>
      _dao.watchLogsInRange(start, end);

  Future<List<HabitLog>> logsForHabit(int habitId) =>
      _dao.logsForHabit(habitId);

  // --- Writes -------------------------------------------------------------

  Future<Habit?> createHabit(HabitsCompanion companion) async {
    final id = await _dao.createHabit(companion);
    final habit = await _dao.findHabit(id);
    if (habit != null) await _schedule(habit);
    return habit;
  }

  Future<void> updateHabit(Habit habit) async {
    await _dao.updateHabit(habit);
    await _schedule(habit);
  }

  Future<void> deleteHabit(int habitId) async {
    await _notifications.cancelHabit(habitId);
    await _dao.deleteHabit(habitId);
  }

  Future<void> setArchived(int habitId, bool archived) async {
    await _dao.setArchived(habitId, archived);
    if (archived) {
      await _notifications.cancelHabit(habitId);
    } else {
      final habit = await _dao.findHabit(habitId);
      if (habit != null) await _schedule(habit);
    }
  }

  Future<void> logHabit(int habitId, DateTime day, LogStatus status) =>
      _dao.setLog(habitId, day, status);

  Future<void> clearLog(int habitId, DateTime day) =>
      _dao.clearLog(habitId, day);

  /// Re-arms reminders for every active habit. Called on app start so that
  /// one-shot (interval) alarms and post-reboot schedules stay fresh.
  Future<void> rescheduleAll() async {
    final habits = await _dao.watchActiveHabits().first;
    for (final habit in habits) {
      await _schedule(habit);
    }
  }

  Future<void> _schedule(Habit habit) {
    return _notifications.scheduleHabit(
      habitId: habit.id,
      name: habit.name,
      hour: habit.targetHour,
      minute: habit.targetMinute,
      frequency: habit.frequency,
      weekdaysMask: habit.weekdaysMask,
      intervalDays: habit.intervalDays,
      anchorDate: habit.createdAt,
      enabled: habit.reminderEnabled,
    );
  }
}
