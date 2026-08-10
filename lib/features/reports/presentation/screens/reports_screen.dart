import 'package:flutter/material.dart';

import '../../../../core/localization/context_l10n.dart';
import '../../../chats/data/repositories/mock_chats_repository.dart';
import '../../../documents/data/repositories/mock_documents_repository.dart';
import '../../../employees/data/repositories/mock_employee_repository.dart';
import '../../../photo_reports/data/repositories/mock_photo_reports_repository.dart';
import '../../../tasks/data/repositories/mock_task_repository.dart';
import '../../../tasks/domain/enums/task_status.dart';
import '../../../../shared/presentation/widgets/premium_metric_tile.dart';
import '../../../../shared/presentation/widgets/premium_section_card.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final tasks = MockTaskRepository().getTasks();
    final employees = MockEmployeeRepository().getEmployees();
    final documentsRepository = MockDocumentsRepository();
    final photoReports = MockPhotoReportsRepository().getPhotoReports();
    final chats = MockChatsRepository();
    final today = DateUtils.dateOnly(DateTime.now());
    final weekAgo = today.subtract(const Duration(days: 7));
    final monthStart = DateTime(today.year, today.month, 1);

    final dailyTasks = tasks.where((task) => DateUtils.dateOnly(task.updatedAt) == today).length;
    final weeklyTasks = tasks.where((task) => !task.updatedAt.isBefore(weekAgo)).length;
    final monthlyTasks = tasks.where((task) => !task.updatedAt.isBefore(monthStart)).length;
    final employeeCount = employees.length;
    final projectCount = tasks.map((task) => task.project).toSet().length;
    final photoReportCount = photoReports.length;
    final completedTasks = tasks.where((task) => task.status == TaskStatus.completed).length;
    final activeChatCount = chats.getThreads().length;
    final documentCount = documentsRepository.getRecentDocuments().length;

    final reports = <_ReportMetric>[
      _ReportMetric(l10n.reportsDailyReportLabel, dailyTasks.toString()),
      _ReportMetric(l10n.reportsWeeklyReportLabel, weeklyTasks.toString()),
      _ReportMetric(l10n.reportsMonthlyReportLabel, monthlyTasks.toString()),
      _ReportMetric(l10n.reportsEmployeeReportLabel, employeeCount.toString()),
      _ReportMetric(l10n.reportsProjectReportLabel, projectCount.toString()),
      _ReportMetric(l10n.reportsPhotoReportLabel, photoReportCount.toString()),
      _ReportMetric(l10n.reportsProgressReportLabel, completedTasks.toString()),
      _ReportMetric(l10n.chatsTitle, activeChatCount.toString()),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.reportsModuleTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: <Widget>[
          PremiumSectionCard(
            title: l10n.reportsModuleHeadline,
            subtitle: l10n.reportsModuleSubtitle,
            icon: Icons.assessment_outlined,
            child: Column(
              children: <Widget>[
                PremiumMetricTile(
                  label: l10n.reportsDailyReportLabel,
                  value: dailyTasks.toString(),
                  icon: Icons.today_outlined,
                ),
                const SizedBox(height: 10),
                PremiumMetricTile(
                  label: l10n.reportsWeeklyReportLabel,
                  value: weeklyTasks.toString(),
                  icon: Icons.view_week_outlined,
                ),
                const SizedBox(height: 10),
                PremiumMetricTile(
                  label: l10n.reportsMonthlyReportLabel,
                  value: monthlyTasks.toString(),
                  icon: Icons.calendar_month_outlined,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: reports
                .map(
                  (metric) => SizedBox(
                    width: 220,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              metric.value,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            const SizedBox(height: 6),
                            Text(metric.label),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(growable: false),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.stacked_line_chart_outlined),
              title: Text(l10n.reportsChartsPlaceholderTitle),
              subtitle: Text('$completedTasks ${l10n.statCompletedTasks.toLowerCase()} · $projectCount ${l10n.projectsTitle.toLowerCase()}'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.picture_as_pdf_outlined),
              title: Text(l10n.reportsExportPlaceholderTitle),
              subtitle: Text('$documentCount ${l10n.documentsTitle.toLowerCase()}'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportMetric {
  const _ReportMetric(this.label, this.value);

  final String label;
  final String value;
}
