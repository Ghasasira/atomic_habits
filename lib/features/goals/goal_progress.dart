import '../../core/constants/enums.dart';
import '../../data/database/daos/goal_dao.dart';
import '../../data/database/database.dart';

/// Derived progress for a goal, computed from its deliverable logs. The metric
/// ratio maps the latest recorded input between the goal's start and target
/// (FR-6.2), and works whether the target is higher (e.g. save money) or lower
/// (e.g. lose weight) than the start.
class GoalProgress {
  const GoalProgress({
    required this.metricRatio,
    required this.currentValue,
    required this.accomplishedCount,
    required this.totalLogs,
  });

  final double metricRatio; // 0..1
  final double? currentValue; // latest recorded metric, if any
  final int accomplishedCount;
  final int totalLogs;

  double get adherenceRatio =>
      totalLogs == 0 ? 0 : accomplishedCount / totalLogs;
}

GoalProgress computeGoalProgress(
  Goal goal,
  List<DeliverableLogWithDeliverable> logs,
) {
  final accomplished = logs.where((l) => l.log.status.isAccomplished).toList();
  final withMetric =
      accomplished.where((l) => l.log.inputValue != null).toList();

  double? current;
  if (withMetric.isNotEmpty) {
    final latest = withMetric.reduce(
      (a, b) => a.log.date.isAfter(b.log.date) ? a : b,
    );
    current = latest.log.inputValue;
  }

  double ratio = 0;
  if (current != null) {
    final span = goal.targetValue - goal.startValue;
    if (span == 0) {
      ratio = current >= goal.targetValue ? 1 : 0;
    } else {
      ratio = ((current - goal.startValue) / span).clamp(0.0, 1.0);
    }
  }

  return GoalProgress(
    metricRatio: ratio,
    currentValue: current,
    accomplishedCount: accomplished.length,
    totalLogs: logs.length,
  );
}

/// Fraction of the goal's timeline that has elapsed (0..1).
double timelineProgress(Goal goal, DateTime now) {
  final total = goal.endDate.difference(goal.startDate).inSeconds;
  if (total <= 0) return 1;
  final elapsed = now.difference(goal.startDate).inSeconds;
  return (elapsed / total).clamp(0.0, 1.0);
}
