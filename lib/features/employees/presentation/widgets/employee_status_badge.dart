import 'package:flutter/material.dart';

import '../../../../core/localization/context_l10n.dart';

class EmployeeStatusBadge extends StatelessWidget {
  const EmployeeStatusBadge({required this.isOnline, super.key});

  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final backgroundColor = isOnline
        ? Colors.green.withValues(alpha: 0.14)
        : colorScheme.surfaceContainerHighest;
    final foregroundColor = isOnline ? Colors.green.shade800 : colorScheme.onSurfaceVariant;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        isOnline ? context.l10n.statusOnline : context.l10n.statusOffline,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: foregroundColor,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
