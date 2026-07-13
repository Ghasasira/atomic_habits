import '../constants/enums.dart';

/// Weekday helpers. We use the Dart convention where [DateTime.monday] == 1 …
/// [DateTime.sunday] == 7, and map each weekday onto a single bit of a mask so
/// a habit's active days fit in one integer column.
///
/// Bit layout: bit 0 = Monday, bit 1 = Tuesday, … bit 6 = Sunday.
extension WeekdayMask on int {
  /// Whether [weekday] (1..7) is enabled in this mask.
  bool hasWeekday(int weekday) => (this & (1 << (weekday - 1))) != 0;

  /// Returns a copy of the mask with [weekday] toggled on/off.
  int toggleWeekday(int weekday, bool enabled) {
    final bit = 1 << (weekday - 1);
    return enabled ? (this | bit) : (this & ~bit);
  }
}

/// All-days mask (Mon–Sun enabled).
const int kAllWeekdaysMask = 127;

const List<String> kShortWeekdayLabels = [
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
  'Sun',
];

extension DateOnly on DateTime {
  /// Strips the time component, normalising to local midnight. Used as the
  /// canonical key for a "day" when logging habit/deliverable completion.
  DateTime get dateOnly => DateTime(year, month, day);

  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;
}

/// Decides whether an item with the given schedule is due on [day].
bool isDueOn({
  required FrequencyType frequency,
  required DateTime day,
  int weekdaysMask = kAllWeekdaysMask,
  int intervalDays = 1,
  DateTime? anchorDate,
}) {
  switch (frequency) {
    case FrequencyType.daily:
      return true;
    case FrequencyType.weekly:
      return weekdaysMask.hasWeekday(day.weekday);
    case FrequencyType.interval:
      final anchor = (anchorDate ?? day).dateOnly;
      final diff = day.dateOnly.difference(anchor).inDays;
      if (diff < 0) return false;
      final step = intervalDays <= 0 ? 1 : intervalDays;
      return diff % step == 0;
  }
}
