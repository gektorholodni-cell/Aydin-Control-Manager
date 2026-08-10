import 'package:flutter/material.dart';

import '../../../../core/localization/context_l10n.dart';
import '../../data/repositories/mock_task_repository.dart';
import '../../domain/enums/task_status.dart';
import '../widgets/task_detail_section_card.dart';
import '../widgets/task_formatters.dart';
import '../widgets/task_people_wrap.dart';
import '../widgets/task_priority_chip.dart';
import '../widgets/task_status_chip.dart';
import '../widgets/task_timeline_list.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({required this.taskId, super.key});

  final String taskId;

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  late final _task = const MockTaskRepository().getTaskById(widget.taskId);
  late TaskStatus _status;

  @override
  void initState() {
    super.initState();
    _status = _task?.status ?? TaskStatus.notStarted;
  }

  void _changeStatus() {
    final currentIndex = TaskStatus.values.indexOf(_status);
    final nextIndex = (currentIndex + 1) % TaskStatus.values.length;

    setState(() {
      _status = TaskStatus.values[nextIndex];
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.taskStatusChangedLocal(_localizedStatus(context, _status)))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    final task = _task;
    if (task == null) {
      return Scaffold(
        appBar: AppBar(title: Text(context.l10n.taskDetailsTitle)),
        body: Center(
          child: Text(
            context.l10n.taskNotFound,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.taskDetailsTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: <Widget>[
          Text(
            task.title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              TaskPriorityChip(priority: task.priority),
              TaskStatusChip(status: _status),
              Chip(label: Text(task.project)),
              Chip(label: Text(context.l10n.taskDeadlineValue(formatTaskDate(task.deadline, locale: locale)))),
            ],
          ),
          const SizedBox(height: 14),
          TaskDetailSectionCard(
            title: context.l10n.taskFullDescription,
            child: Text(task.description, style: Theme.of(context).textTheme.bodyLarge),
          ),
          const SizedBox(height: 12),
          TaskDetailSectionCard(
            title: context.l10n.taskAssignedEmployees,
            child: TaskPeopleWrap(people: task.assignedEmployees),
          ),
          const SizedBox(height: 12),
          TaskDetailSectionCard(
            title: context.l10n.commonProgress,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  context.l10n.commonProgressValue(formatTaskProgress(task.progress)),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: LinearProgressIndicator(value: task.progress, minHeight: 10),
                ),
                const SizedBox(height: 10),
                Text(
                  context.l10n.taskEstimatedCostValue(formatTaskMoney(task.estimatedCost, locale: locale)),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          TaskDetailSectionCard(
            title: context.l10n.taskComments,
            child: Column(
              children: task.comments
                  .map(
                    (String comment) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Icon(Icons.comment_outlined, size: 18),
                          const SizedBox(width: 8),
                          Expanded(child: Text(comment)),
                        ],
                      ),
                    ),
                  )
                  .toList(growable: false),
            ),
          ),
          const SizedBox(height: 12),
          TaskDetailSectionCard(
            title: context.l10n.taskActivityHistory,
            child: TaskTimelineList(items: task.activityHistory),
          ),
          const SizedBox(height: 12),
          TaskDetailSectionCard(
            title: context.l10n.taskBeforePhotos,
            child: _AttachmentListSummary(items: task.beforePhotos, icon: Icons.photo_camera_outlined),
          ),
          const SizedBox(height: 12),
          TaskDetailSectionCard(
            title: context.l10n.taskAfterPhotos,
            child: _AttachmentListSummary(items: task.afterPhotos, icon: Icons.photo_outlined),
          ),
          const SizedBox(height: 12),
          TaskDetailSectionCard(
            title: context.l10n.tabDocuments,
            child: _AttachmentListSummary(items: task.documents, icon: Icons.description_outlined),
          ),
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: _changeStatus,
            icon: const Icon(Icons.sync_alt),
            label: Text(context.l10n.taskChangeStatus),
          ),
        ],
      ),
    );
  }

  String _localizedStatus(BuildContext context, TaskStatus status) {
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
}

class _AttachmentListSummary extends StatelessWidget {
  const _AttachmentListSummary({
    required this.items,
    required this.icon,
  });

  final List<String> items;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Text(
        context.l10n.commonNoItemsYet,
        style: Theme.of(context).textTheme.bodyMedium,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '${items.length} ${context.l10n.commonRecentUpdates.toLowerCase()}',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: 8),
        ...items.map(
          (String item) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: <Widget>[
                Icon(icon, size: 18),
                const SizedBox(width: 8),
                Expanded(child: Text(item)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
