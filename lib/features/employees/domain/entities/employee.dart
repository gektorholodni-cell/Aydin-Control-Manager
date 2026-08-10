import '../enums/employee_role.dart';

class Employee {
  const Employee({
    required this.id,
    required this.fullName,
    required this.role,
    required this.position,
    required this.isOnline,
    required this.phone,
    required this.email,
    required this.currentProject,
    required this.lastActivity,
    required this.assignedTasks,
    required this.completedTasks,
    required this.personalNotes,
  });

  final String id;
  final String fullName;
  final EmployeeRole role;
  final String position;
  final bool isOnline;
  final String phone;
  final String email;
  final String currentProject;
  final String lastActivity;
  final int assignedTasks;
  final int completedTasks;
  final String personalNotes;

  String get initials {
    final parts = fullName.trim().split(' ');
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }

    final first = parts.first.substring(0, 1).toUpperCase();
    final last = parts.last.substring(0, 1).toUpperCase();
    return '$first$last';
  }
}
