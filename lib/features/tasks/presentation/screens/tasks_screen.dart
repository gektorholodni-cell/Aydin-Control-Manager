import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/localization/context_l10n.dart';
import '../../data/repositories/mock_task_repository.dart';
import '../../domain/entities/construction_task.dart';
import '../../domain/enums/task_priority.dart';
import '../../domain/enums/task_status.dart';
import '../widgets/task_card.dart';
import '../widgets/task_filter_sort_bar.dart';
import '../widgets/task_kanban_board.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  static const _currentUserName = 'Пользователь 1';

  final MockTaskRepository _repository = const MockTaskRepository();
  late List<ConstructionTask> _allTasks;

  String? _selectedProject;
  String? _selectedEmployee;
  TaskStatus? _selectedStatus;
  TaskPriority? _selectedPriority;
  TaskSortOption _selectedSort = TaskSortOption.deadline;
  bool _filtersExpanded = false;
  _TasksViewTab _activeTab = _TasksViewTab.all;

  @override
  void initState() {
    super.initState();
    _allTasks = List<ConstructionTask>.from(_repository.getTasks());
  }

  List<ConstructionTask> _buildTasks({
    required bool onlyMine,
    TaskStatus? fixedStatus,
  }) {
    final tasks = _allTasks.where((ConstructionTask task) {
      if (_selectedProject != null && task.project != _selectedProject) {
        return false;
      }
      if (_selectedEmployee != null && task.assignedEmployee != _selectedEmployee) {
        return false;
      }
      if (_selectedStatus != null && task.status != _selectedStatus) {
        return false;
      }
      if (_selectedPriority != null && task.priority != _selectedPriority) {
        return false;
      }
      if (onlyMine && task.assignedEmployee != _currentUserName) {
        return false;
      }
      if (fixedStatus != null && task.status != fixedStatus) {
        return false;
      }
      return true;
    }).toList(growable: false);

    final sorted = List<ConstructionTask>.from(tasks);
    sorted.sort((ConstructionTask a, ConstructionTask b) {
      switch (_selectedSort) {
        case TaskSortOption.deadline:
          return a.deadline.compareTo(b.deadline);
        case TaskSortOption.priority:
          final byPriority = a.priority.sortWeight.compareTo(b.priority.sortWeight);
          if (byPriority != 0) {
            return byPriority;
          }
          return a.deadline.compareTo(b.deadline);
        case TaskSortOption.recentlyUpdated:
          return b.updatedAt.compareTo(a.updatedAt);
      }
    });

    return sorted;
  }

  void _moveTask(String taskId, TaskStatus newStatus) {
    setState(() {
      _allTasks = _allTasks
          .map(
            (task) => task.id == taskId
                ? task.copyWith(status: newStatus, updatedAt: DateTime.now())
                : task,
          )
          .toList(growable: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final allTasks = _allTasks;
    final projects = allTasks.map((task) => task.project).toSet().toList(growable: false)
      ..sort();
    final employees = allTasks.map((task) => task.assignedEmployee).toSet().toList(growable: false)
      ..sort();
    final allFilteredTasks = _buildTasks(onlyMine: false);
    final myTasks = _buildTasks(onlyMine: true);
    final inProgressTasks = _buildTasks(onlyMine: false, fixedStatus: TaskStatus.inProgress);
    final completedTasks = _buildTasks(onlyMine: false, fixedStatus: TaskStatus.completed);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.tasksTitle)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.go(AppRoutes.newTask);
        },
        icon: const Icon(Icons.add),
        label: Text(l10n.newTaskTitle),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 6),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: <Widget>[
                _TasksTabChip(
                  label: l10n.tasksTabAll,
                  selected: _activeTab == _TasksViewTab.all,
                  onSelected: () => setState(() => _activeTab = _TasksViewTab.all),
                ),
                _TasksTabChip(
                  label: l10n.tasksTabMine,
                  selected: _activeTab == _TasksViewTab.mine,
                  onSelected: () => setState(() => _activeTab = _TasksViewTab.mine),
                ),
                _TasksTabChip(
                  label: l10n.tasksTabInProgress,
                  selected: _activeTab == _TasksViewTab.inProgress,
                  onSelected: () => setState(() => _activeTab = _TasksViewTab.inProgress),
                ),
                _TasksTabChip(
                  label: l10n.tasksTabCompleted,
                  selected: _activeTab == _TasksViewTab.completed,
                  onSelected: () => setState(() => _activeTab = _TasksViewTab.completed),
                ),
                _TasksTabChip(
                  label: l10n.tasksTabKanban,
                  selected: _activeTab == _TasksViewTab.kanban,
                  onSelected: () => setState(() => _activeTab = _TasksViewTab.kanban),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
            child: Card(
              child: ExpansionTile(
                title: Text(
                  l10n.tasksFiltersTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                initiallyExpanded: _filtersExpanded,
                onExpansionChanged: (value) {
                  setState(() {
                    _filtersExpanded = value;
                  });
                },
                childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                children: <Widget>[
                  TaskFilterSortBar(
                    projects: projects,
                    employees: employees,
                    selectedProject: _selectedProject,
                    selectedEmployee: _selectedEmployee,
                    selectedStatus: _selectedStatus,
                    selectedPriority: _selectedPriority,
                    selectedSort: _selectedSort,
                    onProjectChanged: (String? value) {
                      setState(() {
                        _selectedProject = value;
                      });
                    },
                    onEmployeeChanged: (String? value) {
                      setState(() {
                        _selectedEmployee = value;
                      });
                    },
                    onStatusChanged: (TaskStatus? value) {
                      setState(() {
                        _selectedStatus = value;
                      });
                    },
                    onPriorityChanged: (TaskPriority? value) {
                      setState(() {
                        _selectedPriority = value;
                      });
                    },
                    onSortChanged: (TaskSortOption value) {
                      setState(() {
                        _selectedSort = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: switch (_activeTab) {
              _TasksViewTab.all => _TaskListView(tasks: allFilteredTasks),
              _TasksViewTab.mine => _TaskListView(tasks: myTasks),
              _TasksViewTab.inProgress => _TaskListView(tasks: inProgressTasks),
              _TasksViewTab.completed => _TaskListView(tasks: completedTasks),
              _TasksViewTab.kanban => allFilteredTasks.isEmpty
                  ? const _NoTasksState()
                  : TaskKanbanBoard(
                      key: ValueKey<String>(
                        'kanban_${_selectedProject}_${_selectedEmployee}_${_selectedStatus}_${_selectedPriority}_${_selectedSort.name}',
                      ),
                      tasks: allFilteredTasks,
                      onTaskMoved: _moveTask,
                    ),
            },
          ),
        ],
      ),
    );
  }
}

enum _TasksViewTab {
  all,
  mine,
  inProgress,
  completed,
  kanban,
}

class _TasksTabChip extends StatelessWidget {
  const _TasksTabChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onSelected(),
      ),
    );
  }
}

class _TaskListView extends StatelessWidget {
  const _TaskListView({required this.tasks});

  final List<ConstructionTask> tasks;

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const _NoTasksState();
    }

    return ListView.separated(
      itemCount: tasks.length,
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 92),
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (BuildContext context, int index) {
        final task = tasks[index];

        return TaskCard(
          task: task,
          onTap: () {
            context.go('${AppRoutes.tasks}/${task.id}');
          },
        );
      },
    );
  }
}

class _NoTasksState extends StatelessWidget {
  const _NoTasksState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.task_alt_outlined,
            size: 44,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 10),
          Text(
            context.l10n.tasksNoResults,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
