import 'package:taskstreak/data/database/app_database.dart';

abstract interface class StreakRepository {
  Stream<List<Streak>> watchAll();
  Future<void> recordDay({
    required DateTime localDate,
    required int tasksCompleted,
    required int dailyGoal,
  });
}
