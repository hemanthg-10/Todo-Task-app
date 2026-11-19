import 'package:drift/drift.dart';
import 'package:taskstreak/data/database/app_database.dart';
import 'package:taskstreak/features/streak/domain/streak_repository.dart';

class LocalStreakRepository implements StreakRepository {
  LocalStreakRepository(this._db);
  final AppDatabase _db;

  @override
  Stream<List<Streak>> watchAll() => (_db.select(_db.streaks)
        ..orderBy([(day) => OrderingTerm.desc(day.date)]))
      .watch();

  @override
  Future<void> recordDay({
    required DateTime localDate,
    required int tasksCompleted,
    required int dailyGoal,
  }) async {
    if (tasksCompleted < 0 || dailyGoal < 1) {
      throw ArgumentError('Task count must be nonnegative and goal must be positive.');
    }
    final String key =
        '${localDate.year.toString().padLeft(4, '0')}-${localDate.month.toString().padLeft(2, '0')}-${localDate.day.toString().padLeft(2, '0')}';
    await _db.into(_db.streaks).insertOnConflictUpdate(
          StreaksCompanion.insert(
            date: key,
            tasksCompleted: Value<int>(tasksCompleted),
            goalMet: Value<bool>(tasksCompleted >= dailyGoal),
          ),
        );
  }
}
