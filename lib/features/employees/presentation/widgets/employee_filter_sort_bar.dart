import 'package:flutter/material.dart';

import '../../../../core/localization/context_l10n.dart';
import '../../domain/enums/employee_role.dart';

enum EmployeeSortOption {
  onlineFirst,
  alphabetical,
  byPosition,
}

extension EmployeeSortOptionX on EmployeeSortOption {
  String localizedLabel(BuildContext context) {
    final l10n = context.l10n;

    switch (this) {
      case EmployeeSortOption.onlineFirst:
        return l10n.sortOnlineFirst;
      case EmployeeSortOption.alphabetical:
        return l10n.sortAlphabetically;
      case EmployeeSortOption.byPosition:
        return l10n.sortByPosition;
    }
  }
}

String _localizedRoleLabel(BuildContext context, EmployeeRole role) {
  final l10n = context.l10n;

  switch (role) {
    case EmployeeRole.director:
      return l10n.roleDirector;
    case EmployeeRole.projectManager:
      return l10n.roleProjectManager;
    case EmployeeRole.siteEngineer:
      return l10n.roleSiteEngineer;
    case EmployeeRole.foreman:
      return l10n.roleForeman;
    case EmployeeRole.surveyor:
      return l10n.roleSurveyor;
    case EmployeeRole.safetyEngineer:
      return l10n.roleSafetyEngineer;
    case EmployeeRole.accountant:
      return l10n.roleAccountant;
    case EmployeeRole.storekeeper:
      return l10n.roleStorekeeper;
    case EmployeeRole.worker:
      return l10n.roleWorker;
  }
}

class EmployeeFilterSortBar extends StatelessWidget {
  const EmployeeFilterSortBar({
    required this.selectedRole,
    required this.selectedSort,
    required this.onRoleChanged,
    required this.onSortChanged,
    super.key,
  });

  final EmployeeRole? selectedRole;
  final EmployeeSortOption selectedSort;
  final ValueChanged<EmployeeRole?> onRoleChanged;
  final ValueChanged<EmployeeSortOption> onSortChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final compact = constraints.maxWidth < 720;

        final roleMenu = DropdownMenu<EmployeeRole?>(
          initialSelection: selectedRole,
          label: Text(l10n.filterRoleLabel),
          onSelected: onRoleChanged,
          width: compact ? constraints.maxWidth : 260,
          dropdownMenuEntries: <DropdownMenuEntry<EmployeeRole?>>[
            DropdownMenuEntry<EmployeeRole?>(
              value: null,
              label: l10n.filterAllRoles,
            ),
            ...EmployeeRole.values.map(
              (EmployeeRole role) => DropdownMenuEntry<EmployeeRole?>(
                value: role,
                label: _localizedRoleLabel(context, role),
              ),
            ),
          ],
        );

        final sortMenu = DropdownMenu<EmployeeSortOption>(
          initialSelection: selectedSort,
          label: Text(l10n.filterSortByLabel),
          onSelected: (EmployeeSortOption? value) {
            if (value != null) {
              onSortChanged(value);
            }
          },
          width: compact ? constraints.maxWidth : 260,
          dropdownMenuEntries: EmployeeSortOption.values
              .map(
                (EmployeeSortOption option) => DropdownMenuEntry<EmployeeSortOption>(
                  value: option,
                  label: option.localizedLabel(context),
                ),
              )
              .toList(growable: false),
        );

        if (compact) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              roleMenu,
              const SizedBox(height: 10),
              sortMenu,
            ],
          );
        }

        return Row(
          children: <Widget>[
            roleMenu,
            const SizedBox(width: 12),
            sortMenu,
          ],
        );
      },
    );
  }
}
