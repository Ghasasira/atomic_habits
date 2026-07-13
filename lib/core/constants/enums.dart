/// Status recorded for a single habit or deliverable instance on a given day.
enum LogStatus {
  accomplished,
  skipped,
}

/// How often a habit or deliverable recurs.
enum FrequencyType {
  /// Every day.
  daily,

  /// On specific weekdays (see `weekdaysMask`).
  weekly,

  /// Every N days (see `intervalDays`), e.g. "run every 3 days".
  interval,
}

extension LogStatusX on LogStatus {
  bool get isAccomplished => this == LogStatus.accomplished;
  bool get isSkipped => this == LogStatus.skipped;

  String get label => switch (this) {
        LogStatus.accomplished => 'Accomplished',
        LogStatus.skipped => 'Skipped',
      };
}

extension FrequencyTypeX on FrequencyType {
  String get label => switch (this) {
        FrequencyType.daily => 'Daily',
        FrequencyType.weekly => 'Specific days',
        FrequencyType.interval => 'Every N days',
      };
}
