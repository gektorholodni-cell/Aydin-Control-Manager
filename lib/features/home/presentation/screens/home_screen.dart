import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/localization/context_l10n.dart';
import '../widgets/current_project_card.dart';
import '../widgets/dashboard_widgets_panel.dart';
import '../widgets/premium_summary_strip.dart';
import '../widgets/quick_actions_grid.dart';
import '../widgets/quick_statistics_grid.dart';
import '../widgets/recent_activity_timeline.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _summaryExpanded = false;
  bool _projectExpanded = false;
  bool _statsExpanded = false;
  bool _actionsExpanded = false;
  bool _widgetsExpanded = false;
  bool _activityExpanded = false;

  void _openRouteFromDrawer(String route) {
    Navigator.of(context).pop();
    context.go(route);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.dashboard_customize_outlined),
                title: Text(l10n.appTitle),
                subtitle: Text(l10n.homeOverviewSubtitle),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                      child: Text(
                        l10n.homeTitle,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    _DrawerNavTile(
                      icon: Icons.home_outlined,
                      label: l10n.homeTitle,
                      onTap: () => _openRouteFromDrawer(AppRoutes.home),
                    ),
                    _DrawerNavTile(
                      icon: Icons.search_outlined,
                      label: l10n.globalSearchTitle,
                      onTap: () => _openRouteFromDrawer(AppRoutes.globalSearch),
                    ),
                    _DrawerNavTile(
                      icon: Icons.notifications_outlined,
                      label: l10n.notificationsTitle,
                      onTap: () => _openRouteFromDrawer(AppRoutes.notifications),
                    ),
                    _DrawerNavTile(
                      icon: Icons.settings_outlined,
                      label: l10n.settingsTitle,
                      onTap: () => _openRouteFromDrawer(AppRoutes.settings),
                    ),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                      child: Text(
                        l10n.quickActionsTitle,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    _DrawerNavTile(
                      icon: Icons.forum_outlined,
                      label: l10n.chatsTitle,
                      onTap: () => _openRouteFromDrawer(AppRoutes.chats),
                    ),
                    _DrawerNavTile(
                      icon: Icons.task_alt_outlined,
                      label: l10n.tasksTitle,
                      onTap: () => _openRouteFromDrawer(AppRoutes.tasks),
                    ),
                    _DrawerNavTile(
                      icon: Icons.account_balance_wallet_outlined,
                      label: l10n.financeTitle,
                      onTap: () => _openRouteFromDrawer(AppRoutes.finance),
                    ),
                    _DrawerNavTile(
                      icon: Icons.business_outlined,
                      label: l10n.projectsTitle,
                      onTap: () => _openRouteFromDrawer(AppRoutes.projects),
                    ),
                    _DrawerNavTile(
                      icon: Icons.groups_2_outlined,
                      label: l10n.employeesTitle,
                      onTap: () => _openRouteFromDrawer(AppRoutes.employees),
                    ),
                    _DrawerNavTile(
                      icon: Icons.description_outlined,
                      label: l10n.documentsTitle,
                      onTap: () => _openRouteFromDrawer(AppRoutes.documents),
                    ),
                    _DrawerNavTile(
                      icon: Icons.photo_library_outlined,
                      label: l10n.photoReportsTitle,
                      onTap: () => _openRouteFromDrawer(AppRoutes.photoReports),
                    ),
                    _DrawerNavTile(
                      icon: Icons.assessment_outlined,
                      label: l10n.reportsModuleTitle,
                      onTap: () => _openRouteFromDrawer(AppRoutes.reports),
                    ),
                    _DrawerNavTile(
                      icon: Icons.admin_panel_settings_outlined,
                      label: l10n.adminTitle,
                      onTap: () => _openRouteFromDrawer(AppRoutes.admin),
                    ),
                    _DrawerNavTile(
                      icon: Icons.draw_outlined,
                      label: l10n.enterpriseDrawingsTitle,
                      onTap: () => _openRouteFromDrawer(AppRoutes.drawings),
                    ),
                    _DrawerNavTile(
                      icon: Icons.precision_manufacturing_outlined,
                      label: l10n.enterpriseEquipmentTitle,
                      onTap: () => _openRouteFromDrawer(AppRoutes.equipment),
                    ),
                    _DrawerNavTile(
                      icon: Icons.local_shipping_outlined,
                      label: l10n.enterpriseVehiclesTitle,
                      onTap: () => _openRouteFromDrawer(AppRoutes.vehicles),
                    ),
                    _DrawerNavTile(
                      icon: Icons.warehouse_outlined,
                      label: l10n.enterpriseWarehouseTitle,
                      onTap: () => _openRouteFromDrawer(AppRoutes.warehouse),
                    ),
                    _DrawerNavTile(
                      icon: Icons.calendar_month_outlined,
                      label: l10n.enterpriseCalendarTitle,
                      onTap: () => _openRouteFromDrawer(AppRoutes.calendar),
                    ),
                    _DrawerNavTile(
                      icon: Icons.person_outline,
                      label: l10n.profileTitle,
                      onTap: () => _openRouteFromDrawer(AppRoutes.profile),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(l10n.homeTitle),
        actions: <Widget>[
          IconButton(
            tooltip: l10n.globalSearchTitle,
            icon: const Icon(Icons.search_outlined),
            onPressed: () => context.go(AppRoutes.globalSearch),
          ),
          IconButton(
            tooltip: l10n.notificationsTitle,
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.go(AppRoutes.notifications),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 20),
        children: <Widget>[
          _HomeHeroCard(
            title: l10n.homeGreeting,
            subtitle: l10n.homeOverviewSubtitle,
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              FilledButton.tonalIcon(
                onPressed: () => context.go(AppRoutes.tasks),
                icon: const Icon(Icons.task_alt_outlined),
                label: Text(l10n.tasksTitle),
              ),
              FilledButton.tonalIcon(
                onPressed: () => context.go(AppRoutes.chats),
                icon: const Icon(Icons.forum_outlined),
                label: Text(l10n.chatsTitle),
              ),
              FilledButton.tonalIcon(
                onPressed: () => context.go(AppRoutes.finance),
                icon: const Icon(Icons.account_balance_wallet_outlined),
                label: Text(l10n.financeTitle),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _DashboardSection(
            title: l10n.homeSummarySection,
            expanded: _summaryExpanded,
            onChanged: (value) => setState(() => _summaryExpanded = value),
            child: const PremiumSummaryStrip(),
          ),
          _DashboardSection(
            title: l10n.currentProjectTitle,
            expanded: _projectExpanded,
            onChanged: (value) => setState(() => _projectExpanded = value),
            child: const CurrentProjectCard(),
          ),
          _DashboardSection(
            title: l10n.quickStatisticsTitle,
            expanded: _statsExpanded,
            onChanged: (value) => setState(() => _statsExpanded = value),
            child: const QuickStatisticsGrid(),
          ),
          _DashboardSection(
            title: l10n.quickActionsTitle,
            expanded: _actionsExpanded,
            onChanged: (value) => setState(() => _actionsExpanded = value),
            child: const QuickActionsGrid(),
          ),
          _DashboardSection(
            title: l10n.dashboardWidgetsTitle,
            expanded: _widgetsExpanded,
            onChanged: (value) => setState(() => _widgetsExpanded = value),
            child: const DashboardWidgetsPanel(),
          ),
          _DashboardSection(
            title: l10n.recentActivityTitle,
            expanded: _activityExpanded,
            onChanged: (value) => setState(() => _activityExpanded = value),
            child: const RecentActivityTimeline(),
          ),
        ],
      ),
    );
  }
}

class _DashboardSection extends StatelessWidget {
  const _DashboardSection({
    required this.title,
    required this.expanded,
    required this.onChanged,
    required this.child,
  });

  final String title;
  final bool expanded;
  final ValueChanged<bool> onChanged;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        key: ValueKey<String>('home_section_$title'),
        initiallyExpanded: expanded,
        onExpansionChanged: onChanged,
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        children: <Widget>[child],
      ),
    );
  }
}

class _HomeHeroCard extends StatelessWidget {
  const _HomeHeroCard({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            colorScheme.primaryContainer,
            colorScheme.tertiaryContainer,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _DrawerNavTile extends StatelessWidget {
  const _DrawerNavTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: onTap,
      dense: true,
      visualDensity: const VisualDensity(horizontal: 0, vertical: -1),
    );
  }
}
