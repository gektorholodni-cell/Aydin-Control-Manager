import '../entities/construction_task.dart';

abstract interface class TaskRepository {
  List<ConstructionTask> getTasks();

  ConstructionTask? getTaskById(String id);

  void addTask(ConstructionTask task);
}
