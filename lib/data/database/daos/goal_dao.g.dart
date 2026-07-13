// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_dao.dart';

// ignore_for_file: type=lint
mixin _$GoalDaoMixin on DatabaseAccessor<AppDatabase> {
  $GoalsTable get goals => attachedDatabase.goals;
  $DeliverablesTable get deliverables => attachedDatabase.deliverables;
  $DeliverableLogsTable get deliverableLogs => attachedDatabase.deliverableLogs;
  GoalDaoManager get managers => GoalDaoManager(this);
}

class GoalDaoManager {
  final _$GoalDaoMixin _db;
  GoalDaoManager(this._db);
  $$GoalsTableTableManager get goals =>
      $$GoalsTableTableManager(_db.attachedDatabase, _db.goals);
  $$DeliverablesTableTableManager get deliverables =>
      $$DeliverablesTableTableManager(_db.attachedDatabase, _db.deliverables);
  $$DeliverableLogsTableTableManager get deliverableLogs =>
      $$DeliverableLogsTableTableManager(
        _db.attachedDatabase,
        _db.deliverableLogs,
      );
}
