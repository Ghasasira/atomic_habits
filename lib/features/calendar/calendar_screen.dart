import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/constants/enums.dart';
import '../../core/utils/format.dart';
import '../../providers/calendar_provider.dart';

/// Calendar module (FR-3.1): a month view where each day is colour-coded by
/// how many of that day's scheduled habits were accomplished, plus a per-day
/// breakdown the user can edit.
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendar')),
      body: Consumer<CalendarProvider>(
        builder: (context, provider, _) {
          return ListView(
            padding: const EdgeInsets.only(bottom: 24),
            children: [
              Card(
                margin: const EdgeInsets.all(12),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: _Calendar(provider: provider),
                ),
              ),
              const _Legend(),
              const SizedBox(height: 8),
              _DayDetails(provider: provider),
            ],
          );
        },
      ),
    );
  }
}

class _Calendar extends StatelessWidget {
  const _Calendar({required this.provider});
  final CalendarProvider provider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2035, 12, 31),
      focusedDay: provider.focusedMonth,
      currentDay: DateTime.now(),
      selectedDayPredicate: (day) => isSameDay(day, provider.selectedDay),
      calendarFormat: CalendarFormat.month,
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableGestures: AvailableGestures.horizontalSwipe,
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      onDaySelected: (selected, focused) {
        provider.selectDay(selected);
        provider.focusMonth(focused);
      },
      onPageChanged: provider.focusMonth,
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, _) => _cell(theme, day),
        todayBuilder: (context, day, _) => _cell(theme, day, isToday: true),
        selectedBuilder: (context, day, _) =>
            _cell(theme, day, isSelected: true),
        outsideBuilder: (context, day, _) => _cell(theme, day, outside: true),
      ),
    );
  }

  Widget _cell(
    ThemeData theme,
    DateTime day, {
    bool isToday = false,
    bool isSelected = false,
    bool outside = false,
  }) {
    final completion = provider.completionFor(day);
    final fill = _fillColor(theme, completion, outside);
    final onFill = _onFillColor(theme, completion, outside);

    return Container(
      margin: const EdgeInsets.all(4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: fill,
        shape: BoxShape.circle,
        border: isSelected
            ? Border.all(color: theme.colorScheme.primary, width: 2)
            : isToday
                ? Border.all(color: theme.colorScheme.primary, width: 1)
                : null,
      ),
      child: Text(
        '${day.day}',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: onFill,
          fontWeight: isToday || isSelected ? FontWeight.bold : null,
        ),
      ),
    );
  }

  Color _fillColor(ThemeData theme, DayCompletion c, bool outside) {
    if (c.due == 0) return Colors.transparent;
    if (c.isComplete) return Colors.green.withValues(alpha: outside ? 0.3 : 0.85);
    if (c.isPartial) {
      return Colors.orange.withValues(alpha: outside ? 0.25 : 0.75);
    }
    if (c.hasAnyLog) {
      // Logged but nothing accomplished (all skipped).
      return theme.colorScheme.error.withValues(alpha: outside ? 0.2 : 0.6);
    }
    return Colors.transparent;
  }

  Color _onFillColor(ThemeData theme, DayCompletion c, bool outside) {
    final coloured = c.due > 0 && (c.isComplete || c.isPartial || c.hasAnyLog);
    if (coloured && !outside) return Colors.white;
    return outside
        ? theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5)
        : theme.colorScheme.onSurface;
  }
}

class _Legend extends StatelessWidget {
  const _Legend();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget dot(Color color, String label) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
            Text(label, style: theme.textTheme.bodySmall),
          ],
        );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 16,
        runSpacing: 8,
        children: [
          dot(Colors.green, 'All done'),
          dot(Colors.orange, 'Partial'),
          dot(theme.colorScheme.error, 'Missed'),
        ],
      ),
    );
  }
}

class _DayDetails extends StatelessWidget {
  const _DayDetails({required this.provider});
  final CalendarProvider provider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final day = provider.selectedDay;
    final entries = provider.habitsOn(day);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Text(
            formatDayLabel(day),
            style: theme.textTheme.titleMedium,
          ),
        ),
        if (entries.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'No habits scheduled on this day.',
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          )
        else
          ...entries.map(
            (e) => ListTile(
              leading: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Color(e.habit.colorValue),
                  shape: BoxShape.circle,
                ),
              ),
              title: Text(e.habit.name),
              subtitle: Text(formatHourMinute(
                  e.habit.targetHour, e.habit.targetMinute)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    tooltip: 'Accomplished',
                    onPressed: () => provider.setStatus(
                        e.habit.id, day, LogStatus.accomplished),
                    icon: Icon(
                      Icons.check_circle,
                      color: (e.status?.isAccomplished ?? false)
                          ? Colors.green
                          : theme.colorScheme.onSurfaceVariant
                              .withValues(alpha: 0.4),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Skipped',
                    onPressed: () =>
                        provider.setStatus(e.habit.id, day, LogStatus.skipped),
                    icon: Icon(
                      Icons.cancel,
                      color: (e.status?.isSkipped ?? false)
                          ? theme.colorScheme.error
                          : theme.colorScheme.onSurfaceVariant
                              .withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
