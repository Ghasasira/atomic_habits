# Software Requirements Specification (SRS)
## Project Name: Atomic Habits
**Version:** 1.0
**Platform:** iOS & Android (Flutter)
**Architecture:** Local-First / No Backend

---

## 1. Introduction

### 1.1 Purpose
This document specifies the software requirements for "Atomic Habits", a mobile application built exclusively with Flutter. The application operates entirely client-side without a backend, aiming to help users model and adopt specific habits (e.g., working out, drinking water) and track long-term goals with measurable deliverables.

### 1.2 Scope
The application will provide comprehensive habit tracking, goal setting, local calendar management, and a performance dashboard. It will utilize local storage for all data persistence and device-level background services to trigger scheduled alarms/reminders.

---

## 2. Overall Description

### 2.1 User Perspective
The app serves as a personal, offline-first productivity and self-improvement assistant. Users will interact with three main modules:
1. **Habit Tracker:** Daily/recurring tasks with specific time triggers.
2. **Goal Manager:** Long-term objectives with structured milestones, deliverables, and metric-based inputs.
3. **Performance Dashboard:** Visual analytics of calendar completion rates and goal progress.

### 2.2 Operating Environment
* **Framework:** Flutter (Dart)
* **OS:** iOS 12.0+ and Android 8.0+
* **Storage:** Local Database (e.g., Hive, Isar, or SQLite)
* **Background Execution:** Required for precise alarm ringing and notification delivery.

---

## 3. Functional Requirements

### 3.1 Habit Management
* **FR-1.1:** The system shall allow users to create a habit by defining a name, category, and target execution time.
* **FR-1.2:** The system shall allow users to set the frequency of the habit (e.g., daily, specific days of the week).
* **FR-1.3:** The system shall allow users to edit or delete existing habits.

### 3.2 Reminder & Alarm System
* **FR-2.1:** The system shall trigger an audible alarm (ringing) on the device when the exact time for a scheduled habit is reached.
* **FR-2.2:** The system shall provide actionable notifications allowing the user to mark the habit as "Accomplished" or "Skipped" directly from the alarm prompt or within the app.

### 3.3 Calendar Tracking
* **FR-3.1:** The system shall display a calendar view where days are color-coded or marked based on the completion status of daily habits.
* **FR-3.2:** The system shall log the timestamp and status (Skipped/Accomplished) of every habit instance into the local database.

### 3.4 Goal Setting & Management
* **FR-4.1:** The system shall allow users to create a Goal defined by a Starting Point, Ending Point/Target, and a timeline.
* **FR-4.2:** The system shall allow users to attach specific "Deliverables" (steps) to a goal (e.g., Goal: Lose Weight -> Deliverable 1: 10 push-ups daily; Deliverable 2: Run 3km every 3 days).
* **FR-4.3:** The system shall allow setting the frequency for each deliverable independently of the overarching goal.

### 3.5 Deliverable Execution & Input Tracking
* **FR-5.1:** The system shall prompt the user for an "Expected Input" upon completion of a specific deliverable (e.g., requesting the duration taken to complete a 3km run).
* **FR-5.2:** The system shall store this metric data locally and link it to the specific deliverable and overarching goal for progress tracking.

### 3.6 Performance Dashboard
* **FR-6.1:** The system shall provide a dashboard visualizing habit adherence over time (e.g., streaks, weekly completion percentages).
* **FR-6.2:** The system shall display the progression of active goals, mapping the expected inputs (metrics) against the Ending Point target.

---

## 4. Non-Functional Requirements

### 4.1 Performance & Reliability
* **NFR-1.1:** Alarms must trigger reliably even if the app is terminated or the device is locked, utilizing native background scheduling (`alarm` or `flutter_local_notifications` plugins).
* **NFR-1.2:** The UI must maintain a smooth 60fps rendering since all data fetching is synchronous or near-synchronous from local storage.

### 4.2 Data Privacy & Storage
* **NFR-2.1:** All user data, including habit histories and goal metrics, must be stored purely locally. No data shall be transmitted to external servers.
* **NFR-2.2:** Data backups (if implemented) must rely on standard OS-level local backup mechanisms or explicit manual JSON/CSV exports.

### 4.3 Architecture & Maintainability
* **NFR-3.1:** The codebase should employ a robust local state management solution (e.g., Riverpod, Bloc) to efficiently reflect calendar updates and dashboard UI changes immediately upon user input.
* **NFR-3.2:** Database schemas must be designed to efficiently query historical relational data (e.g., fetching all deliverables tied to a goal, or all inputs tied to a deliverable) for the dashboard engine.

---

## 5. Future Enhancements (Out of Scope for V1)
* Exporting data to CSV for personal external analysis.
* Integration with native OS health apps (Apple Health, Google Fit) to automatically populate expected inputs (e.g., steps, running distance).
