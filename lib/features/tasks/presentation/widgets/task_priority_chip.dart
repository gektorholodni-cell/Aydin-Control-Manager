import 'package:flutter/material.dart';

import '../../../../core/localization/context_l10n.dart';
import '../../domain/enums/task_priority.dart';

class TaskPriorityChip extends StatelessWidget {
  const TaskPriorityChip({required this.priority, super.key});

  final TaskPriority priority;

  @override
  Widget build(BuildContext context) {
    final style = _styleFor(priority);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: style.background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        _localizedPriority(context),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: style.foreground,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }

  String _localizedPriority(BuildContext context) {
    final l10n = context.l10n;

    switch (priority) {
      case TaskPriority.low:
        return l10n.taskPriorityLow;
      case TaskPriority.medium:
        return l10n.taskPriorityMedium;
      case TaskPriority.high:
        return l10n.taskPriorityHigh;
      case TaskPriority.critical:
        return l10n.taskPriorityCritical;
    }
  }

  _PriorityStyle _styleFor(TaskPriority value) {
    switch (value) {
      case TaskPriority.low:
        return const _PriorityStyle(
          background: Color(0xFFE8F5E9),
          foreground: Color(0xFF2E7D32),
        );
      case TaskPriority.medium:
        return const _PriorityStyle(
          background: Color(0xFFFFF8E1),
          foreground: Color(0xFFF57F17),
        );
      case TaskPriority.high:
        return const _PriorityStyle(
          background: Color(0xFFFFF3E0),
          foreground: Color(0xFFEF6C00),
        );
      case TaskPriority.critical:
        return const _PriorityStyle(
          background: Color(0xFFFFEBEE),
          foreground: Color(0xFFC62828),
        );
    }
  }
}

class _PriorityStyle {
  const _PriorityStyle({required this.background, required this.foreground});

  final Color background;
  final Color foreground;
}
