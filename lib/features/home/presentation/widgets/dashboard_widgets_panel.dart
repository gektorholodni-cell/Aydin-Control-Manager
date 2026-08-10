import 'package:flutter/material.dart';

import '../../../../core/localization/context_l10n.dart';
import '../../../chats/data/repositories/mock_chats_repository.dart';
import '../../../employees/data/repositories/mock_employee_repository.dart';
import '../../../projects/data/repositories/mock_project_repository.dart';
import '../../../tasks/data/repositories/mock_task_repository.dart';
import '../../../tasks/domain/enums/task_status.dart';

class DashboardWidgetsPanel extends StatelessWidget {
  const DashboardWidgetsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final tasks = const MockTaskRepository().getTasks();
    final employees = const MockEmployeeRepository().getEmployees();
    final projects = const MockProjectRepository().getProjects();
    final today = DateUtils.dateOnly(DateTime.now());
    final currentProject = projects.isNotEmpty ? projects.first : null;

    final todayTasks = tasks.where((task) => DateUtils.dateOnly(task.updatedAt) == today).length;
    final overdueTasks = tasks.where((task) => task.status != TaskStatus.completed && task.deadline.isBefore(DateTime.now())).length;
    final unreadMessages = const MockChatsRepository().getThreads().fold<int>(0, (int total, thread) => total + thread.unreadCount);
    final recentExpenses = tasks.fold<double>(0, (double total, task) => total + task.estimatedCost).round();
    final monthlyIncome = projects.fold<double>(0, (double total, project) => total + project.budget * 0.08).round();
    final projectProgress = projects.isEmpty
        ? 0
        : (projects.fold<double>(0, (double total, project) => total + project.progress) / projects.length * 100).round();
    final onlineEmployees = employees.where((employee) => employee.isOnline).length;
    
    final weatherText = currentProject != null ? currentProject.weather : 'N/A';
    final chartText = currentProject != null
        ? '${currentProject.currentStage} · ${projects.length} ${l10n.projectsTitle.toLowerCase()}'
        : 'No data available';

    final widgets = <_WidgetItem>[
      _WidgetItem(
        title: l10n.dashboardWeatherTitle,
        subtitle: weatherText,
      ),
      _WidgetItem(title: l10n.dashboardTodayTasksTitle, subtitle: todayTasks.toString()),
      _WidgetItem(title: l10n.statOverdueTasks, subtitle: overdueTasks.toString()),
      _WidgetItem(title: l10n.dashboardRecentMessagesTitle, subtitle: unreadMessages.toString()),
      _WidgetItem(title: l10n.dashboardRecentExpensesTitle, subtitle: recentExpenses.toString()),
      _WidgetItem(title: l10n.statMonthlyIncome, subtitle: monthlyIncome.toString()),
      _WidgetItem(title: l10n.dashboardProjectProgressTitle, subtitle: '$projectProgress%'),
      _WidgetItem(title: l10n.dashboardEmployeesOnlineTitle, subtitle: onlineEmployees.toString()),
      _WidgetItem(
        title: l10n.dashboardChartsPlaceholderTitle,
        subtitle: chartText,
      ),
      _WidgetItem(title: l10n.quickActionsTitle, subtitle: l10n.dashboardQuickActionsHint),
    ];

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final crossAxisCount = constraints.maxWidth >= 860
            ? 4
            : constraints.maxWidth >= 560
                ? 2
                : 1;

        return GridView.builder(
          itemCount: widgets.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: crossAxisCount == 1 ? 2.4 : 2.1,
          ),
          itemBuilder: (BuildContext context, int index) {
            final item = widgets[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _WidgetItem {
  const _WidgetItem({required this.title, required this.subtitle});

  final String title;
  final String subtitle;
}
