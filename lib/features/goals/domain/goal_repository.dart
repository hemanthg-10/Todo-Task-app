import 'package:taskstreak/data/database/app_database.dart';

abstract interface class GoalRepository {
  Stream<List<Goal>> watchGoals();
  Future<void> setTarget(String type, int targetCount);
}
