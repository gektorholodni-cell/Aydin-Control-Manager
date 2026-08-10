import 'package:flutter/material.dart';

import '../../domain/entities/employee.dart';
import 'employee_avatar.dart';
import 'employee_status_badge.dart';

class EmployeeProfileHeaderCard extends StatelessWidget {
  const EmployeeProfileHeaderCard({required this.employee, super.key});

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: <Widget>[
            Hero(
              tag: 'employee-avatar-${employee.id}',
              child: EmployeeAvatar(initials: employee.initials, radius: 34),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    employee.fullName,
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(employee.position, style: textTheme.bodyLarge),
                  const SizedBox(height: 8),
                  EmployeeStatusBadge(isOnline: employee.isOnline),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
