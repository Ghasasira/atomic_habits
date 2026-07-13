import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/format.dart';
import '../../data/database/daos/goal_dao.dart';
import '../../data/database/database.dart';
import '../../providers/goal_provider.dart';
import '../shared/empty_state.dart';
import 'goal_detail_screen.dart';
import 'goal_form_screen.dart';
import 'goal_progress.dart';

/// Goals module list (FR-4.1): every active long-term goal with a snapshot of
/// its metric progress toward the target.
class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Goals')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(context),
        icon: const Icon(Icons.add),
        label: const Text('Goal'),
      ),
      body: Consumer<GoalProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.goals.isEmpty) {
            return EmptyState(
              icon: Icons.flag,
              title: 'No goals yet',
              message:
                  'Set a long-term goal, then break it into deliverables you can track.',
              action: FilledButton.icon(
                onPressed: () => _openForm(context),
                icon: const Icon(Icons.add),
                label: const Text('Create a goal'),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 96),
            itemCount: provider.goals.length,
            itemBuilder: (context, i) {
              final goal = provider.goals[i];
              return _GoalCard(
                goal: goal,
                logStream: provider.watchLogsForGoal(goal.id),
                onTap: () => _openDetail(context, goal),
              );
            },
          );
        },
      ),
    );
  }

  void _openForm(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const GoalFormScreen()),
    );
  }

  void _openDetail(BuildContext context, Goal goal) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => GoalDetailScreen(goalId: goal.id)),
    );
  }
}

class _GoalCard extends StatelessWidget {
  const _GoalCard({
    required this.goal,
    required this.logStream,
    required this.onTap,
  });

  final Goal goal;
  final Stream<List<DeliverableLogWithDeliverable>> logStream;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: StreamBuilder<List<DeliverableLogWithDeliverable>>(
            stream: logStream,
            builder: (context, snapshot) {
              final logs = snapshot.data ?? const [];
              final progress = computeGoalProgress(goal, logs);
              final timeline = timelineProgress(goal, DateTime.now());
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(goal.name,
                            style: theme.textTheme.titleMedium),
                      ),
                      Text(
                        '${(progress.metricRatio * 100).round()}%',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _targetLabel(goal, progress),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progress.metricRatio,
                      minHeight: 8,
                      backgroundColor:
                          theme.colorScheme.surfaceContainerHighest,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.schedule,
                          size: 14, color: theme.colorScheme.onSurfaceVariant),
                      const SizedBox(width: 4),
                      Text(
                        '${formatShortDate(goal.startDate)} – ${formatShortDate(goal.endDate)}'
                        '  ·  ${(timeline * 100).round()}% elapsed',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  String _targetLabel(Goal goal, GoalProgress progress) {
    final unit = goal.unit.isEmpty ? '' : ' ${goal.unit}';
    final current = progress.currentValue != null
        ? formatMetric(progress.currentValue!)
        : formatMetric(goal.startValue);
    return 'Now $current$unit  →  target ${formatMetric(goal.targetValue)}$unit';
  }
}
