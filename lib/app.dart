import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'data/database/database.dart';
import 'data/repositories/goal_repository.dart';
import 'data/repositories/habit_repository.dart';
import 'features/home/home_screen.dart';
import 'providers/calendar_provider.dart';
import 'providers/dashboard_provider.dart';
import 'providers/goal_provider.dart';
import 'providers/habit_provider.dart';
import 'providers/reminder_permission_provider.dart';
import 'services/notification_service.dart';

/// Root widget. Wires the shared services + view-models into the widget tree
/// with `provider`, then hands off to the [HomeScreen] navigation shell.
class AtomicHabitsApp extends StatelessWidget {
  const AtomicHabitsApp({
    super.key,
    required this.database,
    required this.notifications,
    required this.habitRepository,
    required this.goalRepository,
  });

  final AppDatabase database;
  final NotificationService notifications;
  final HabitRepository habitRepository;
  final GoalRepository goalRepository;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppDatabase>.value(value: database),
        Provider<NotificationService>.value(value: notifications),
        Provider<HabitRepository>.value(value: habitRepository),
        Provider<GoalRepository>.value(value: goalRepository),
        ChangeNotifierProvider(create: (_) => HabitProvider(habitRepository)),
        ChangeNotifierProvider(
            create: (_) => CalendarProvider(habitRepository)),
        ChangeNotifierProvider(create: (_) => GoalProvider(goalRepository)),
        ChangeNotifierProvider(
            create: (_) => DashboardProvider(habitRepository)),
        ChangeNotifierProvider(
            create: (_) =>
                ReminderPermissionProvider(notifications, habitRepository)),
      ],
      child: MaterialApp(
        title: 'Atomic Habits',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: ThemeMode.system,
        home: const HomeScreen(),
      ),
    );
  }
}
