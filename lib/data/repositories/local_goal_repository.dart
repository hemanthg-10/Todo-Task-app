import 'package:drift/drift.dart';
import 'package:taskstreak/data/database/app_database.dart';
import 'package:taskstreak/features/goals/domain/goal_repository.dart';

class LocalGoalRepository implements GoalRepository {
  LocalGoalRepository(this._db);
  final AppDatabase _db;

  @override
  Stream<List<Goal>> watchGoals() => (_db.select(_db.goals)
        ..orderBy([(goal) => OrderingTerm.asc(goal.type)]))
      .watch();

  @override
  Future<void> setTarget(String type, int targetCount) async {
    if (type != 'daily' && type != 'weekly') {
      throw ArgumentError.value(type, 'type', 'Expected daily or weekly.');
    }
    final int maximum = type == 'daily' ? 20 : 140;
    if (targetCount < 1 || targetCount > maximum) {
      throw RangeError.range(targetCount, 1, maximum, 'targetCount');
    }
    final Goal? existing = await (_db.select(_db.goals)
          ..where((goal) => goal.type.equals(type)))
        .getSingleOrNull();
    if (existing == null) {
      await _db.into(_db.goals).insert(
            GoalsCompanion.insert(type: type, targetCount: targetCount),
          );
    } else {
      await (_db.update(_db.goals)..where((goal) => goal.id.equals(existing.id))).write(
        GoalsCompanion(
          targetCount: Value<int>(targetCount),
          updatedAt: Value<DateTime>(DateTime.now()),
        ),
      );
    }
  }
}
