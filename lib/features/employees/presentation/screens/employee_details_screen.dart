import 'package:flutter/material.dart';

import '../../../tasks/data/repositories/mock_task_repository.dart';
import '../../../tasks/domain/enums/task_status.dart';

import '../../../../core/localization/context_l10n.dart';
import '../../data/repositories/mock_employee_repository.dart';
import '../widgets/employee_detail_info_card.dart';
import '../widgets/employee_notes_card.dart';
import '../widgets/employee_profile_header_card.dart';
import '../widgets/employee_task_summary_card.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  const EmployeeDetailsScreen({required this.employeeId, super.key});

  final String employeeId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final repository = const MockEmployeeRepository();
    final employee = repository.getEmployeeById(employeeId);
    final assignedTasks = const MockTaskRepository()
      .getTasks()
      .where((task) => task.assignedEmployeeId == employeeId)
      .toList(growable: false);
    final assignedProjects = assignedTasks.map((task) => task.project).toSet().toList(growable: false);
    final activeTasks = assignedTasks.where((task) => task.status != TaskStatus.completed).length;
    final completed = assignedTasks.where((task) => task.progress >= 1).length;
    final total = assignedTasks.length;
    final performance = total == 0 ? 0 : (completed / total * 100).round();

    if (employee == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.employeeDetailsTitle)),
        body: Center(
          child: Text(
            l10n.employeeNotFound,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.employeeDetailsTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
        children: <Widget>[
          EmployeeProfileHeaderCard(employee: employee),
          const SizedBox(height: 14),
          EmployeeDetailInfoCard(employee: employee),
          const SizedBox(height: 14),
          EmployeeTaskSummaryCard(employee: employee),
          const SizedBox(height: 14),
          EmployeeNotesCard(notes: employee.personalNotes),
          const SizedBox(height: 14),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    l10n.employeeAssignedProjectsTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: assignedProjects
                        .map((project) => Chip(label: Text(project)))
                        .toList(growable: false),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Card(
            child: ListTile(
              leading: const Icon(Icons.fact_check_outlined),
              title: Text(l10n.employeeAssignedTasksTitle),
              subtitle: Text('$total'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.task_alt_outlined),
              title: Text(l10n.employeeCompletedTasksTitle),
              subtitle: Text('$completed'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.trending_up_outlined),
              title: Text(l10n.employeePerformanceTitle),
              subtitle: Text('$performance%'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.badge_outlined),
              title: Text(l10n.employeeAttendancePlaceholderTitle),
              subtitle: Text('$activeTasks ${l10n.employeeAssignedTasksTitle.toLowerCase()}'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.schedule_outlined),
              title: Text(l10n.employeeWorkingHoursPlaceholderTitle),
              subtitle: Text('${assignedProjects.length} ${l10n.employeeAssignedProjectsTitle.toLowerCase()}'),
            ),
          ),
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n.employeeContactReady(employee.fullName)),
                ),
              );
            },
            icon: const Icon(Icons.call),
            label: Text(l10n.commonContact),
          ),
        ],
      ),
    );
  }
}
