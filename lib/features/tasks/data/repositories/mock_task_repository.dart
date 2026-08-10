import '../../domain/entities/construction_task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/mock_tasks_data.dart';

class MockTaskRepository implements TaskRepository {
  const MockTaskRepository();

  @override
  List<ConstructionTask> getTasks() {
    return List<ConstructionTask>.from(mockTasks);
  }

  @override
  ConstructionTask? getTaskById(String id) {
    for (final task in mockTasks) {
      if (task.id == id) {
        return task;
      }
    }
    return null;
  }

  @override
  void addTask(ConstructionTask task) {
    mockTasks.insert(0, task);
  }
}
