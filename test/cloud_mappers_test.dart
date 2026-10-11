import 'package:flutter_test/flutter_test.dart';

import 'package:structra/core/backend/cloud_mappers.dart';
import 'package:structra/features/photo_reports/domain/entities/photo_report.dart';
import 'package:structra/features/tasks/domain/entities/construction_task.dart';
import 'package:structra/features/tasks/domain/enums/task_priority.dart';
import 'package:structra/features/tasks/domain/enums/task_status.dart';

void main() {
  test('task survives a round trip through a Supabase row', () {
    final task = ConstructionTask(
      id: 'tsk-1',
      title: 'Монтаж воздуховодов',
      description: 'Этаж 3',
      priority: TaskPriority.high,
      status: TaskStatus.inProgress,
      assignedEmployeeId: 'name-Иван',
      assignedEmployee: 'Иван',
      assignedEmployees: const <String>['Иван'],
      projectId: 'ЖК Нурлы',
      project: 'ЖК Нурлы',
      deadline: DateTime(2026, 11, 1),
      startDate: DateTime(2026, 10, 1),
      progress: 0.4,
      estimatedCost: 150000,
      updatedAt: DateTime(2026, 10, 11, 12),
      comments: const <String>[],
      activityHistory: const <String>[],
      beforePhotos: const <String>[],
      afterPhotos: const <String>[],
      documents: const <String>[],
    );

    final row = taskToRow(task)..['created_at'] = '2026-10-01T00:00:00Z';
    final restored = taskFromRow(row);

    expect(restored.title, task.title);
    expect(restored.priority, TaskPriority.high);
    expect(restored.status, TaskStatus.inProgress);
    expect(restored.assignedEmployee, 'Иван');
    expect(restored.project, 'ЖК Нурлы');
    expect(restored.deadline, task.deadline);
    expect(restored.estimatedCost, 150000);
  });

  test('unknown enum values fall back to defaults', () {
    final task = taskFromRow(<String, dynamic>{
      'id': 'x',
      'title': 't',
      'priority': 'urgent',
      'status': 'archived',
      'progress': '0.5',
    });

    expect(task.priority, TaskPriority.medium);
    expect(task.status, TaskStatus.notStarted);
    expect(task.progress, 0.5);
    expect(task.assignedEmployee, 'Не назначено');
  });

  test('photo report keeps storage paths', () {
    final report = PhotoReport(
      id: 'alb-1',
      albumName: 'Фасад',
      projectName: 'ЖК Нурлы',
      taskName: '—',
      employeeName: 'Иван',
      description: '',
      dateTime: DateTime(2026, 10, 11),
      locationPlaceholder: 'Блок А',
      beforePhotos: const <String>['c/alb-1/1.jpg'],
      afterPhotos: const <String>['c/alb-1/2.jpg'],
    );

    final restored = photoReportFromRow(photoReportToRow(report));

    expect(restored.beforePhotos, <String>['c/alb-1/1.jpg']);
    expect(restored.afterPhotos, <String>['c/alb-1/2.jpg']);
    expect(restored.albumName, 'Фасад');
  });

  test('membership reads nested company', () {
    final membership = membershipFromRow(<String, dynamic>{
      'full_name': 'Айдын',
      'role': 'director',
      'companies': <String, dynamic>{'id': 'c1', 'name': 'ТОО Строй', 'invite_code': 'AB12CD34'},
    });

    expect(membership.companyName, 'ТОО Строй');
    expect(membership.inviteCode, 'AB12CD34');
  });
}
