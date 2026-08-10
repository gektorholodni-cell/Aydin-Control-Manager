import 'package:flutter/material.dart';

import '../../../../core/localization/context_l10n.dart';
import '../../domain/entities/construction_project.dart';
import 'project_formatters.dart';
import 'project_status_chip.dart';

class ProjectOverviewCards extends StatelessWidget {
  const ProjectOverviewCards({required this.project, super.key});

  final ConstructionProject project;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _ProjectInfoCard(project: project),
        const SizedBox(height: 12),
        _ProgressStageCard(project: project),
        const SizedBox(height: 12),
        _WeatherActivityCard(project: project),
        const SizedBox(height: 12),
        _RecentUpdatesCard(project: project),
      ],
    );
  }
}

class _ProjectInfoCard extends StatelessWidget {
  const _ProjectInfoCard({required this.project});

  final ConstructionProject project;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    l10n.projectInformationTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                ProjectStatusChip(status: project.status),
              ],
            ),
            const SizedBox(height: 10),
            Text(project.description, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            _InfoRow(label: l10n.projectFieldClient, value: project.client),
            const SizedBox(height: 8),
            _InfoRow(label: l10n.projectFieldAddress, value: project.address),
            const SizedBox(height: 8),
            _InfoRow(
              label: l10n.commonTimeline,
              value: '${formatDateShort(project.startDate, locale: locale)} - ${formatDateShort(project.endDate, locale: locale)}',
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressStageCard extends StatelessWidget {
  const _ProgressStageCard({required this.project});

  final ConstructionProject project;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              l10n.projectProgressStageTitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              l10n.projectCompletedValue(formatPercent(project.progress)),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(99),
              child: LinearProgressIndicator(value: project.progress, minHeight: 10),
            ),
            const SizedBox(height: 12),
            _InfoRow(label: l10n.projectCurrentStage, value: project.currentStage),
          ],
        ),
      ),
    );
  }
}

class _WeatherActivityCard extends StatelessWidget {
  const _WeatherActivityCard({required this.project});

  final ConstructionProject project;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              l10n.projectWeatherActivityTitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 10),
            _InfoRow(label: l10n.commonWeather, value: project.weather),
            const SizedBox(height: 8),
            _InfoRow(label: l10n.commonLastActivity, value: project.lastActivity),
          ],
        ),
      ),
    );
  }
}

class _RecentUpdatesCard extends StatelessWidget {
  const _RecentUpdatesCard({required this.project});

  final ConstructionProject project;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              l10n.commonRecentUpdates,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 10),
            ...project.recentUpdates.map(
              (String update) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Icon(Icons.circle, size: 8),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(update, style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        Expanded(
          child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
    );
  }
}
