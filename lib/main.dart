import 'package:flutter/material.dart';

import 'app.dart';
import 'data/database/database.dart';
import 'data/repositories/goal_repository.dart';
import 'data/repositories/habit_repository.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Local-first: a single on-device SQLite database, no network (NFR-2.1).
  final database = AppDatabase();

  final notifications = NotificationService();
  await notifications.init();

  final habitRepository = HabitRepository(database.habitDao, notifications);
  final goalRepository = GoalRepository(database.goalDao);

  // Route "Accomplished"/"Skipped" taps from a reminder to today's log.
  notifications.onHabitAction = (habitId, status) =>
      habitRepository.logHabit(habitId, DateTime.now(), status);

  // If a notification action launched the app, apply it now.
  await notifications.processLaunchAction();
  // Ask for permission, then (re)arm reminders for all active habits.
  await notifications.requestPermissions();
  await habitRepository.rescheduleAll();

  runApp(
    AtomicHabitsApp(
      database: database,
      notifications: notifications,
      habitRepository: habitRepository,
      goalRepository: goalRepository,
    ),
  );
}
