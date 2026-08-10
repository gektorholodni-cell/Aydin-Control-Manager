import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/localization/context_l10n.dart';
import '../../data/repositories/mock_project_repository.dart';
import '../widgets/project_card.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final projects = const MockProjectRepository().getProjects();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.projectsTitle)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.go(AppRoutes.newProject);
        },
        icon: const Icon(Icons.add),
        label: Text(l10n.newProjectTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              l10n.projectsHeadline,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.projectsSubtitle,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 14),
            Expanded(
              child: ListView.separated(
                itemCount: projects.length,
                padding: const EdgeInsets.only(bottom: 92),
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 12);
                },
                itemBuilder: (BuildContext context, int index) {
                  final project = projects[index];
                  return _AnimatedProjectCard(
                    index: index,
                    child: ProjectCard(
                      project: project,
                      onTap: () {
                        context.go('${AppRoutes.projects}/${project.id}');
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedProjectCard extends StatelessWidget {
  const _AnimatedProjectCard({
    required this.index,
    required this.child,
  });

  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 220 + (index * 45)),
      curve: Curves.easeOutCubic,
      tween: Tween<double>(begin: 0, end: 1),
      builder: (BuildContext context, double value, Widget? child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 14),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
