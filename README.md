# Atomic Habits

A **local-first**, offline habit & goal tracker built with Flutter. All data lives
on the device in a local SQLite database — there is no backend and nothing is
sent to any server (per the [SRS](atomic_habits_srs.md)).

## Features

| Module | What it does | SRS |
| --- | --- | --- |
| **Today (Habits)** | Create habits with a name, category, target time and frequency (daily / specific weekdays / every N days). Mark each Accomplished or Skipped for any day this week. | FR-1.x, FR-2.2, FR-3.2 |
| **Reminders / Alarms** | Schedules alarm-style local notifications at each habit's target time, with **Accomplished** / **Skipped** actions, designed to fire even when the app is closed. | FR-2.x, NFR-1.1 |
| **Calendar** | Month view where every day is colour-coded by completion (all done / partial / missed), with a per-day breakdown you can edit inline. | FR-3.1 |
| **Goals** | Long-term goals defined by a start value, target value, unit and timeline, broken into **deliverables** — each with its own frequency and an *expected input* metric. | FR-4.x, FR-5.1 |
| **Deliverable logging** | Recording a deliverable prompts for its expected input (e.g. duration of a run) and stores the metric linked to the deliverable and goal. | FR-5.2 |
| **Dashboard** | Habit streaks, weekly/monthly completion %, a 7-day trend chart, and each goal's metric progress toward its target. | FR-6.x |

## Architecture

Local-first, layered, `provider` for state management:

```
lib/
  core/            constants (enums), theme, date/format utilities
  data/
    database/      Drift tables, DAOs, generated code  (SQLite)
    repositories/  habit & goal repositories (coordinate DB + notifications)
  services/        notification_service.dart (flutter_local_notifications)
  providers/       ChangeNotifier view-models subscribing to Drift streams
  features/        habits / calendar / goals / dashboard / home UI
```

- **Persistence:** [Drift](https://drift.simonbinder.eu/) over SQLite. The schema is
  fully relational (`goals → deliverables → deliverable_logs`, `habits → habit_logs`)
  with cascade deletes and reactive streams so the calendar and dashboard update
  instantly on any write (NFR-3.1, NFR-3.2).
- **State:** the `provider` package. Services and repositories are provided via
  `Provider`; screen state via `ChangeNotifierProvider`; fine-grained lists via
  `StreamBuilder` on Drift streams.
- **Notifications:** `flutter_local_notifications` + `timezone` for exact,
  timezone-correct scheduling and actionable alarms.

## Getting started

```bash
flutter pub get
# Regenerate Drift code after changing any table:
dart run build_runner build
flutter run
```

Requires Flutter 3.44+ / Dart 3.12+. Targets Android 8.0+ (min SDK 26) and iOS 12+.
The Android build enables core-library desugaring (needed by
`flutter_local_notifications`) and declares the exact-alarm / boot / full-screen
permissions in `android/app/src/main/AndroidManifest.xml`.

## Reminders & alarms — reliability notes

- Reminders use a max-importance channel with a full-screen intent and are
  re-armed on every app launch and after device reboot (boot receiver).
- Notification permission is requested **in context** — when a habit with a
  reminder is saved — not at cold start (a splash-screen dialog gets dismissed,
  and Android silently auto-denies after two denials). If notifications are
  blocked, the Today screen shows a banner whose **Enable** action retries the
  dialog or deep-links to the app's notification settings; the state is
  re-checked on every app resume and reminders are re-armed once allowed.
- The app declares only `SCHEDULE_EXACT_ALARM` (requested at runtime), which is
  Google Play-compliant for a reminder app — not the restricted `USE_EXACT_ALARM`.
  When exact alarms are permitted the reminder fires at the precise minute
  (`exactAllowWhileIdle`); when the user declines, it degrades gracefully to an
  inexact alarm instead of failing.
- **Daily** and **specific-weekday** habits repeat automatically. **Every-N-days**
  habits are scheduled as a one-shot for the next due date and re-armed on the
  next app open (repeating interval alarms are a known limitation to revisit).
- Tapping an action while the app is alive writes the log immediately; if the app
  was terminated, the action is reconciled from the launch intent on next open.

## Testing

```bash
flutter test
```

Unit tests cover the recurrence/scheduling logic (`isDueOn`), weekday masks,
frequency summaries and metric formatting.

## Out of scope (V1)

CSV export and native health-app integration (Apple Health / Google Fit) — see
§5 of the SRS.
