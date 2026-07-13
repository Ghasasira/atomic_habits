import 'dart:async';

import 'package:flutter/foundation.dart';

import '../core/constants/enums.dart';
import '../data/database/database.dart';
import '../data/database/daos/goal_dao.dart';
import '../data/repositories/goal_repository.dart';

/// View-model for the goals list. Individual goal detail screens read the
/// repository's streams directly for their deliverables and logs.
class GoalProvider extends ChangeNotifier {
  GoalProvider(this._repo) {
    _goalsSub = _repo.watchGoals().listen((goals) {
      _goals = goals;
      _loading = false;
      notifyListeners();
    });
  }

  final GoalRepository _repo;
  StreamSubscription<List<Goal>>? _goalsSub;

  List<Goal> _goals = const [];
  bool _loading = true;

  List<Goal> get goals => _goals;
  bool get isLoading => _loading;

  GoalRepository get repository => _repo;

  Future<int> createGoal(GoalsCompanion companion) =>
      _repo.createGoal(companion);

  Future<void> updateGoal(Goal goal) => _repo.updateGoal(goal);

  Future<void> deleteGoal(int id) => _repo.deleteGoal(id);

  Future<void> archiveGoal(int id) => _repo.setArchived(id, true);

  Future<int> addDeliverable(DeliverablesCompanion companion) =>
      _repo.addDeliverable(companion);

  Future<void> updateDeliverable(Deliverable deliverable) =>
      _repo.updateDeliverable(deliverable);

  Future<void> deleteDeliverable(int id) => _repo.deleteDeliverable(id);

  Future<void> logDeliverable(
    int deliverableId,
    DateTime day,
    LogStatus status,
    double? inputValue,
  ) =>
      _repo.logDeliverable(deliverableId, day, status, inputValue);

  Stream<List<Deliverable>> watchDeliverables(int goalId) =>
      _repo.watchDeliverables(goalId);

  Stream<List<DeliverableLogWithDeliverable>> watchLogsForGoal(int goalId) =>
      _repo.watchLogsForGoal(goalId);

  Stream<List<DeliverableLog>> watchLogsForDeliverable(int deliverableId) =>
      _repo.watchLogsForDeliverable(deliverableId);

  @override
  void dispose() {
    _goalsSub?.cancel();
    super.dispose();
  }
}
