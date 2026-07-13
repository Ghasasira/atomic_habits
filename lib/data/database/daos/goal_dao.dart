import 'package:drift/drift.dart';

import '../../../core/constants/enums.dart';
import '../../../core/utils/date_x.dart';
import '../database.dart';
import '../tables.dart';

part 'goal_dao.g.dart';

@DriftAccessor(tables: [Goals, Deliverables, DeliverableLogs])
class GoalDao extends DatabaseAccessor<AppDatabase> with _$GoalDaoMixin {
  GoalDao(super.db);

  // --- Goals --------------------------------------------------------------

  Stream<List<Goal>> watchActiveGoals() {
    return (select(goals)
          ..where((g) => g.isArchived.equals(false))
          ..orderBy([(g) => OrderingTerm(expression: g.endDate)]))
        .watch();
  }

  Future<Goal?> findGoal(int id) =>
      (select(goals)..where((g) => g.id.equals(id))).getSingleOrNull();

  Stream<Goal?> watchGoal(int id) =>
      (select(goals)..where((g) => g.id.equals(id))).watchSingleOrNull();

  Future<int> createGoal(GoalsCompanion goal) => into(goals).insert(goal);

  Future<bool> updateGoal(Goal goal) => update(goals).replace(goal);

  Future<void> setArchived(int id, bool archived) {
    return (update(goals)..where((g) => g.id.equals(id)))
        .write(GoalsCompanion(isArchived: Value(archived)));
  }

  Future<int> deleteGoal(int id) =>
      (delete(goals)..where((g) => g.id.equals(id))).go();

  // --- Deliverables -------------------------------------------------------

  Stream<List<Deliverable>> watchDeliverables(int goalId) {
    return (select(deliverables)
          ..where((d) => d.goalId.equals(goalId))
          ..orderBy([(d) => OrderingTerm(expression: d.createdAt)]))
        .watch();
  }

  Future<int> addDeliverable(DeliverablesCompanion deliverable) =>
      into(deliverables).insert(deliverable);

  Future<bool> updateDeliverable(Deliverable deliverable) =>
      update(deliverables).replace(deliverable);

  Future<int> deleteDeliverable(int id) =>
      (delete(deliverables)..where((d) => d.id.equals(id))).go();

  // --- Deliverable logs ---------------------------------------------------

  Stream<List<DeliverableLog>> watchLogsForDeliverable(int deliverableId) {
    return (select(deliverableLogs)
          ..where((l) => l.deliverableId.equals(deliverableId))
          ..orderBy([(l) => OrderingTerm(expression: l.date)]))
        .watch();
  }

  /// Records completion of a deliverable and its metric input (FR-5.1/5.2).
  ///
  /// Upsert targets the `(deliverableId, date)` unique index explicitly (see
  /// `HabitDao.setLog` for why the default PK target is wrong here).
  Future<void> logDeliverable(
    int deliverableId,
    DateTime day,
    LogStatus status,
    double? inputValue,
  ) {
    return into(deliverableLogs).insert(
      DeliverableLogsCompanion.insert(
        deliverableId: deliverableId,
        date: day.dateOnly,
        status: status,
        inputValue: Value(inputValue),
        loggedAt: Value(DateTime.now()),
      ),
      onConflict: DoUpdate(
        (_) => DeliverableLogsCompanion(
          status: Value(status),
          inputValue: Value(inputValue),
          loggedAt: Value(DateTime.now()),
        ),
        target: [deliverableLogs.deliverableId, deliverableLogs.date],
      ),
    );
  }

  Future<int> clearDeliverableLog(int deliverableId, DateTime day) {
    final d = day.dateOnly;
    return (delete(deliverableLogs)
          ..where(
              (l) => l.deliverableId.equals(deliverableId) & l.date.equals(d)))
        .go();
  }

  /// All metric inputs recorded across every deliverable of [goalId], joined
  /// so the dashboard can map progress against the goal target (FR-6.2 /
  /// NFR-3.2 relational query).
  Stream<List<DeliverableLogWithDeliverable>> watchLogsForGoal(int goalId) {
    final query = select(deliverableLogs).join([
      innerJoin(
        deliverables,
        deliverables.id.equalsExp(deliverableLogs.deliverableId),
      ),
    ])
      ..where(deliverables.goalId.equals(goalId))
      ..orderBy([OrderingTerm(expression: deliverableLogs.date)]);

    return query.watch().map((rows) {
      return rows
          .map((row) => DeliverableLogWithDeliverable(
                log: row.readTable(deliverableLogs),
                deliverable: row.readTable(deliverables),
              ))
          .toList();
    });
  }
}

/// A deliverable log paired with the deliverable it belongs to.
class DeliverableLogWithDeliverable {
  DeliverableLogWithDeliverable({required this.log, required this.deliverable});

  final DeliverableLog log;
  final Deliverable deliverable;
}
