import 'package:flutter/material.dart';

import '../../../../core/localization/context_l10n.dart';

class EmployeeNotesCard extends StatelessWidget {
  const EmployeeNotesCard({required this.notes, super.key});

  final String notes;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              context.l10n.employeePersonalNotes,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 10),
            Text(notes, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
