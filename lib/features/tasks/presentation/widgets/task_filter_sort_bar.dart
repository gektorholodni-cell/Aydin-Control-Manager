import 'package:flutter/material.dart';

import '../../../../core/localization/context_l10n.dart';
import '../../domain/enums/task_priority.dart';
import '../../domain/enums/task_status.dart';

enum TaskSortOption {
  deadline,
  priority,
  recentlyUpdated,
}

extension TaskSortOptionX on TaskSortOption {
  String localizedLabel(BuildContext context) {
    final l10n = context.l10n;

    switch (this) {
      case TaskSortOption.deadline:
        return l10n.commonDeadline;
      case TaskSortOption.priority:
        return l10n.commonPriority;
      case TaskSortOption.recentlyUpdated:
        return l10n.sortRecentlyUpdated;
    }
  }
}

String _localizedTaskStatus(BuildContext context, TaskStatus status) {
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

String _localizedTaskPriority(BuildContext context, TaskPriority priority) {
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

class TaskFilterSortBar extends StatelessWidget {
  const TaskFilterSortBar({
    required this.projects,
    required this.employees,
    required this.selectedProject,
    required this.selectedEmployee,
    required this.selectedStatus,
    required this.selectedPriority,
    required this.selectedSort,
    required this.onProjectChanged,
    required this.onEmployeeChanged,
    required this.onStatusChanged,
    required this.onPriorityChanged,
    required this.onSortChanged,
    super.key,
  });

  final List<String> projects;
  final List<String> employees;
  final String? selectedProject;
  final String? selectedEmployee;
  final TaskStatus? selectedStatus;
  final TaskPriority? selectedPriority;
  final TaskSortOption selectedSort;

  final ValueChanged<String?> onProjectChanged;
  final ValueChanged<String?> onEmployeeChanged;
  final ValueChanged<TaskStatus?> onStatusChanged;
  final ValueChanged<TaskPriority?> onPriorityChanged;
  final ValueChanged<TaskSortOption> onSortChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final wide = constraints.maxWidth > 900;

        final fields = <Widget>[
          _StringDropdown(
            label: l10n.commonProject,
            selected: selectedProject,
            values: projects,
            allLabel: l10n.filterAllProjects,
            onChanged: onProjectChanged,
          ),
          _StringDropdown(
            label: l10n.commonEmployee,
            selected: selectedEmployee,
            values: employees,
            allLabel: l10n.filterAllEmployees,
            onChanged: onEmployeeChanged,
          ),
          _EnumDropdown<TaskStatus>(
            label: l10n.commonStatus,
            selected: selectedStatus,
            values: TaskStatus.values,
            allLabel: l10n.filterAllStatuses,
            getLabel: (TaskStatus status) => _localizedTaskStatus(context, status),
            onChanged: onStatusChanged,
          ),
          _EnumDropdown<TaskPriority>(
            label: l10n.commonPriority,
            selected: selectedPriority,
            values: TaskPriority.values,
            allLabel: l10n.filterAllPriorities,
            getLabel: (TaskPriority priority) => _localizedTaskPriority(context, priority),
            onChanged: onPriorityChanged,
          ),
          _EnumDropdown<TaskSortOption>(
            label: l10n.filterSortLabel,
            selected: selectedSort,
            values: TaskSortOption.values,
            allLabel: l10n.filterSortLabel,
            hasAllOption: false,
            getLabel: (TaskSortOption sort) => sort.localizedLabel(context),
            onChanged: (TaskSortOption? value) {
              if (value != null) {
                onSortChanged(value);
              }
            },
          ),
        ];

        if (wide) {
          return Wrap(spacing: 10, runSpacing: 10, children: fields);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: fields
              .map(
                (Widget item) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: item,
                ),
              )
              .toList(growable: false),
        );
      },
    );
  }
}

class _StringDropdown extends StatelessWidget {
  const _StringDropdown({
    required this.label,
    required this.selected,
    required this.values,
    required this.allLabel,
    required this.onChanged,
  });

  final String label;
  final String? selected;
  final List<String> values;
  final String allLabel;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String?>(
      initialSelection: selected,
      width: 240,
      label: Text(label),
      onSelected: onChanged,
      dropdownMenuEntries: <DropdownMenuEntry<String?>>[
        DropdownMenuEntry<String?>(value: null, label: allLabel),
        ...values.map(
          (String value) => DropdownMenuEntry<String?>(value: value, label: value),
        ),
      ],
    );
  }
}

class _EnumDropdown<T> extends StatelessWidget {
  const _EnumDropdown({
    required this.label,
    required this.selected,
    required this.values,
    required this.allLabel,
    required this.getLabel,
    required this.onChanged,
    this.hasAllOption = true,
  });

  final String label;
  final T? selected;
  final List<T> values;
  final String allLabel;
  final String Function(T value) getLabel;
  final ValueChanged<T?> onChanged;
  final bool hasAllOption;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T?>(
      initialSelection: selected,
      width: 240,
      label: Text(label),
      onSelected: onChanged,
      dropdownMenuEntries: <DropdownMenuEntry<T?>>[
        if (hasAllOption) DropdownMenuEntry<T?>(value: null, label: allLabel),
        ...values.map(
          (T value) => DropdownMenuEntry<T?>(
            value: value,
            label: getLabel(value),
          ),
        ),
      ],
    );
  }
}
