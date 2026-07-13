import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/enums.dart';
import '../../core/utils/date_x.dart';
import '../../core/utils/format.dart';
import '../../data/database/daos/goal_dao.dart';
import '../../data/database/database.dart';
import '../../providers/goal_provider.dart';
import 'deliverable_form_screen.dart';
import 'goal_form_screen.dart';
import 'goal_progress.dart';

/// Full detail of a goal: its metric progress, timeline and the deliverables
/// with their recorded inputs (FR-4.2, FR-5.1, FR-5.2, FR-6.2).
class GoalDetailScreen extends StatelessWidget {
  const GoalDetailScreen({super.key, required this.goalId});

  final int goalId;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<GoalProvider>();
    return StreamBuilder<Goal?>(
      stream: provider.repository.watchGoal(goalId),
      builder: (context, goalSnap) {
        final goal = goalSnap.data;
        if (goal == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(goal.name),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => GoalFormScreen(goal: goal)),
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) =>
                    _onMenu(context, provider, goal, value),
                itemBuilder: (_) => const [
                  PopupMenuItem(value: 'archive', child: Text('Archive goal')),
                  PopupMenuItem(value: 'delete', child: Text('Delete goal')),
                ],
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _addDeliverable(context, goalId),
            icon: const Icon(Icons.add_task),
            label: const Text('Deliverable'),
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 96),
            children: [
              _GoalSummary(goal: goal, provider: provider),
              const SizedBox(height: 8),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: Text('Deliverables',
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              _DeliverableList(goalId: goalId, provider: provider),
            ],
          ),
        );
      },
    );
  }

  Future<void> _onMenu(
    BuildContext context,
    GoalProvider provider,
    Goal goal,
    String value,
  ) async {
    if (value == 'archive') {
      await provider.archiveGoal(goal.id);
      if (context.mounted) Navigator.of(context).pop();
    } else if (value == 'delete') {
      final ok = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Delete "${goal.name}"?'),
          content: const Text(
              'This removes the goal, its deliverables and all recorded inputs.'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancel')),
            FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Delete')),
          ],
        ),
      );
      if ((ok ?? false) && context.mounted) {
        await provider.deleteGoal(goal.id);
        if (context.mounted) Navigator.of(context).pop();
      }
    }
  }

  void _addDeliverable(BuildContext context, int goalId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DeliverableFormScreen(goalId: goalId),
      ),
    );
  }
}

class _GoalSummary extends StatelessWidget {
  const _GoalSummary({required this.goal, required this.provider});
  final Goal goal;
  final GoalProvider provider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<List<DeliverableLogWithDeliverable>>(
          stream: provider.watchLogsForGoal(goal.id),
          builder: (context, snapshot) {
            final logs = snapshot.data ?? const [];
            final progress = computeGoalProgress(goal, logs);
            final timeline = timelineProgress(goal, DateTime.now());
            final unit = goal.unit.isEmpty ? '' : ' ${goal.unit}';
            final current = progress.currentValue != null
                ? formatMetric(progress.currentValue!)
                : formatMetric(goal.startValue);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (goal.description != null &&
                    goal.description!.isNotEmpty) ...[
                  Text(goal.description!, style: theme.textTheme.bodyMedium),
                  const SizedBox(height: 12),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _metric(theme, 'Start', '${formatMetric(goal.startValue)}$unit'),
                    _metric(theme, 'Now', '$current$unit', highlight: true),
                    _metric(theme, 'Target',
                        '${formatMetric(goal.targetValue)}$unit'),
                  ],
                ),
                const SizedBox(height: 16),
                _ProgressRow(
                  label: 'Metric progress',
                  ratio: progress.metricRatio,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 10),
                _ProgressRow(
                  label: 'Timeline',
                  ratio: timeline,
                  color: theme.colorScheme.tertiary,
                ),
                const SizedBox(height: 12),
                Text(
                  '${formatShortDate(goal.startDate)} – ${formatShortDate(goal.endDate)}'
                  '  ·  ${progress.accomplishedCount} inputs recorded',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _metric(ThemeData theme, String label, String value,
      {bool highlight = false}) {
    return Column(
      children: [
        Text(label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            )),
        const SizedBox(height: 2),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            color: highlight ? theme.colorScheme.primary : null,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _ProgressRow extends StatelessWidget {
  const _ProgressRow({
    required this.label,
    required this.ratio,
    required this.color,
  });

  final String label;
  final double ratio;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: theme.textTheme.labelMedium),
            Text('${(ratio * 100).round()}%',
                style: theme.textTheme.labelMedium),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: ratio,
            minHeight: 7,
            color: color,
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
          ),
        ),
      ],
    );
  }
}

class _DeliverableList extends StatelessWidget {
  const _DeliverableList({required this.goalId, required this.provider});
  final int goalId;
  final GoalProvider provider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return StreamBuilder<List<Deliverable>>(
      stream: provider.watchDeliverables(goalId),
      builder: (context, snapshot) {
        final deliverables = snapshot.data ?? const [];
        if (deliverables.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: Text(
                'No deliverables yet. Add the steps that move this goal forward.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            ),
          );
        }
        return Column(
          children: [
            for (final d in deliverables)
              _DeliverableCard(deliverable: d, provider: provider),
          ],
        );
      },
    );
  }
}

class _DeliverableCard extends StatelessWidget {
  const _DeliverableCard({required this.deliverable, required this.provider});
  final Deliverable deliverable;
  final GoalProvider provider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unit =
        deliverable.inputUnit.isEmpty ? '' : ' ${deliverable.inputUnit}';
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(deliverable.name,
                      style: theme.textTheme.titleMedium),
                ),
                PopupMenuButton<String>(
                  onSelected: (v) => _onMenu(context, v),
                  itemBuilder: (_) => const [
                    PopupMenuItem(value: 'edit', child: Text('Edit')),
                    PopupMenuItem(value: 'delete', child: Text('Delete')),
                  ],
                ),
              ],
            ),
            Text(
              '${frequencySummary(frequency: deliverable.frequency, weekdaysMask: deliverable.weekdaysMask, intervalDays: deliverable.intervalDays)}'
              '  ·  ${deliverable.inputLabel}$unit'
              '${deliverable.targetInput != null ? ' (target ${formatMetric(deliverable.targetInput!)}$unit)' : ''}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            StreamBuilder<List<DeliverableLog>>(
              stream: provider.watchLogsForDeliverable(deliverable.id),
              builder: (context, snapshot) {
                final logs = snapshot.data ?? const [];
                final metricLogs = logs
                    .where((l) =>
                        l.status.isAccomplished && l.inputValue != null)
                    .toList();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (metricLogs.length >= 2)
                      SizedBox(
                        height: 60,
                        child: _Sparkline(
                          values: metricLogs
                              .map((l) => l.inputValue!)
                              .toList(),
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          metricLogs.isEmpty
                              ? 'No inputs yet'
                              : 'Last: ${formatMetric(metricLogs.last.inputValue!)}$unit'
                                  ' · ${formatShortDate(metricLogs.last.date)}',
                          style: theme.textTheme.bodySmall,
                        ),
                        FilledButton.tonalIcon(
                          onPressed: () =>
                              _logDeliverable(context, provider, deliverable),
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text('Log'),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onMenu(BuildContext context, String value) async {
    if (value == 'edit') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => DeliverableFormScreen(
            goalId: deliverable.goalId,
            deliverable: deliverable,
          ),
        ),
      );
    } else if (value == 'delete') {
      await provider.deleteDeliverable(deliverable.id);
    }
  }
}

class _Sparkline extends StatelessWidget {
  const _Sparkline({required this.values, required this.color});
  final List<double> values;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final spots = [
      for (var i = 0; i < values.length; i++)
        FlSpot(i.toDouble(), values[i]),
    ];
    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineTouchData: const LineTouchData(enabled: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: color,
            barWidth: 2.5,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: color.withValues(alpha: 0.12),
            ),
          ),
        ],
      ),
    );
  }
}

/// Prompts for the expected input (FR-5.1) and records the deliverable log.
Future<void> _logDeliverable(
  BuildContext context,
  GoalProvider provider,
  Deliverable deliverable,
) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (_) => _LogSheet(deliverable: deliverable, provider: provider),
  );
}

class _LogSheet extends StatefulWidget {
  const _LogSheet({required this.deliverable, required this.provider});
  final Deliverable deliverable;
  final GoalProvider provider;

  @override
  State<_LogSheet> createState() => _LogSheetState();
}

class _LogSheetState extends State<_LogSheet> {
  final _controller = TextEditingController();
  DateTime _date = DateTime.now().dateOnly;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit(LogStatus status) async {
    final value = double.tryParse(_controller.text.trim());
    await widget.provider.logDeliverable(
      widget.deliverable.id,
      _date,
      status,
      status.isAccomplished ? value : null,
    );
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _date = picked.dateOnly);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final d = widget.deliverable;
    final unit = d.inputUnit.isEmpty ? '' : ' (${d.inputUnit})';
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + bottomInset),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(d.name, style: theme.textTheme.titleLarge),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            autofocus: true,
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: '${d.inputLabel}$unit',
              hintText: d.targetInput != null
                  ? 'Target ${formatMetric(d.targetInput!)}'
                  : null,
            ),
          ),
          const SizedBox(height: 12),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.calendar_today),
            title: const Text('Date'),
            subtitle: Text(formatDayLabel(_date)),
            trailing: const Icon(Icons.edit),
            onTap: _pickDate,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _submit(LogStatus.skipped),
                  icon: const Icon(Icons.close),
                  label: const Text('Skipped'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => _submit(LogStatus.accomplished),
                  icon: const Icon(Icons.check),
                  label: const Text('Accomplished'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
