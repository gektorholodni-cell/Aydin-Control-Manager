import 'package:flutter/material.dart';

import '../../../../core/localization/context_l10n.dart';
import '../../domain/enums/task_status.dart';

class TaskStatusChip extends StatelessWidget {
  const TaskStatusChip({required this.status, super.key});

  final TaskStatus status;

  @override
  Widget build(BuildContext context) {
    final style = _styleFor(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: style.background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        _localizedStatus(context),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: style.foreground,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }

  String _localizedStatus(BuildContext context) {
    final l10n = context.l10n;

    switch (status) {
      case TaskStatus.notStarted:
        return l10n.taskStatusNotStarted;
      case TaskStatus.inProgress:
        return l10n.taskStatusInProgress;
      case TaskStatus.waiting:
        return l10n.taskStatusWaiting;
      case TaskStatus.inspection:
        return l10n.taskStatusInspection;
      case TaskStatus.completed:
        return l10n.taskStatusCompleted;
    }
  }

  _StatusStyle _styleFor(TaskStatus value) {
    switch (value) {
      case TaskStatus.notStarted:
        return const _StatusStyle(
          background: Color(0xFFE8F0FE),
          foreground: Color(0xFF174EA6),
        );
      case TaskStatus.inProgress:
        return const _StatusStyle(
          background: Color(0xFFE0F7FA),
          foreground: Color(0xFF00838F),
        );
      case TaskStatus.waiting:
        return const _StatusStyle(
          background: Color(0xFFFFF8E1),
          foreground: Color(0xFFF57F17),
        );
      case TaskStatus.inspection:
        return const _StatusStyle(
          background: Color(0xFFEDE7F6),
          foreground: Color(0xFF5E35B1),
        );
      case TaskStatus.completed:
        return const _StatusStyle(
          background: Color(0xFFE8F5E9),
          foreground: Color(0xFF2E7D32),
        );
    }
  }
}

class _StatusStyle {
  const _StatusStyle({required this.background, required this.foreground});

  final Color background;
  final Color foreground;
}
