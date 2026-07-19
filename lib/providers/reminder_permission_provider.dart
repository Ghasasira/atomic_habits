import 'package:flutter/widgets.dart';

import '../data/repositories/habit_repository.dart';
import '../services/notification_service.dart';

/// Tracks whether the OS will actually show habit reminders and drives the
/// "reminders are blocked" banner on the Today screen. Re-checks whenever the
/// app returns to the foreground, so flipping the toggle in system settings is
/// picked up immediately.
class ReminderPermissionProvider extends ChangeNotifier
    with WidgetsBindingObserver {
  ReminderPermissionProvider(this._notifications, this._habits) {
    WidgetsBinding.instance.addObserver(this);
    refresh();
  }

  final NotificationService _notifications;
  final HabitRepository _habits;

  // Optimistic default so the banner doesn't flash before the first check.
  bool _blocked = false;

  /// True when notifications are turned off for the app, i.e. reminders will
  /// silently not appear even though alarms fire.
  bool get remindersBlocked => _blocked;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) refresh();
  }

  Future<void> refresh() async {
    _setBlocked(!await _notifications.areNotificationsEnabled());
  }

  /// Asks for notification (and then exact-alarm) permission before arming a
  /// reminder. Returns true when notifications are permitted.
  Future<bool> ensurePermissions() async {
    final granted = await _notifications.requestPermissions();
    _setBlocked(!granted);
    return granted;
  }

  /// Banner action: try the system dialog first; when Android refuses to show
  /// it again (permanent denial), open the app's notification settings so the
  /// user can flip the toggle themselves. [refresh] runs on resume, so the
  /// banner clears as soon as they come back with it enabled.
  Future<void> enableReminders() async {
    final granted = await _notifications.requestPermissions();
    if (granted) {
      _setBlocked(false);
    } else {
      await _notifications.openNotificationSettings();
    }
  }

  void _setBlocked(bool value) {
    if (_blocked == value) return;
    _blocked = value;
    notifyListeners();
    if (!value) {
      // Reminders armed while blocked used inexact alarms; re-arm them now
      // that they can fire (and exact scheduling may have been granted).
      _habits.rescheduleAll();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
