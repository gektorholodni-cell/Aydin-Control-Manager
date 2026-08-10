import 'package:flutter/material.dart';

import '../../../../core/localization/context_l10n.dart';
import '../../domain/enums/project_status.dart';

class ProjectStatusChip extends StatelessWidget {
  const ProjectStatusChip({required this.status, super.key});

  final ProjectStatus status;

  @override
  Widget build(BuildContext context) {
    final style = _statusStyle(status);

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
      case ProjectStatus.planning:
        return l10n.projectStatusPlanning;
      case ProjectStatus.onTrack:
        return l10n.projectStatusOnTrack;
      case ProjectStatus.atRisk:
        return l10n.projectStatusAtRisk;
      case ProjectStatus.delayed:
        return l10n.projectStatusDelayed;
      case ProjectStatus.completed:
        return l10n.projectStatusCompleted;
    }
  }

  _StatusStyle _statusStyle(ProjectStatus value) {
    switch (value) {
      case ProjectStatus.planning:
        return const _StatusStyle(
          background: Color(0xFFE8F0FE),
          foreground: Color(0xFF174EA6),
        );
      case ProjectStatus.onTrack:
        return const _StatusStyle(
          background: Color(0xFFE8F5E9),
          foreground: Color(0xFF2E7D32),
        );
      case ProjectStatus.atRisk:
        return const _StatusStyle(
          background: Color(0xFFFFF8E1),
          foreground: Color(0xFFF57F17),
        );
      case ProjectStatus.delayed:
        return const _StatusStyle(
          background: Color(0xFFFFEBEE),
          foreground: Color(0xFFC62828),
        );
      case ProjectStatus.completed:
        return const _StatusStyle(
          background: Color(0xFFE0F2F1),
          foreground: Color(0xFF00695C),
        );
    }
  }
}

class _StatusStyle {
  const _StatusStyle({required this.background, required this.foreground});

  final Color background;
  final Color foreground;
}
