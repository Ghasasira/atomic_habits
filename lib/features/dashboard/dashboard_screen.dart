import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/date_x.dart';
import '../../data/database/database.dart';
import '../../providers/dashboard_provider.dart';
import '../../providers/goal_provider.dart';
import '../goals/goal_progress.dart';

/// Performance dashboard (FR-6.1, FR-6.2): habit adherence analytics plus a
/// snapshot of every active goal's progress toward its target.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Consumer<DashboardProvider>(
        builder: (context, dash, _) {
          if (dash.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
            children: [
              _StatRow(dash: dash),
              const SizedBox(height: 12),
              _WeeklyTrendCard(dash: dash),
              const SizedBox(height: 12),
              _StreaksCard(dash: dash),
              const SizedBox(height: 12),
              const _GoalProgressSection(),
            ],
          );
        },
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.dash});
  final DashboardProvider dash;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatTile(
            icon: Icons.checklist,
            label: 'Active habits',
            value: '${dash.activeHabitCount}',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatTile(
            icon: Icons.percent,
            label: 'This week',
            value: '${(dash.weeklyCompletionRate * 100).round()}%',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatTile(
            icon: Icons.local_fire_department,
            label: 'Best streak',
            value: '${dash.bestStreak}',
          ),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: [
            Icon(icon, color: theme.colorScheme.primary),
            const SizedBox(height: 8),
            Text(value,
                style: theme.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeeklyTrendCard extends StatelessWidget {
  const _WeeklyTrendCard({required this.dash});
  final DashboardProvider dash;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final trend = dash.trend(days: 7);
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Last 7 days', style: theme.textTheme.titleMedium),
            Text(
              'Habits accomplished vs scheduled',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 160,
              child: BarChart(
                BarChartData(
                  maxY: 1,
                  minY: 0,
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, _, rod, _) {
                        final day = trend[group.x];
                        return BarTooltipItem(
                          '${day.accomplished}/${day.due}',
                          TextStyle(
                            color: theme.colorScheme.onInverseSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final i = value.toInt();
                          if (i < 0 || i >= trend.length) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              kShortWeekdayLabels[trend[i].date.weekday - 1][0],
                              style: theme.textTheme.labelSmall,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  barGroups: [
                    for (var i = 0; i < trend.length; i++)
                      BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            toY: trend[i].due == 0 ? 0 : trend[i].ratio,
                            width: 18,
                            borderRadius: BorderRadius.circular(6),
                            color: theme.colorScheme.primary,
                            backDrawRodData: BackgroundBarChartRodData(
                              show: true,
                              toY: 1,
                              color: theme.colorScheme.surfaceContainerHighest,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StreaksCard extends StatelessWidget {
  const _StreaksCard({required this.dash});
  final DashboardProvider dash;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final streaks = dash.habitStreaks;
    if (streaks.isEmpty) return const SizedBox.shrink();
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Habit streaks',
                    style: theme.textTheme.titleMedium),
              ),
            ),
            for (final s in streaks)
              ListTile(
                leading: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Color(s.habit.colorValue),
                    shape: BoxShape.circle,
                  ),
                ),
                title: Text(s.habit.name),
                subtitle: Text(
                    '${(s.completionRate * 100).round()}% over 30 days'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.local_fire_department,
                        size: 20,
                        color: s.currentStreak > 0
                            ? Colors.orange
                            : theme.colorScheme.onSurfaceVariant
                                .withValues(alpha: 0.4)),
                    const SizedBox(width: 4),
                    Text('${s.currentStreak}',
                        style: theme.textTheme.titleMedium),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _GoalProgressSection extends StatelessWidget {
  const _GoalProgressSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<GoalProvider>(
      builder: (context, goalProvider, _) {
        final goals = goalProvider.goals;
        if (goals.isEmpty) return const SizedBox.shrink();
        return Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Goal progress', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                for (final goal in goals)
                  StreamBuilder(
                    stream: goalProvider.watchLogsForGoal(goal.id),
                    builder: (context, snapshot) {
                      final logs = snapshot.data ?? const [];
                      final progress = computeGoalProgress(goal, logs);
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: _GoalProgressRow(
                            goal: goal, ratio: progress.metricRatio),
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _GoalProgressRow extends StatelessWidget {
  const _GoalProgressRow({required this.goal, required this.ratio});
  final Goal goal;
  final double ratio;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(goal.name, style: theme.textTheme.bodyLarge)),
            Text('${(ratio * 100).round()}%',
                style: theme.textTheme.labelLarge
                    ?.copyWith(color: theme.colorScheme.primary)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: ratio,
            minHeight: 7,
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
          ),
        ),
      ],
    );
  }
}
