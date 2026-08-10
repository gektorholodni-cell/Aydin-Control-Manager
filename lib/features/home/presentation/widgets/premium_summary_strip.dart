import 'package:flutter/material.dart';

import '../../../../core/localization/context_l10n.dart';
import '../../../employees/data/repositories/mock_employee_repository.dart';
import '../../../tasks/data/repositories/mock_task_repository.dart';
import '../../../tasks/domain/enums/task_status.dart';

class PremiumSummaryStrip extends StatelessWidget {
  const PremiumSummaryStrip({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final tasks = const MockTaskRepository().getTasks();
    final employees = const MockEmployeeRepository().getEmployees();
    final totalTasks = tasks.length;
    final activeTasks = tasks.where((task) => task.status != TaskStatus.completed).length;
    final completedTasks = tasks.where((task) => task.status == TaskStatus.completed).length;
    final onlineEmployees = employees.where((employee) => employee.isOnline).length;

    final items = <_SummaryItem>[
      _SummaryItem(title: l10n.tasksTitle, value: totalTasks.toString(), icon: Icons.event_note_outlined),
      _SummaryItem(title: l10n.statActiveTasks, value: activeTasks.toString(), icon: Icons.checklist_rtl),
      _SummaryItem(title: l10n.statCompletedTasks, value: completedTasks.toString(), icon: Icons.task_alt_outlined),
      _SummaryItem(title: l10n.statEmployeesOnline, value: onlineEmployees.toString(), icon: Icons.groups_2_outlined),
    ];

    return SizedBox(
      height: 158,
      child: ListView.separated(
        key: const PageStorageKey<String>('home_premium_summary_scroll'),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = items[index];
          final cardWidth = MediaQuery.sizeOf(context).width < 390 ? 230.0 : 260.0;
          return TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: 1),
            duration: Duration(milliseconds: 320 + (index * 90)),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(20 * (1 - value), 0),
                  child: child,
                ),
              );
            },
            child: Container(
              width: cardWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    colorScheme.primaryContainer,
                    colorScheme.secondaryContainer,
                  ],
                ),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 16,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(item.icon, color: colorScheme.onPrimaryContainer),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item.value,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: colorScheme.onPrimaryContainer,
                              ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.title,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onPrimaryContainer,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SummaryItem {
  const _SummaryItem({required this.title, required this.value, required this.icon});

  final String title;
  final String value;
  final IconData icon;
}
