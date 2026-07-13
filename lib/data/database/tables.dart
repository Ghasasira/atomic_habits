import 'package:drift/drift.dart';

import '../../core/constants/enums.dart';

/// A recurring habit the user wants to model (FR-1.1..1.3).
class Habits extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get category => text().withDefault(const Constant('General'))();

  /// Target execution time-of-day (FR-1.1), split so it survives timezone
  /// changes without shifting the wall-clock reminder.
  IntColumn get targetHour => integer().withDefault(const Constant(8))();
  IntColumn get targetMinute => integer().withDefault(const Constant(0))();

  /// Frequency (FR-1.2). For [FrequencyType.weekly] the active days live in
  /// [weekdaysMask]; [FrequencyType.interval] uses [intervalDays].
  TextColumn get frequency =>
      textEnum<FrequencyType>().withDefault(const Constant('daily'))();
  IntColumn get weekdaysMask => integer().withDefault(const Constant(127))();
  IntColumn get intervalDays => integer().withDefault(const Constant(1))();

  /// ARGB colour used to colour-code the calendar (FR-3.1).
  IntColumn get colorValue =>
      integer().withDefault(const Constant(0xFF6750A4))();
  BoolColumn get reminderEnabled =>
      boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
}

/// One recorded instance of a habit on a specific day (FR-3.2).
class HabitLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get habitId =>
      integer().references(Habits, #id, onDelete: KeyAction.cascade)();

  /// The calendar day this log belongs to (normalised to local midnight).
  DateTimeColumn get date => dateTime()();
  TextColumn get status => textEnum<LogStatus>()();

  /// Exact moment the user recorded the status (FR-3.2 timestamp).
  DateTimeColumn get loggedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
        {habitId, date},
      ];
}

/// A long-term goal with a measurable start/target (FR-4.1).
class Goals extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 120)();
  TextColumn get description => text().nullable()();

  /// Starting point and ending point/target, measured in [unit].
  RealColumn get startValue => real().withDefault(const Constant(0))();
  RealColumn get targetValue => real()();
  TextColumn get unit => text().withDefault(const Constant(''))();

  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
}

/// A concrete step attached to a goal (FR-4.2), with its own frequency
/// (FR-4.3) and an expected metric input (FR-5.1).
class Deliverables extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get goalId =>
      integer().references(Goals, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text().withLength(min: 1, max: 120)();

  TextColumn get frequency =>
      textEnum<FrequencyType>().withDefault(const Constant('daily'))();
  IntColumn get weekdaysMask => integer().withDefault(const Constant(127))();
  IntColumn get intervalDays => integer().withDefault(const Constant(1))();

  /// Prompt + unit for the expected input (FR-5.1), e.g. "Duration"/"minutes".
  TextColumn get inputLabel =>
      text().withDefault(const Constant('Value'))();
  TextColumn get inputUnit => text().withDefault(const Constant(''))();

  /// Optional per-instance target for the metric (e.g. 3 km).
  RealColumn get targetInput => real().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}

/// One recorded execution of a deliverable, storing the metric input
/// (FR-5.2) linked back to the deliverable and its goal.
class DeliverableLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get deliverableId =>
      integer().references(Deliverables, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get date => dateTime()();
  TextColumn get status => textEnum<LogStatus>()();

  /// The metric the user entered on completion (null when skipped).
  RealColumn get inputValue => real().nullable()();
  DateTimeColumn get loggedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
        {deliverableId, date},
      ];
}
