import 'package:flutter/material.dart';

import '../../../../core/localization/context_l10n.dart';
import '../../domain/entities/construction_task.dart';
import '../../domain/enums/task_status.dart';
import 'task_formatters.dart';
import 'task_priority_chip.dart';
import 'task_status_chip.dart';

class TaskKanbanBoard extends StatelessWidget {
  const TaskKanbanBoard({
    required this.tasks,
    required this.onTaskMoved,
    super.key,
  });

  final List<ConstructionTask> tasks;
  final void Function(String taskId, TaskStatus newStatus) onTaskMoved;

  @override
  Widget build(BuildContext context) {
    final statuses = <TaskStatus>[
      TaskStatus.notStarted,
      TaskStatus.inProgress,
      TaskStatus.waiting,
      TaskStatus.inspection,
      TaskStatus.completed,
    ];

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final narrow = constraints.maxWidth < 1100;
        if (narrow) {
          return ListView.separated(
            padding: const EdgeInsets.only(bottom: 100),
            itemCount: statuses.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (BuildContext context, int index) {
              final status = statuses[index];
              return _KanbanColumn(
                status: status,
                tasks: tasks.where((task) => task.status == status).toList(growable: false),
                onTaskMoved: onTaskMoved,
              );
            },
          );
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: statuses
                .map(
                  (status) => SizedBox(
                    width: 320,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: _KanbanColumn(
                        status: status,
                        tasks: tasks.where((task) => task.status == status).toList(growable: false),
                        onTaskMoved: onTaskMoved,
                      ),
                    ),
                  ),
                )
                .toList(growable: false),
          ),
        );
      },
    );
  }
}

class _KanbanColumn extends StatelessWidget {
  const _KanbanColumn({
    required this.status,
    required this.tasks,
    required this.onTaskMoved,
  });

  final TaskStatus status;
  final List<ConstructionTask> tasks;
  final void Function(String taskId, TaskStatus newStatus) onTaskMoved;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return DragTarget<ConstructionTask>(
      onAcceptWithDetails: (details) {
        if (details.data.status != status) {
          onTaskMoved(details.data.id, status);
        }
      },
      builder: (BuildContext context, List<ConstructionTask?> candidateData, List<dynamic> rejectedData) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _statusLabel(l10n, status),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 12,
                      child: Text('${tasks.length}', style: Theme.of(context).textTheme.labelSmall),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (tasks.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: Text(l10n.kanbanDropTasksHere)),
                  )
                else
                  ...tasks.map(
                    (task) => LongPressDraggable<ConstructionTask>(
                      data: task,
                      feedback: Material(
                        color: Colors.transparent,
                        child: SizedBox(
                          width: 280,
                          child: _KanbanTaskCard(task: task),
                        ),
                      ),
                      childWhenDragging: Opacity(
                        opacity: 0.35,
                        child: _KanbanTaskCard(task: task),
                      ),
                      child: _KanbanTaskCard(task: task),
                    ),
                  ),
                if (candidateData.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    height: 56,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(child: Text(l10n.kanbanReleaseToMove)),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _statusLabel(dynamic l10n, TaskStatus value) {
    switch (value) {
      case TaskStatus.notStarted:
        return l10n.kanbanPlanned;
      case TaskStatus.inProgress:
        return l10n.kanbanInProgress;
      case TaskStatus.waiting:
        return l10n.kanbanWaiting;
      case TaskStatus.inspection:
        return l10n.kanbanInspection;
      case TaskStatus.completed:
        return l10n.kanbanCompleted;
    }
  }
}

class _KanbanTaskCard extends StatelessWidget {
  const _KanbanTaskCard({required this.task});

  final ConstructionTask task;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              task.title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: <Widget>[
                TaskPriorityChip(priority: task.priority),
                TaskStatusChip(status: task.status),
                _MiniPill(icon: Icons.person_outline, label: task.assignedEmployee),
                _MiniPill(icon: Icons.business_outlined, label: task.project),
                _MiniPill(icon: Icons.event_outlined, label: formatTaskDate(task.deadline, locale: locale)),
                _MiniPill(icon: Icons.photo_camera_outlined, label: '${task.beforePhotos.length + task.afterPhotos.length}'),
                _MiniPill(icon: Icons.comment_outlined, label: '${task.comments.length}'),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.commonProgressValue(formatTaskProgress(task.progress)),
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 6),
            LinearProgressIndicator(value: task.progress, minHeight: 8),
          ],
        ),
      ),
    );
  }
}

class _MiniPill extends StatelessWidget {
  const _MiniPill({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 13),
          const SizedBox(width: 5),
          Text(label, style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
    );
  }
}
