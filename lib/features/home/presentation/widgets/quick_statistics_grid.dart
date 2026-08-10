import 'package:flutter/material.dart';

import '../../../../core/localization/context_l10n.dart';
import '../../../chats/data/repositories/mock_chats_repository.dart';
import '../../../employees/data/repositories/mock_employee_repository.dart';
import '../../../tasks/data/repositories/mock_task_repository.dart';
import '../../../tasks/domain/enums/task_status.dart';

class QuickStatisticsGrid extends StatelessWidget {
  const QuickStatisticsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final tasks = const MockTaskRepository().getTasks();
    final employees = const MockEmployeeRepository().getEmployees();
    final chats = const MockChatsRepository();
    final today = DateUtils.dateOnly(DateTime.now());
    final projects = tasks.map((task) => task.project).toSet().length;
    final employeesCount = employees.length;
    final activeTasks = tasks.where((task) => task.status != TaskStatus.completed).length;
    final onlineEmployees = employees.where((employee) => employee.isOnline).length;
    final tasksToday = tasks.where((task) => DateUtils.dateOnly(task.updatedAt) == today).length;
    final completedTasks = tasks.where((task) => task.status == TaskStatus.completed).length;
    final pendingTasks = tasks.where((task) => task.status == TaskStatus.notStarted || task.status == TaskStatus.waiting).length;
    final overdueTasks = tasks.where((task) => task.status != TaskStatus.completed && task.deadline.isBefore(today)).length;
    final unreadMessages = chats.getThreads().length;
    final projectProgress = tasks.isEmpty ? 0 : (completedTasks / tasks.length * 100).round();
    final stats = <_StatItem>[
      _StatItem(
        title: l10n.statProjects,
        value: projects.toString(),
        icon: Icons.apartment_outlined,
      ),
      _StatItem(
        title: l10n.statEmployees,
        value: employeesCount.toString(),
        icon: Icons.badge_outlined,
      ),
      _StatItem(
        title: l10n.statActiveTasks,
        value: activeTasks.toString(),
        icon: Icons.checklist_rtl,
      ),
      _StatItem(
        title: l10n.statEmployeesOnline,
        value: onlineEmployees.toString(),
        icon: Icons.groups_2_outlined,
      ),
      _StatItem(
        title: l10n.statTasksToday,
        value: tasksToday.toString(),
        icon: Icons.today_outlined,
      ),
      _StatItem(
        title: l10n.statCompletedTasks,
        value: completedTasks.toString(),
        icon: Icons.task_alt_outlined,
      ),
      _StatItem(
        title: l10n.statPendingTasks,
        value: pendingTasks.toString(),
        icon: Icons.hourglass_bottom_outlined,
      ),
      _StatItem(
        title: l10n.statOverdueTasks,
        value: overdueTasks.toString(),
        icon: Icons.warning_amber_outlined,
      ),
      _StatItem(
        title: l10n.statUnreadMessages,
        value: unreadMessages.toString(),
        icon: Icons.mark_chat_unread_outlined,
      ),
      _StatItem(
        title: l10n.statProjectProgress,
        value: '$projectProgress%',
        icon: Icons.trending_up_outlined,
      ),
      _StatItem(
        title: l10n.statBudgetRemaining,
        value: '0',
        icon: Icons.savings_outlined,
      ),
      _StatItem(
        title: l10n.statMonthlyExpenses,
        value: '0',
        icon: Icons.payments_outlined,
      ),
      _StatItem(
        title: l10n.statMonthlyIncome,
        value: '0',
        icon: Icons.account_balance_wallet_outlined,
      ),
    ];

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final crossAxisCount = constraints.maxWidth >= 800
            ? 4
            : constraints.maxWidth >= 520
                ? 2
                : 1;

        return GridView.builder(
          itemCount: stats.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: crossAxisCount == 1 ? 2.8 : 1.9,
          ),
          itemBuilder: (BuildContext context, int index) {
            final item = stats[index];
            return _StatCard(item: item, index: index);
          },
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.item,
    required this.index,
  });

  final _StatItem item;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 250 + (index * 70)),
      curve: Curves.easeOutCubic,
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 14 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Card(
        elevation: 0,
        color: colorScheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(item.icon, color: colorScheme.onPrimaryContainer),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.value,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(item.title, style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem {
  const _StatItem({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;
}
