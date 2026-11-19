import 'package:taskstreak/data/database/app_database.dart';

abstract interface class TaskRepository {
  Stream<List<Task>> watchAll();
  Future<int> addTask(TasksCompanion task);
  Future<void> updateTask(TasksCompanion task);
  Future<void> deleteTask(int id);
  Future<void> setCompleted(int id, bool isDone, {DateTime? completedAt});
}
