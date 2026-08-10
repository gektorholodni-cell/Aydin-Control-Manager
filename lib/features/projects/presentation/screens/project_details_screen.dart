import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/localization/context_l10n.dart';
import '../../../documents/data/repositories/mock_documents_repository.dart';
import '../../../photo_reports/data/repositories/mock_photo_reports_repository.dart';
import '../../data/repositories/mock_project_repository.dart';
import '../../../tasks/data/repositories/mock_task_repository.dart';
import '../../../tasks/domain/enums/task_status.dart';
import '../widgets/project_overview_cards.dart';

class ProjectDetailsScreen extends StatelessWidget {
  const ProjectDetailsScreen({required this.projectId, super.key});

  final String projectId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final repository = MockProjectRepository();
    final project = repository.getProjectById(projectId);
    final taskRepository = MockTaskRepository();
    final documentRepository = MockDocumentsRepository();
    final photoReportRepository = MockPhotoReportsRepository();
    final projectTasks = taskRepository
      .getTasks()
      .where((task) => task.project == project?.name)
      .toList(growable: false);
    final activeTasks = projectTasks.where((task) => task.status != TaskStatus.completed).length;
    final completedTasks = projectTasks.where((task) => task.status == TaskStatus.completed).length;
    final projectEmployees = projectTasks.map((task) => task.assignedEmployee).toSet().length;
    final projectPhotos = photoReportRepository
      .getPhotoReports()
      .where((report) => report.projectName == project?.name)
      .length;
    final recentDocuments = documentRepository.getRecentDocuments();
    final documentCount = recentDocuments.length;
    final totalProjects = repository.getProjects().length;

    if (project == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.projectDetailsTitle)),
        body: Center(
          child: Text(
            l10n.projectNotFound,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      );
    }

    return DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          title: Text(project.name),
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: <Tab>[
              Tab(text: l10n.tabOverview),
              Tab(text: l10n.tabTasks),
              Tab(text: l10n.tabEmployees),
              Tab(text: l10n.tabChat),
              Tab(text: l10n.tabDocuments),
              Tab(text: l10n.tabPhotos),
              Tab(text: l10n.tabFinance),
              Tab(text: l10n.tabReports),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              children: <Widget>[
                ProjectOverviewCards(project: project),
              ],
            ),
            _TabBody(
              title: l10n.tabTasks,
              icon: Icons.task_alt_outlined,
              children: <Widget>[
                _ProjectMetricCard(
                  title: l10n.tabTasks,
                  value: '$activeTasks / $completedTasks',
                  subtitle: 'Активные / завершенные',
                  icon: Icons.task_alt_outlined,
                ),
                const SizedBox(height: 12),
                _ProjectMetricCard(
                  title: l10n.tasksTitle,
                  value: projectTasks.length.toString(),
                  subtitle: 'Всего задач по проекту',
                  icon: Icons.playlist_add_check_outlined,
                ),
              ],
            ),
            _TabBody(
              title: l10n.tabEmployees,
              icon: Icons.groups_2_outlined,
              children: <Widget>[
                _ProjectMetricCard(
                  title: l10n.tabEmployees,
                  value: projectEmployees.toString(),
                  subtitle: 'Назначено в задачах',
                  icon: Icons.groups_2_outlined,
                ),
                const SizedBox(height: 12),
                _ProjectMetricCard(
                  title: l10n.projectsTitle,
                  value: project.numberOfEmployees.toString(),
                  subtitle: 'Команда в карточке проекта',
                  icon: Icons.badge_outlined,
                ),
              ],
            ),
            _ActionTabBody(
              title: l10n.tabChat,
              icon: Icons.chat_bubble_outline,
              buttonLabel: l10n.actionOpenChats,
              onTap: () => context.go(AppRoutes.chats),
              children: const <Widget>[],
            ),
            _TabBody(
              title: l10n.tabDocuments,
              icon: Icons.description_outlined,
              children: <Widget>[
                _ProjectMetricCard(
                  title: l10n.tabDocuments,
                  value: documentCount.toString(),
                  subtitle: 'Последние доступные документы',
                  icon: Icons.description_outlined,
                ),
                const SizedBox(height: 12),
                if (recentDocuments.isNotEmpty)
                  _ProjectMetricCard(
                    title: l10n.documentsRecent,
                    value: recentDocuments.first.name,
                    subtitle: recentDocuments.first.type,
                    icon: Icons.folder_copy_outlined,
                  ),
              ],
            ),
            _TabBody(
              title: l10n.tabPhotos,
              icon: Icons.photo_library_outlined,
              children: <Widget>[
                _ProjectMetricCard(
                  title: l10n.tabPhotos,
                  value: projectPhotos.toString(),
                  subtitle: 'Фотоотчеты по проекту',
                  icon: Icons.photo_library_outlined,
                ),
                const SizedBox(height: 12),
                _ProjectMetricCard(
                  title: l10n.photoReportsTitle,
                  value: photoReportRepository.getPhotoReports().length.toString(),
                  subtitle: 'Всего альбомов',
                  icon: Icons.photo_camera_outlined,
                ),
              ],
            ),
            _TabBody(
              title: l10n.tabFinance,
              icon: Icons.account_balance_wallet_outlined,
              children: <Widget>[
                _ProjectMetricCard(
                  title: l10n.tabFinance,
                  value: '${project.remainingBudget.toStringAsFixed(0)} ₸',
                  subtitle: 'Остаток бюджета проекта',
                  icon: Icons.account_balance_wallet_outlined,
                ),
                const SizedBox(height: 12),
                _ProjectMetricCard(
                  title: l10n.financeRemainingBudget,
                  value: '${(project.progress * 100).toStringAsFixed(0)}%',
                  subtitle: 'Текущий прогресс',
                  icon: Icons.trending_up_outlined,
                ),
              ],
            ),
            _ActionTabBody(
              title: l10n.tabReports,
              icon: Icons.assessment_outlined,
              buttonLabel: l10n.actionReports,
              onTap: () => context.go(AppRoutes.reports),
              children: <Widget>[
                _ProjectMetricCard(
                  title: l10n.tabReports,
                  value: totalProjects.toString(),
                  subtitle: 'Проекты в системе',
                  icon: Icons.assessment_outlined,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionTabBody extends StatelessWidget {
  const _ActionTabBody({
    required this.title,
    required this.icon,
    required this.buttonLabel,
    required this.onTap,
    required this.children,
  });

  final String title;
  final IconData icon;
  final String buttonLabel;
  final VoidCallback onTap;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _TabHeader(title: title, icon: icon),
        const SizedBox(height: 12),
        ...children,
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: onTap,
          icon: const Icon(Icons.open_in_new_outlined),
          label: Text(buttonLabel),
        ),
      ],
    );
  }
}

class _TabBody extends StatelessWidget {
  const _TabBody({
    required this.title,
    required this.icon,
    required this.children,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _TabHeader(title: title, icon: icon),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }
}

class _TabHeader extends StatelessWidget {
  const _TabHeader({required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 44, color: colorScheme.primary),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectMetricCard extends StatelessWidget {
  const _ProjectMetricCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String value;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}
