import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../../core/constants/enums.dart';
import 'daos/goal_dao.dart';
import 'daos/habit_dao.dart';
import 'tables.dart';

part 'database.g.dart';

/// The single local SQLite database backing the whole app (NFR-2.1: all data
/// stays on-device). Access to the tables is grouped into DAOs.
@DriftDatabase(
  tables: [Habits, HabitLogs, Goals, Deliverables, DeliverableLogs],
  daos: [HabitDao, GoalDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// In-memory / custom executor constructor, used by tests.
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        beforeOpen: (details) async {
          // Enforce the foreign-key relations (cascade deletes of logs).
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}

QueryExecutor _openConnection() {
  return driftDatabase(name: 'atomic_habits');
}
