import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/localization/context_l10n.dart';
import '../../data/repositories/mock_employee_repository.dart';
import '../../domain/entities/employee.dart';
import '../../domain/enums/employee_role.dart';
import '../widgets/employee_card.dart';
import '../widgets/employee_filter_sort_bar.dart';
import '../widgets/employee_search_bar.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  final TextEditingController _searchController = TextEditingController();
  final MockEmployeeRepository _repository = const MockEmployeeRepository();

  String _searchQuery = '';
  EmployeeRole? _selectedRole;
  EmployeeSortOption _selectedSort = EmployeeSortOption.onlineFirst;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Employee> _buildEmployees() {
    final employees = _repository.getEmployees().where((Employee employee) {
      final matchesSearch = _searchQuery.isEmpty ||
          employee.fullName.toLowerCase().contains(_searchQuery) ||
          employee.phone.toLowerCase().contains(_searchQuery) ||
          employee.currentProject.toLowerCase().contains(_searchQuery);
      final matchesRole = _selectedRole == null || employee.role == _selectedRole;
      return matchesSearch && matchesRole;
    }).toList(growable: false);

    final sorted = List<Employee>.from(employees);
    sorted.sort((Employee a, Employee b) {
      switch (_selectedSort) {
        case EmployeeSortOption.onlineFirst:
          if (a.isOnline != b.isOnline) {
            return a.isOnline ? -1 : 1;
          }
          return a.fullName.compareTo(b.fullName);
        case EmployeeSortOption.alphabetical:
          return a.fullName.compareTo(b.fullName);
        case EmployeeSortOption.byPosition:
          final positionOrder = a.position.compareTo(b.position);
          if (positionOrder != 0) {
            return positionOrder;
          }
          return a.fullName.compareTo(b.fullName);
      }
    });

    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final employees = _buildEmployees();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.employeesTitle)),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              l10n.employeesHeadline,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.employeesSubtitle,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            EmployeeSearchBar(
              controller: _searchController,
              onChanged: (String value) {
                setState(() {
                  _searchQuery = value.trim().toLowerCase();
                });
              },
            ),
            const SizedBox(height: 12),
            EmployeeFilterSortBar(
              selectedRole: _selectedRole,
              selectedSort: _selectedSort,
              onRoleChanged: (EmployeeRole? role) {
                setState(() {
                  _selectedRole = role;
                });
              },
              onSortChanged: (EmployeeSortOption sort) {
                setState(() {
                  _selectedSort = sort;
                });
              },
            ),
            const SizedBox(height: 14),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 280),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                child: employees.isEmpty
                    ? const _EmptyState()
                    : _EmployeeList(
                        key: ValueKey<String>(
                          '${_searchQuery}_${_selectedRole}_${_selectedSort.name}',
                        ),
                        employees: employees,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmployeeList extends StatelessWidget {
  const _EmployeeList({
    required this.employees,
    super.key,
  });

  final List<Employee> employees;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: employees.length,
      padding: const EdgeInsets.only(bottom: 24),
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 12);
      },
      itemBuilder: (BuildContext context, int index) {
        final employee = employees[index];

        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 220 + (index * 35)),
          curve: Curves.easeOutCubic,
          tween: Tween<double>(begin: 0, end: 1),
          builder: (BuildContext context, double value, Widget? child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, (1 - value) * 10),
                child: child,
              ),
            );
          },
          child: EmployeeCard(
            employee: employee,
            onTap: () {
              context.push('${AppRoutes.employees}/${employee.id}');
            },
          ),
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.group_off_outlined,
            size: 44,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 10),
          Text(
            context.l10n.employeesNoResults,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
