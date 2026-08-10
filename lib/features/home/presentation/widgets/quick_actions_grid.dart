import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/localization/context_l10n.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final actions = <_ActionItem>[
      _ActionItem(
        label: l10n.actionOpenChats,
        icon: Icons.chat_bubble_outline,
        route: AppRoutes.chats,
      ),
      _ActionItem(
        label: l10n.actionViewTasks,
        icon: Icons.task_alt_outlined,
        route: AppRoutes.tasks,
      ),
      _ActionItem(
        label: l10n.actionFinance,
        icon: Icons.account_balance_wallet_outlined,
        route: AppRoutes.finance,
      ),
      _ActionItem(
        label: l10n.actionEmployees,
        icon: Icons.groups_2_outlined,
        route: AppRoutes.employees,
      ),
      _ActionItem(
        label: l10n.actionProjects,
        icon: Icons.business_outlined,
        route: AppRoutes.projects,
      ),
      _ActionItem(
        label: l10n.actionReports,
        icon: Icons.assessment_outlined,
        route: AppRoutes.reports,
      ),
      _ActionItem(
        label: l10n.actionAdminPanel,
        icon: Icons.admin_panel_settings_outlined,
        route: AppRoutes.admin,
      ),
      _ActionItem(
        label: l10n.enterpriseDrawingsTitle,
        icon: Icons.draw_outlined,
        route: AppRoutes.drawings,
      ),
      _ActionItem(
        label: l10n.enterpriseEquipmentTitle,
        icon: Icons.precision_manufacturing_outlined,
        route: AppRoutes.equipment,
      ),
      _ActionItem(
        label: l10n.enterpriseVehiclesTitle,
        icon: Icons.local_shipping_outlined,
        route: AppRoutes.vehicles,
      ),
      _ActionItem(
        label: l10n.enterpriseWarehouseTitle,
        icon: Icons.warehouse_outlined,
        route: AppRoutes.warehouse,
      ),
      _ActionItem(
        label: l10n.enterpriseCalendarTitle,
        icon: Icons.calendar_month_outlined,
        route: AppRoutes.calendar,
      ),
    ];

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final crossAxisCount = constraints.maxWidth >= 900
            ? 4
            : constraints.maxWidth >= 580
                ? 2
                : 1;

        return GridView.builder(
          itemCount: actions.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: crossAxisCount == 1 ? 3.8 : 2.6,
          ),
          itemBuilder: (BuildContext context, int index) {
            final action = actions[index];
            return _ActionCard(action: action);
          },
        );
      },
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({required this.action});

  final _ActionItem action;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          if (action.route case final String route) {
            context.go(route);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(action.icon, color: colorScheme.onPrimaryContainer),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  action.label,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionItem {
  const _ActionItem({
    required this.label,
    required this.icon,
    required this.route,
  });

  final String label;
  final IconData icon;
  final String? route;
}
