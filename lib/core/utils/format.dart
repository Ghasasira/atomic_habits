import 'package:intl/intl.dart';

import '../constants/enums.dart';
import 'date_x.dart';

/// Formats a wall-clock time, e.g. "8:30 AM".
String formatHourMinute(int hour, int minute) =>
    DateFormat.jm().format(DateTime(2000, 1, 1, hour, minute));

/// Short human summary of a recurrence, e.g. "Mon, Wed, Fri" or "Every 3 days".
String frequencySummary({
  required FrequencyType frequency,
  required int weekdaysMask,
  required int intervalDays,
}) {
  switch (frequency) {
    case FrequencyType.daily:
      return 'Every day';
    case FrequencyType.weekly:
      final days = [
        for (var wd = DateTime.monday; wd <= DateTime.sunday; wd++)
          if (weekdaysMask.hasWeekday(wd)) kShortWeekdayLabels[wd - 1],
      ];
      if (days.isEmpty) return 'No days set';
      if (days.length == 7) return 'Every day';
      return days.join(', ');
    case FrequencyType.interval:
      return intervalDays <= 1 ? 'Every day' : 'Every $intervalDays days';
  }
}

/// Trims trailing zeros from a metric value, e.g. 3.0 -> "3", 3.5 -> "3.5".
String formatMetric(double value) {
  if (value == value.roundToDouble()) return value.toInt().toString();
  return value.toStringAsFixed(2).replaceFirst(RegExp(r'0+$'), '');
}

String formatDayLabel(DateTime day) => DateFormat.yMMMMEEEEd().format(day);

String formatShortDate(DateTime day) => DateFormat.MMMd().format(day);
