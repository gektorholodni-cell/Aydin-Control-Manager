import 'package:flutter/material.dart';

import '../../domain/entities/employee.dart';
import 'employee_avatar.dart';
import 'employee_status_badge.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({
    required this.employee,
    required this.onTap,
    super.key,
  });

  final Employee employee;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Hero(
                    tag: 'employee-avatar-${employee.id}',
                    child: EmployeeAvatar(initials: employee.initials),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          employee.fullName,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(employee.position, style: textTheme.bodyMedium),
                      ],
                    ),
                  ),
                  EmployeeStatusBadge(isOnline: employee.isOnline),
                ],
              ),
              const SizedBox(height: 14),
              _MetaLine(icon: Icons.phone_outlined, text: employee.phone),
              const SizedBox(height: 8),
              _MetaLine(
                icon: Icons.apartment_outlined,
                text: employee.currentProject,
              ),
              const SizedBox(height: 8),
              _MetaLine(
                icon: Icons.schedule_outlined,
                text: employee.lastActivity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetaLine extends StatelessWidget {
  const _MetaLine({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: <Widget>[
        Icon(icon, size: 18, color: colorScheme.onSurfaceVariant),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: textTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
