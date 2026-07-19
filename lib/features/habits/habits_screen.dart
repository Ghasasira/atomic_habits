import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/enums.dart';
import '../../core/utils/date_x.dart';
import '../../core/utils/format.dart';
import '../../data/database/database.dart';
import '../../providers/habit_provider.dart';
import '../../providers/reminder_permission_provider.dart';
import '../shared/empty_state.dart';
import 'habit_form_screen.dart';

/// The "Today" module: the habits scheduled for the selected day plus quick
/// controls to mark each Accomplished/Skipped (FR-2.2, FR-3.2).
class HabitsScreen extends StatelessWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Today')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(context),
        icon: const Icon(Icons.add),
        label: const Text('Habit'),
      ),
      body: Consumer<HabitProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final habits = provider.habitsForSelectedDay;
          // Only warn when a reminder actually depends on notifications.
          final remindersBlocked =
              context.watch<ReminderPermissionProvider>().remindersBlocked &&
                  provider.habits.any((h) => h.reminderEnabled);
          return Column(
            children: [
              if (remindersBlocked) const _RemindersBlockedBanner(),
              _WeekStrip(
                selectedDay: provider.selectedDay,
                onSelected: provider.selectDay,
              ),
              if (habits.isNotEmpty)
                _ProgressHeader(
                  done: provider.completedCount,
                  total: habits.length,
                ),
              Expanded(
                child: provider.habits.isEmpty
                    ? EmptyState(
                        icon: Icons.self_improvement,
                        title: 'No habits yet',
                        message:
                            'Create your first habit to start building momentum.',
                        action: FilledButton.icon(
                          onPressed: () => _openForm(context),
                          icon: const Icon(Icons.add),
                          label: const Text('Add a habit'),
                        ),
                      )
                    : habits.isEmpty
                        ? const EmptyState(
                            icon: Icons.event_available,
                            title: 'Nothing scheduled',
                            message:
                                'No habits are due on this day. Enjoy the rest!',
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.fromLTRB(12, 4, 12, 96),
                            itemCount: habits.length,
                            itemBuilder: (context, i) {
                              final habit = habits[i];
                              return _HabitTile(
                                habit: habit,
                                status: provider.statusFor(habit.id),
                                onStatus: (s) =>
                                    provider.setStatus(habit.id, s),
                                onEdit: () => _openForm(context, habit),
                                onDelete: () =>
                                    _confirmDelete(context, provider, habit),
                              );
                            },
                          ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _openForm(BuildContext context, [Habit? habit]) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => HabitFormScreen(habit: habit)),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    HabitProvider provider,
    Habit habit,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete "${habit.name}"?'),
        content: const Text(
            'This removes the habit and its history. This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      await provider.deleteHabit(habit.id);
    }
  }
}

/// Shown when the OS is blocking our notifications, so alarms fire silently.
/// "Enable" retries the permission dialog and falls back to system settings.
class _RemindersBlockedBanner extends StatelessWidget {
  const _RemindersBlockedBanner();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(Icons.notifications_off_outlined,
              color: theme.colorScheme.onErrorContainer),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Notifications are blocked, so habit reminders cannot ring.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onErrorContainer,
              ),
            ),
          ),
          TextButton(
            onPressed: () =>
                context.read<ReminderPermissionProvider>().enableReminders(),
            child: const Text('Enable'),
          ),
        ],
      ),
    );
  }
}

class _WeekStrip extends StatelessWidget {
  const _WeekStrip({required this.selectedDay, required this.onSelected});

  final DateTime selectedDay;
  final ValueChanged<DateTime> onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final today = DateTime.now().dateOnly;
    final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    return SizedBox(
      height: 76,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: 7,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final day = startOfWeek.add(Duration(days: i));
          final selected = day.isSameDay(selectedDay);
          final isToday = day.isSameDay(today);
          return GestureDetector(
            onTap: () => onSelected(day),
            child: Container(
              width: 52,
              decoration: BoxDecoration(
                color: selected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(14),
                border: isToday && !selected
                    ? Border.all(color: theme.colorScheme.primary, width: 1.5)
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    kShortWeekdayLabels[day.weekday - 1],
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: selected
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${day.day}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: selected
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ProgressHeader extends StatelessWidget {
  const _ProgressHeader({required this.done, required this.total});

  final int done;
  final int total;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ratio = total == 0 ? 0.0 : done / total;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Progress', style: theme.textTheme.labelLarge),
              Text('$done / $total done',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.primary,
                  )),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: ratio,
              minHeight: 8,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
            ),
          ),
        ],
      ),
    );
  }
}

class _HabitTile extends StatelessWidget {
  const _HabitTile({
    required this.habit,
    required this.status,
    required this.onStatus,
    required this.onEdit,
    required this.onDelete,
  });

  final Habit habit;
  final LogStatus? status;
  final ValueChanged<LogStatus> onStatus;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = Color(habit.colorValue);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: onEdit,
        onLongPress: onDelete,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
          child: Row(
            children: [
              Container(
                width: 6,
                height: 44,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(habit.name, style: theme.textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text(
                      '${formatHourMinute(habit.targetHour, habit.targetMinute)}'
                      ' · ${habit.category}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              _StatusButton(
                icon: Icons.check,
                active: status?.isAccomplished ?? false,
                activeColor: Colors.green,
                onTap: () => onStatus(LogStatus.accomplished),
              ),
              const SizedBox(width: 4),
              _StatusButton(
                icon: Icons.close,
                active: status?.isSkipped ?? false,
                activeColor: theme.colorScheme.error,
                onTap: () => onStatus(LogStatus.skipped),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusButton extends StatelessWidget {
  const _StatusButton({
    required this.icon,
    required this.active,
    required this.activeColor,
    required this.onTap,
  });

  final IconData icon;
  final bool active;
  final Color activeColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: active
          ? activeColor.withValues(alpha: 0.16)
          : theme.colorScheme.surfaceContainerHighest,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Icon(
            icon,
            size: 22,
            color: active ? activeColor : theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
