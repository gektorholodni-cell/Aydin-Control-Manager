import '../enums/task_priority.dart';
import '../enums/task_status.dart';

class ConstructionTask {
  const ConstructionTask({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.assignedEmployeeId,
    required this.assignedEmployee,
    required this.assignedEmployees,
    required this.projectId,
    required this.project,
    required this.deadline,
    required this.startDate,
    required this.progress,
    required this.estimatedCost,
    required this.updatedAt,
    required this.comments,
    required this.activityHistory,
    required this.beforePhotos,
    required this.afterPhotos,
    required this.documents,
  });

  final String id;
  final String title;
  final String description;
  final TaskPriority priority;
  final TaskStatus status;
  final String assignedEmployeeId;
  final String assignedEmployee;
  final List<String> assignedEmployees;
  final String projectId;
  final String project;
  final DateTime deadline;
  final DateTime startDate;
  final double progress;
  final double estimatedCost;
  final DateTime updatedAt;
  final List<String> comments;
  final List<String> activityHistory;
  final List<String> beforePhotos;
  final List<String> afterPhotos;
  final List<String> documents;

  ConstructionTask copyWith({
    TaskStatus? status,
    double? progress,
    DateTime? updatedAt,
  }) {
    return ConstructionTask(
      id: id,
      title: title,
      description: description,
      priority: priority,
      status: status ?? this.status,
      assignedEmployeeId: assignedEmployeeId,
      assignedEmployee: assignedEmployee,
      assignedEmployees: assignedEmployees,
      projectId: projectId,
      project: project,
      deadline: deadline,
      startDate: startDate,
      progress: progress ?? this.progress,
      estimatedCost: estimatedCost,
      updatedAt: updatedAt ?? this.updatedAt,
      comments: comments,
      activityHistory: activityHistory,
      beforePhotos: beforePhotos,
      afterPhotos: afterPhotos,
      documents: documents,
    );
  }
}
