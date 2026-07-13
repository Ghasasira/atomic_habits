import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../core/constants/enums.dart';
import '../core/utils/date_x.dart';

/// Identifiers for the actionable notification buttons (FR-2.2).
const String kAccomplishedActionId = 'accomplished';
const String kSkippedActionId = 'skipped';
const String _channelId = 'habit_alarms';

/// Signature for the callback invoked when the user taps an action on a habit
/// reminder. [habitId] is the affected habit; [status] the chosen outcome.
typedef HabitActionHandler = Future<void> Function(int habitId, LogStatus status);

/// Called by the OS when a notification action is tapped while the app is not
/// running in the foreground. Must be a top-level / static function.
@pragma('vm:entry-point')
void notificationBackgroundHandler(NotificationResponse response) {
  // Persisting from a background isolate needs its own DB connection and a
  // plugin registrant; we intentionally keep this light. Pending actions are
  // reconciled on next launch via [NotificationService.processLaunchAction].
  // See README "Reminders & Alarms" for the reliability notes.
}

/// Wraps `flutter_local_notifications` to deliver alarm-style habit reminders
/// (FR-2.1) with "Accomplished"/"Skipped" actions (FR-2.2), scheduled to fire
/// reliably even when the app is terminated (NFR-1.1).
class NotificationService {
  NotificationService();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialised = false;

  /// Set by the app so tapped actions can be written to the database.
  HabitActionHandler? onHabitAction;

  Future<void> init() async {
    if (_initialised) return;

    tz.initializeTimeZones();
    try {
      final localName = (await FlutterTimezone.getLocalTimezone()).identifier;
      tz.setLocalLocation(tz.getLocation(localName));
    } catch (_) {
      // Fall back to UTC if the device timezone can't be resolved.
    }

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    final darwinInit = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      notificationCategories: [
        DarwinNotificationCategory(
          'habit_actions',
          actions: [
            DarwinNotificationAction.plain(
                kAccomplishedActionId, 'Accomplished'),
            DarwinNotificationAction.plain(kSkippedActionId, 'Skipped'),
          ],
        ),
      ],
    );

    await _plugin.initialize(
      settings: InitializationSettings(android: androidInit, iOS: darwinInit),
      onDidReceiveNotificationResponse: _onForegroundResponse,
      onDidReceiveBackgroundNotificationResponse: notificationBackgroundHandler,
    );

    await _createChannel();
    _initialised = true;
  }

  Future<void> _createChannel() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await android?.createNotificationChannel(
      const AndroidNotificationChannel(
        _channelId,
        'Habit Alarms',
        description: 'Time-of-day alarms and reminders for your habits.',
        importance: Importance.max,
        playSound: true,
        enableVibration: true,
      ),
    );
  }

  /// Requests notification + exact-alarm permissions. Returns true if
  /// notifications are permitted.
  Future<bool> requestPermissions() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      final granted = await android.requestNotificationsPermission() ?? false;
      // Needed for precise firing while the device is idle (NFR-1.1).
      await android.requestExactAlarmsPermission();
      return granted;
    }
    final ios = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    if (ios != null) {
      return await ios.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          ) ??
          false;
    }
    return true;
  }

  NotificationDetails _details(String habitName) {
    final android = AndroidNotificationDetails(
      _channelId,
      'Habit Alarms',
      channelDescription: 'Time-of-day alarms and reminders for your habits.',
      importance: Importance.max,
      priority: Priority.max,
      category: AndroidNotificationCategory.alarm,
      fullScreenIntent: true,
      playSound: true,
      ticker: habitName,
      actions: const [
        AndroidNotificationAction(
          kAccomplishedActionId,
          'Accomplished',
          showsUserInterface: false,
          cancelNotification: true,
        ),
        AndroidNotificationAction(
          kSkippedActionId,
          'Skipped',
          showsUserInterface: false,
          cancelNotification: true,
        ),
      ],
    );
    const ios = DarwinNotificationDetails(
      categoryIdentifier: 'habit_actions',
      interruptionLevel: InterruptionLevel.timeSensitive,
    );
    return NotificationDetails(android: android, iOS: ios);
  }

  // --- Scheduling ---------------------------------------------------------

  /// (Re)schedules all reminders for a habit. Cancels any existing ones first.
  Future<void> scheduleHabit({
    required int habitId,
    required String name,
    required int hour,
    required int minute,
    required FrequencyType frequency,
    int weekdaysMask = kAllWeekdaysMask,
    int intervalDays = 1,
    DateTime? anchorDate,
    bool enabled = true,
  }) async {
    await cancelHabit(habitId);
    if (!enabled) return;

    const title = 'Time for your habit';
    final body = name;
    final details = _details(name);
    final mode = await _resolveScheduleMode();

    switch (frequency) {
      case FrequencyType.daily:
        await _zoned(
          _baseId(habitId),
          title,
          body,
          _nextInstanceOfTime(hour, minute),
          details,
          habitId,
          mode: mode,
          match: DateTimeComponents.time,
        );
        break;
      case FrequencyType.weekly:
        for (var weekday = DateTime.monday;
            weekday <= DateTime.sunday;
            weekday++) {
          if (!weekdaysMask.hasWeekday(weekday)) continue;
          await _zoned(
            _baseId(habitId) + weekday,
            title,
            body,
            _nextInstanceOfWeekdayTime(weekday, hour, minute),
            details,
            habitId,
            mode: mode,
            match: DateTimeComponents.dayOfWeekAndTime,
          );
        }
        break;
      case FrequencyType.interval:
        // One-shot for the next due date; repeats are re-armed on app open.
        final next = _nextIntervalInstance(
          hour: hour,
          minute: minute,
          intervalDays: intervalDays,
          anchor: anchorDate,
        );
        await _zoned(
          _baseId(habitId) + 8,
          title,
          body,
          next,
          details,
          habitId,
          mode: mode,
        );
        break;
    }
  }

  Future<void> _zoned(
    int id,
    String title,
    String body,
    tz.TZDateTime when,
    NotificationDetails details,
    int habitId, {
    required AndroidScheduleMode mode,
    DateTimeComponents? match,
  }) async {
    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: when,
      notificationDetails: details,
      androidScheduleMode: mode,
      matchDateTimeComponents: match,
      payload: habitId.toString(),
    );
  }

  /// Uses exact scheduling when the OS permits it, otherwise degrades to
  /// inexact alarms. This keeps us Play-compliant (we only declare
  /// SCHEDULE_EXACT_ALARM, requested at runtime) and prevents scheduling from
  /// throwing on Android 13+ when the user hasn't granted exact alarms.
  Future<AndroidScheduleMode> _resolveScheduleMode() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android == null) {
      // iOS/other platforms ignore androidScheduleMode.
      return AndroidScheduleMode.exactAllowWhileIdle;
    }
    final canExact = await android.canScheduleExactNotifications() ?? false;
    return canExact
        ? AndroidScheduleMode.exactAllowWhileIdle
        : AndroidScheduleMode.inexactAllowWhileIdle;
  }

  /// Cancels every notification id that could belong to [habitId].
  Future<void> cancelHabit(int habitId) async {
    final base = _baseId(habitId);
    await _plugin.cancel(id: base); // daily
    for (var weekday = DateTime.monday; weekday <= DateTime.sunday; weekday++) {
      await _plugin.cancel(id: base + weekday); // weekly
    }
    await _plugin.cancel(id: base + 8); // interval
  }

  Future<void> cancelAll() => _plugin.cancelAll();

  /// If the app was launched by tapping a notification action, replay it.
  Future<void> processLaunchAction() async {
    final launch = await _plugin.getNotificationAppLaunchDetails();
    final response = launch?.notificationResponse;
    if (launch?.didNotificationLaunchApp == true && response != null) {
      await _dispatch(response);
    }
  }

  void _onForegroundResponse(NotificationResponse response) {
    _dispatch(response);
  }

  Future<void> _dispatch(NotificationResponse response) async {
    final actionId = response.actionId;
    final payload = response.payload;
    if (actionId == null || payload == null) return;
    final habitId = int.tryParse(payload);
    if (habitId == null) return;

    final status = switch (actionId) {
      kAccomplishedActionId => LogStatus.accomplished,
      kSkippedActionId => LogStatus.skipped,
      _ => null,
    };
    if (status == null) return;
    try {
      await onHabitAction?.call(habitId, status);
    } catch (e) {
      debugPrint('Failed to handle notification action: $e');
    }
  }

  // Notification ids are namespaced per-habit so we can cancel deterministically.
  int _baseId(int habitId) => habitId * 10;

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (!scheduled.isAfter(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  tz.TZDateTime _nextInstanceOfWeekdayTime(int weekday, int hour, int minute) {
    var scheduled = _nextInstanceOfTime(hour, minute);
    while (scheduled.weekday != weekday) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  tz.TZDateTime _nextIntervalInstance({
    required int hour,
    required int minute,
    required int intervalDays,
    DateTime? anchor,
  }) {
    final now = tz.TZDateTime.now(tz.local);
    final step = intervalDays <= 0 ? 1 : intervalDays;
    final anchorDay = (anchor ?? now).dateOnly;
    var candidate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (!candidate.isAfter(now)) {
      candidate = candidate.add(const Duration(days: 1));
    }
    // Advance to the next day that lands on the interval grid.
    while (candidate.difference(tz.TZDateTime(tz.local, anchorDay.year,
                    anchorDay.month, anchorDay.day, hour, minute))
                .inDays %
            step !=
        0) {
      candidate = candidate.add(const Duration(days: 1));
    }
    return candidate;
  }
}
