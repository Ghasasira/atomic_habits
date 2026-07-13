import '../../core/constants/enums.dart';
import '../database/daos/goal_dao.dart';
import '../database/database.dart';

/// Thin persistence layer over [GoalDao] for goals, their deliverables and the
/// metric inputs recorded against them.
class GoalRepository {
  GoalRepository(this._dao);

  final GoalDao _dao;

  // --- Goals --------------------------------------------------------------

  Stream<List<Goal>> watchGoals() => _dao.watchActiveGoals();

  Stream<Goal?> watchGoal(int id) => _dao.watchGoal(id);

  Future<int> createGoal(GoalsCompanion companion) =>
      _dao.createGoal(companion);

  Future<void> updateGoal(Goal goal) => _dao.updateGoal(goal);

  Future<void> deleteGoal(int id) => _dao.deleteGoal(id);

  Future<void> setArchived(int id, bool archived) =>
      _dao.setArchived(id, archived);

  // --- Deliverables -------------------------------------------------------

  Stream<List<Deliverable>> watchDeliverables(int goalId) =>
      _dao.watchDeliverables(goalId);

  Future<int> addDeliverable(DeliverablesCompanion companion) =>
      _dao.addDeliverable(companion);

  Future<void> updateDeliverable(Deliverable deliverable) =>
      _dao.updateDeliverable(deliverable);

  Future<void> deleteDeliverable(int id) => _dao.deleteDeliverable(id);

  // --- Deliverable logs ---------------------------------------------------

  Stream<List<DeliverableLog>> watchLogsForDeliverable(int deliverableId) =>
      _dao.watchLogsForDeliverable(deliverableId);

  Future<void> logDeliverable(
    int deliverableId,
    DateTime day,
    LogStatus status,
    double? inputValue,
  ) =>
      _dao.logDeliverable(deliverableId, day, status, inputValue);

  Future<void> clearDeliverableLog(int deliverableId, DateTime day) =>
      _dao.clearDeliverableLog(deliverableId, day);

  Stream<List<DeliverableLogWithDeliverable>> watchLogsForGoal(int goalId) =>
      _dao.watchLogsForGoal(goalId);
}
