import 'package:drift/drift.dart';
import 'package:taskstreak/data/database/app_database.dart';
import 'package:taskstreak/features/tasks/domain/task_repository.dart';

class LocalTaskRepository implements TaskRepository {
  LocalTaskRepository(this._db);
  final AppDatabase _db;

  @override
  Stream<List<Task>> watchAll() => (_db.select(_db.tasks)
        ..orderBy([(t) => OrderingTerm.asc(t.dueAt)]))
      .watch();

  @override
  Future<int> addTask(TasksCompanion task) => _db.into(_db.tasks).insert(task);

  @override
  Future<void> updateTask(TasksCompanion task) async {
    if (!task.id.present) throw ArgumentError('An id is required to update a task.');
    await (_db.update(_db.tasks)..where((t) => t.id.equals(task.id.value)))
        .write(task);
  }

  @override
  Future<void> deleteTask(int id) async {
    await (_db.delete(_db.tasks)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<void> setCompleted(int id, bool isDone, {DateTime? completedAt}) async {
    await (_db.update(_db.tasks)..where((t) => t.id.equals(id))).write(
      TasksCompanion(
        isDone: Value<bool>(isDone),
        completedAt: Value<DateTime?>(isDone ? (completedAt ?? DateTime.now()) : null),
      ),
    );
  }
}
