import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/localization/context_l10n.dart';
import '../../../projects/data/repositories/mock_project_repository.dart';
import '../../data/repositories/mock_task_repository.dart';
import '../../domain/entities/construction_task.dart';
import '../../domain/enums/task_priority.dart';
import '../../domain/enums/task_status.dart';
import '../widgets/task_attachment_placeholder_card.dart';
import '../widgets/task_formatters.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _assigneeController = TextEditingController();
  final _estimatedCostController = TextEditingController();
  final MockTaskRepository _taskRepository = const MockTaskRepository();

  String? _selectedProject;
  TaskPriority _selectedPriority = TaskPriority.medium;
  DateTime? _startDate;
  DateTime? _deadline;

  late final List<String> _projects;

  @override
  void initState() {
    super.initState();
    _projects = const MockProjectRepository()
        .getProjects()
        .map((project) => project.name)
        .toList(growable: false);

    _selectedProject = _projects.isNotEmpty ? _projects.first : null;
    _startDate = DateTime.now();
    _deadline = DateTime.now().add(const Duration(days: 1));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _assigneeController.dispose();
    _estimatedCostController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool isStartDate}) async {
    final DateTime initial = isStartDate
        ? (_startDate ?? DateTime.now())
        : (_deadline ?? (_startDate ?? DateTime.now()));

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (picked == null) {
      return;
    }

    setState(() {
      if (isStartDate) {
        _startDate = picked;
        if (_deadline != null && _deadline!.isBefore(picked)) {
          _deadline = picked;
        }
      } else {
        _deadline = picked;
      }
    });
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.l10n.validationRequired;
    }
    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_startDate == null || _deadline == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.taskSelectDatesError)),
      );
      return;
    }

    if (_deadline!.isBefore(_startDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.taskDeadlineAfterStartError)),
      );
      return;
    }

    final project = _selectedProject?.trim() ?? '';
    if (project.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.validationRequired)),
      );
      return;
    }

    final assignee = _assigneeController.text.trim();
    final estimatedCost = double.tryParse(_estimatedCostController.text.replaceAll(',', '.').trim());
    if (estimatedCost == null || estimatedCost <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.taskCostValidationError)),
      );
      return;
    }

    final now = DateTime.now();
    final newTask = ConstructionTask(
      id: 'tsk-${now.microsecondsSinceEpoch}',
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      priority: _selectedPriority,
      status: TaskStatus.notStarted,
      assignedEmployeeId: assignee.isEmpty ? 'unassigned' : 'manual-${assignee.hashCode}',
      assignedEmployee: assignee.isEmpty ? 'Не назначено' : assignee,
      assignedEmployees: assignee.isEmpty ? <String>[] : <String>[assignee],
      projectId: project,
      project: project,
      deadline: _deadline!,
      startDate: _startDate!,
      progress: 0,
      estimatedCost: estimatedCost,
      updatedAt: now,
      comments: <String>[],
      activityHistory: <String>[],
      beforePhotos: <String>[],
      afterPhotos: <String>[],
      documents: <String>[],
    );

    _taskRepository.addTask(newTask);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.taskCreatedLocalInfo)),
    );
    context.go(AppRoutes.tasks);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toLanguageTag();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.newTaskTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
        children: <Widget>[
          Text(
            l10n.newTaskHeadline,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.newTaskSubtitle,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(labelText: l10n.commonTitle),
                      validator: _requiredValidator,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _descriptionController,
                      minLines: 3,
                      maxLines: 5,
                      decoration: InputDecoration(labelText: l10n.commonDescription),
                      validator: _requiredValidator,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedProject,
                      decoration: InputDecoration(labelText: l10n.commonProject),
                      items: _projects
                          .map(
                            (String project) => DropdownMenuItem<String>(
                              value: project,
                              child: Text(project),
                            ),
                          )
                          .toList(growable: false),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedProject = value;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _assigneeController,
                      decoration: InputDecoration(labelText: l10n.taskAssignEmployee),
                      validator: _requiredValidator,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<TaskPriority>(
                      initialValue: _selectedPriority,
                      decoration: InputDecoration(labelText: l10n.commonPriority),
                      items: TaskPriority.values
                          .map(
                            (TaskPriority priority) => DropdownMenuItem<TaskPriority>(
                              value: priority,
                              child: Text(
                                _localizedTaskPriorityLabel(context, priority),
                              ),
                            ),
                          )
                          .toList(growable: false),
                      onChanged: (TaskPriority? value) {
                        if (value != null) {
                          setState(() {
                            _selectedPriority = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: _DateButton(
                            label: l10n.commonStartDate,
                            value: _startDate == null
                                ? l10n.commonSelectDate
                              : formatTaskDate(_startDate!, locale: locale),
                            onTap: () => _pickDate(isStartDate: true),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _DateButton(
                            label: l10n.commonDeadline,
                            value: _deadline == null
                                ? l10n.commonSelectDate
                              : formatTaskDate(_deadline!, locale: locale),
                            onTap: () => _pickDate(isStartDate: false),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _estimatedCostController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: l10n.taskEstimatedCost,
                        prefixText: '\$',
                      ),
                      validator: (String? value) {
                        final requiredError = _requiredValidator(value);
                        if (requiredError != null) {
                          return requiredError;
                        }
                        final parsed = double.tryParse(value!.replaceAll(',', ''));
                        if (parsed == null || parsed <= 0) {
                          return l10n.taskCostValidationError;
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TaskAttachmentPlaceholderCard(
            title: l10n.taskAttachPhotos,
            description: l10n.taskAttachPhotosPlaceholder,
            icon: Icons.photo_camera_outlined,
            route: AppRoutes.photoReports,
          ),
          const SizedBox(height: 10),
          TaskAttachmentPlaceholderCard(
            title: l10n.taskAttachDocuments,
            description: l10n.taskAttachDocumentsPlaceholder,
            icon: Icons.attach_file,
            route: AppRoutes.documents,
          ),
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: _submit,
            icon: const Icon(Icons.add_task),
            label: Text(l10n.taskCreateButton),
          ),
        ],
      ),
    );
  }

  String _localizedTaskPriorityLabel(BuildContext context, TaskPriority priority) {
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
}

class _DateButton extends StatelessWidget {
  const _DateButton({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Ink(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(label, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 4),
            Row(
              children: <Widget>[
                const Icon(Icons.event_outlined, size: 16),
                const SizedBox(width: 6),
                Expanded(child: Text(value)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
