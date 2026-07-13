import 'package:drift/drift.dart';

import '../../../core/constants/enums.dart';
import '../../../core/utils/date_x.dart';
import '../database.dart';
import '../tables.dart';

part 'habit_dao.g.dart';

@DriftAccessor(tables: [Habits, HabitLogs])
class HabitDao extends DatabaseAccessor<AppDatabase> with _$HabitDaoMixin {
  HabitDao(super.db);

  // --- Habits -------------------------------------------------------------

  Stream<List<Habit>> watchActiveHabits() {
    return (select(habits)
          ..where((h) => h.isArchived.equals(false))
          ..orderBy([
            (h) => OrderingTerm(expression: h.targetHour),
            (h) => OrderingTerm(expression: h.targetMinute),
          ]))
        .watch();
  }

  Future<Habit?> findHabit(int id) =>
      (select(habits)..where((h) => h.id.equals(id))).getSingleOrNull();

  Future<int> createHabit(HabitsCompanion habit) =>
      into(habits).insert(habit);

  Future<bool> updateHabit(Habit habit) => update(habits).replace(habit);

  Future<void> setArchived(int id, bool archived) {
    return (update(habits)..where((h) => h.id.equals(id)))
        .write(HabitsCompanion(isArchived: Value(archived)));
  }

  Future<int> deleteHabit(int id) =>
      (delete(habits)..where((h) => h.id.equals(id))).go();

  // --- Habit logs ---------------------------------------------------------

  /// Logs recorded on a specific calendar day.
  Stream<List<HabitLog>> watchLogsForDay(DateTime day) {
    final d = day.dateOnly;
    return (select(habitLogs)..where((l) => l.date.equals(d))).watch();
  }

  /// Logs within [start, end) — used to colour-code the calendar.
  Stream<List<HabitLog>> watchLogsInRange(DateTime start, DateTime end) {
    return (select(habitLogs)
          ..where((l) => l.date.isBetweenValues(start.dateOnly, end.dateOnly)))
        .watch();
  }

  Future<List<HabitLog>> logsForHabit(int habitId) {
    return (select(habitLogs)
          ..where((l) => l.habitId.equals(habitId))
          ..orderBy([(l) => OrderingTerm(expression: l.date)]))
        .get();
  }

  /// Insert or update the status for a habit on a given day (FR-2.2 / FR-3.2).
  ///
  /// The upsert targets the `(habitId, date)` unique index explicitly — the
  /// default conflict target is the primary key, which would never match here
  /// (each insert gets a fresh auto-increment id) and would throw instead.
  Future<void> setLog(int habitId, DateTime day, LogStatus status) {
    return into(habitLogs).insert(
      HabitLogsCompanion.insert(
        habitId: habitId,
        date: day.dateOnly,
        status: status,
        loggedAt: Value(DateTime.now()),
      ),
      onConflict: DoUpdate(
        (_) => HabitLogsCompanion(
          status: Value(status),
          loggedAt: Value(DateTime.now()),
        ),
        target: [habitLogs.habitId, habitLogs.date],
      ),
    );
  }

  /// Clears a recorded status (returns the day to "pending").
  Future<int> clearLog(int habitId, DateTime day) {
    final d = day.dateOnly;
    return (delete(habitLogs)
          ..where((l) => l.habitId.equals(habitId) & l.date.equals(d)))
        .go();
  }
}
