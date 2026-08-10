import 'package:flutter/material.dart';

import '../../../../core/localization/context_l10n.dart';
import '../../domain/entities/employee.dart';

class EmployeeDetailInfoCard extends StatelessWidget {
  const EmployeeDetailInfoCard({required this.employee, super.key});

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            _InfoRow(label: l10n.commonPhone, value: employee.phone, icon: Icons.phone),
            const Divider(height: 24),
            _InfoRow(label: l10n.commonEmail, value: employee.email, icon: Icons.mail_outline),
            const Divider(height: 24),
            _InfoRow(
              label: l10n.currentProjectTitle,
              value: employee.currentProject,
              icon: Icons.apartment_outlined,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(label, style: textTheme.labelMedium),
              const SizedBox(height: 2),
              Text(value, style: textTheme.bodyLarge),
            ],
          ),
        ),
      ],
    );
  }
}
