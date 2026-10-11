import '../../features/photo_reports/domain/entities/photo_report.dart';
import '../../features/projects/domain/entities/construction_project.dart';
import '../../features/projects/domain/enums/project_status.dart';
import '../../features/tasks/domain/entities/construction_task.dart';
import '../../features/tasks/domain/enums/task_priority.dart';
import '../../features/tasks/domain/enums/task_status.dart';
import 'cloud_backend.dart';

// Преобразование строк таблиц Supabase (см. supabase/schema.sql)
// в сущности приложения и обратно.

CompanyMembership membershipFromRow(Map<String, dynamic> row) {
  final company = (row['companies'] as Map<String, dynamic>?) ?? const <String, dynamic>{};
  return CompanyMembership(
    companyId: company['id'] as String? ?? '',
    companyName: company['name'] as String? ?? '',
    inviteCode: company['invite_code'] as String? ?? '',
    fullName: row['full_name'] as String? ?? '',
    role: row['role'] as String? ?? '',
  );
}

ConstructionProject projectFromRow(Map<String, dynamic> row) {
  final createdAt = _date(row['created_at']) ?? DateTime.now();
  return ConstructionProject(
    id: row['id'] as String,
    name: row['name'] as String? ?? '',
    client: row['client'] as String? ?? '',
    address: row['address'] as String? ?? '',
    progress: _double(row['progress']),
    status: _enumByName(ProjectStatus.values, row['status'], ProjectStatus.planning),
    startDate: _date(row['start_date']) ?? createdAt,
    endDate: _date(row['end_date']) ?? createdAt,
    numberOfEmployees: (row['number_of_employees'] as num?)?.toInt() ?? 0,
    budget: _double(row['budget']),
    remainingBudget: _double(row['remaining_budget']),
    description: row['description'] as String? ?? '',
    currentStage: row['current_stage'] as String? ?? '',
    weather: 'N/A',
    lastActivity: row['last_activity'] as String? ?? '',
    recentUpdates: const <String>[],
  );
}

Map<String, dynamic> projectToRow(ConstructionProject project) {
  return <String, dynamic>{
    'id': project.id,
    'name': project.name,
    'client': project.client,
    'address': project.address,
    'progress': project.progress,
    'status': project.status.name,
    'start_date': project.startDate.toUtc().toIso8601String(),
    'end_date': project.endDate.toUtc().toIso8601String(),
    'number_of_employees': project.numberOfEmployees,
    'budget': project.budget,
    'remaining_budget': project.remainingBudget,
    'description': project.description,
    'current_stage': project.currentStage,
    'last_activity': project.lastActivity,
    'updated_at': DateTime.now().toUtc().toIso8601String(),
  };
}

ConstructionTask taskFromRow(Map<String, dynamic> row) {
  final createdAt = _date(row['created_at']) ?? DateTime.now();
  final assignee = row['assignee_name'] as String? ?? '';
  final projectName = row['project_name'] as String? ?? '';
  return ConstructionTask(
    id: row['id'] as String,
    title: row['title'] as String? ?? '',
    description: row['description'] as String? ?? '',
    priority: _enumByName(TaskPriority.values, row['priority'], TaskPriority.medium),
    status: _enumByName(TaskStatus.values, row['status'], TaskStatus.notStarted),
    assignedEmployeeId: assignee.isEmpty ? 'unassigned' : 'name-$assignee',
    assignedEmployee: assignee.isEmpty ? 'Не назначено' : assignee,
    assignedEmployees: assignee.isEmpty ? <String>[] : <String>[assignee],
    projectId: row['project_id'] as String? ?? projectName,
    project: projectName,
    deadline: _date(row['deadline']) ?? createdAt,
    startDate: _date(row['start_date']) ?? createdAt,
    progress: _double(row['progress']),
    estimatedCost: _double(row['estimated_cost']),
    updatedAt: _date(row['updated_at']) ?? createdAt,
    comments: <String>[],
    activityHistory: <String>[],
    beforePhotos: <String>[],
    afterPhotos: <String>[],
    documents: <String>[],
  );
}

Map<String, dynamic> taskToRow(ConstructionTask task) {
  return <String, dynamic>{
    'id': task.id,
    'project_id': task.projectId,
    'project_name': task.project,
    'title': task.title,
    'description': task.description,
    'priority': task.priority.name,
    'status': task.status.name,
    'assignee_name': task.assignedEmployees.isEmpty ? '' : task.assignedEmployee,
    'start_date': task.startDate.toUtc().toIso8601String(),
    'deadline': task.deadline.toUtc().toIso8601String(),
    'progress': task.progress,
    'estimated_cost': task.estimatedCost,
    'updated_at': task.updatedAt.toUtc().toIso8601String(),
  };
}

PhotoReport photoReportFromRow(Map<String, dynamic> row) {
  return PhotoReport(
    id: row['id'] as String,
    albumName: row['album_name'] as String? ?? '',
    projectName: row['project_name'] as String? ?? '',
    taskName: row['task_name'] as String? ?? '',
    employeeName: row['employee_name'] as String? ?? '',
    description: row['description'] as String? ?? '',
    dateTime: _date(row['created_at']) ?? DateTime.now(),
    locationPlaceholder: row['location'] as String? ?? '',
    beforePhotos: _stringList(row['before_photos']),
    afterPhotos: _stringList(row['after_photos']),
  );
}

Map<String, dynamic> photoReportToRow(PhotoReport report) {
  return <String, dynamic>{
    'id': report.id,
    'album_name': report.albumName,
    'project_name': report.projectName,
    'task_name': report.taskName,
    'employee_name': report.employeeName,
    'description': report.description,
    'location': report.locationPlaceholder,
    'before_photos': report.beforePhotos,
    'after_photos': report.afterPhotos,
  };
}

T _enumByName<T extends Enum>(List<T> values, Object? name, T fallback) {
  for (final value in values) {
    if (value.name == name) {
      return value;
    }
  }
  return fallback;
}

DateTime? _date(Object? value) {
  return value is String ? DateTime.tryParse(value)?.toLocal() : null;
}

double _double(Object? value) {
  return value is num ? value.toDouble() : double.tryParse('$value') ?? 0;
}

List<String> _stringList(Object? value) {
  return value is List ? value.map((Object? item) => '$item').toList() : <String>[];
}
