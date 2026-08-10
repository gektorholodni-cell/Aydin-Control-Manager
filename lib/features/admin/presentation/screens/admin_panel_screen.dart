import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/localization/context_l10n.dart';
import '../../data/repositories/mock_admin_repository.dart';
import '../../domain/entities/admin_permission.dart';
import '../../domain/entities/admin_role.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen>
    with SingleTickerProviderStateMixin {
  final _repository = const MockAdminRepository();

  late final TabController _tabController;
  late final TextEditingController _logoController;
  late final TextEditingController _nameController;
  late final TextEditingController _binController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _websiteController;
  late final TextEditingController _addressController;
  late final TextEditingController _workingHoursController;
  late final TextEditingController _timezoneController;
  late final TextEditingController _languageController;
  late final TextEditingController _currencyController;
  late final TextEditingController _measurementController;

  late List<AdminRole> _roles;
  late String _selectedRoleId;
  bool _companySuspended = false;
  bool _projectArchived = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);

    final company = _repository.getCompanyProfile();
    _logoController = TextEditingController(text: company.logoText);
    _nameController = TextEditingController(text: company.companyName);
    _binController = TextEditingController(text: company.bin);
    _phoneController = TextEditingController(text: company.phone);
    _emailController = TextEditingController(text: company.email);
    _websiteController = TextEditingController(text: company.website);
    _addressController = TextEditingController(text: company.address);
    _workingHoursController = TextEditingController(text: company.workingHours);
    _timezoneController = TextEditingController(text: company.timezone);
    _languageController = TextEditingController(text: company.language);
    _currencyController = TextEditingController(text: company.currency);
    _measurementController = TextEditingController(text: company.measurementSystem);
    _companySuspended = company.isSuspended;

    _roles = _repository.getRoles();
    _selectedRoleId = _roles.first.id;
  }

  @override
  void dispose() {
    _tabController.dispose();
    _logoController.dispose();
    _nameController.dispose();
    _binController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    _addressController.dispose();
    _workingHoursController.dispose();
    _timezoneController.dispose();
    _languageController.dispose();
    _currencyController.dispose();
    _measurementController.dispose();
    super.dispose();
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  AdminRole get _selectedRole {
    return _roles.firstWhere((role) => role.id == _selectedRoleId);
  }

  Future<void> _confirmDeleteCompany() async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.adminDeleteCompany),
        content: const Text('Все данные компании будут удалены. Продолжить?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.commonDelete),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      setState(() {
        _logoController.clear();
        _nameController.clear();
        _binController.clear();
        _phoneController.clear();
        _emailController.clear();
        _websiteController.clear();
        _addressController.clear();
        _workingHoursController.clear();
        _timezoneController.clear();
        _languageController.clear();
        _currencyController.clear();
        _measurementController.clear();
        _companySuspended = false;
      });
      _showSnack(l10n.adminActionCompanyDeleted);
    }
  }

  void _openModule(String module) {
    const routes = <String, String>{
      'Manage Employees': AppRoutes.employees,
      'Manage Chats': AppRoutes.chats,
      'Manage Documents': AppRoutes.documents,
      'Manage Finances': AppRoutes.finance,
      'Manage Reports': AppRoutes.reports,
      'View Dashboard': AppRoutes.home,
    };
    final route = routes[module];
    if (route != null) {
      context.go(route);
    } else if (module == 'Manage Roles' || module == 'Manage Permissions') {
      _tabController.animateTo(2);
    } else {
      _showSnack('$module: ${context.l10n.adminActionOpened}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.adminTitle),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: <Tab>[
            Tab(text: l10n.adminTabOverview),
            Tab(text: l10n.adminTabCompany),
            Tab(text: l10n.adminTabRbac),
            Tab(text: l10n.adminTabManagement),
            Tab(text: l10n.adminTabActivity),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          _buildOverviewTab(context),
          _buildCompanyTab(context),
          _buildRbacTab(context),
          _buildManagementTab(context),
          _buildActivityTab(context),
        ],
      ),
    );
  }

  Widget _buildOverviewTab(BuildContext context) {
    final l10n = context.l10n;
    final departments = _repository.getDepartments();
    final projects = _repository.getProjects();
    final teams = _repository.getTeams();
    final employees = _repository.getEmployees();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
      children: <Widget>[
        Text(
          l10n.adminOverviewHeadline,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 8),
        Text(l10n.adminOverviewSubtitle),
        const SizedBox(height: 14),
        _StatGrid(
          items: <_StatItem>[
            _StatItem(title: l10n.projectsTitle, value: '${projects.length}'),
            _StatItem(title: l10n.employeesTitle, value: '${employees.length}'),
            _StatItem(title: l10n.adminDepartmentsTitle, value: '${departments.length}'),
            _StatItem(title: l10n.adminTeamsTitle, value: '${teams.length}'),
            _StatItem(title: l10n.adminRolesTitle, value: '${_roles.length}'),
          ],
        ),
        const SizedBox(height: 14),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  l10n.adminOrganizationStructure,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 12),
                _HierarchyNode(label: l10n.companyTitle),
                const _HierarchyArrow(),
                _HierarchyNode(label: l10n.adminDepartmentsTitle),
                const _HierarchyArrow(),
                _HierarchyNode(label: l10n.projectsTitle),
                const _HierarchyArrow(),
                _HierarchyNode(label: l10n.adminTeamsTitle),
                const _HierarchyArrow(),
                _HierarchyNode(label: l10n.employeesTitle),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompanyTab(BuildContext context) {
    final l10n = context.l10n;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
      children: <Widget>[
        Text(
          l10n.adminCompanySettingsTitle,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: <Widget>[
                _SettingsField(controller: _logoController, label: l10n.adminCompanyLogo),
                _SettingsField(controller: _nameController, label: l10n.adminCompanyName),
                _SettingsField(controller: _binController, label: l10n.adminCompanyBin),
                _SettingsField(controller: _phoneController, label: l10n.commonPhone),
                _SettingsField(controller: _emailController, label: l10n.commonEmail),
                _SettingsField(controller: _websiteController, label: l10n.adminCompanyWebsite),
                _SettingsField(controller: _addressController, label: l10n.projectFieldAddress),
                _SettingsField(
                  controller: _workingHoursController,
                  label: l10n.adminCompanyWorkingHours,
                ),
                _SettingsField(controller: _timezoneController, label: l10n.adminCompanyTimezone),
                _SettingsField(controller: _languageController, label: l10n.languageSelectLabel),
                _SettingsField(controller: _currencyController, label: l10n.adminCompanyCurrency),
                _SettingsField(
                  controller: _measurementController,
                  label: l10n.adminCompanyMeasurement,
                  isLast: true,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Card(
          child: Column(
            children: <Widget>[
              SwitchListTile.adaptive(
                value: _companySuspended,
                title: Text(l10n.adminSuspendCompany),
                subtitle: Text(l10n.adminSuspendCompanySubtitle),
                onChanged: (value) {
                  setState(() {
                    _companySuspended = value;
                  });
                },
              ),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    FilledButton.icon(
                      onPressed: () {
                        if (_nameController.text.trim().isEmpty) {
                          _showSnack(context.l10n.validationRequired);
                          return;
                        }
                        _showSnack(l10n.adminActionCompanyCreated);
                      },
                      icon: const Icon(Icons.add_business_outlined),
                      label: Text(l10n.adminCreateCompany),
                    ),
                    FilledButton.tonalIcon(
                      onPressed: () {
                        if (_nameController.text.trim().isEmpty) {
                          _showSnack(context.l10n.validationRequired);
                          return;
                        }
                        _showSnack(l10n.adminActionCompanyUpdated);
                      },
                      icon: const Icon(Icons.edit_outlined),
                      label: Text(l10n.adminEditCompany),
                    ),
                    OutlinedButton.icon(
                      onPressed: _confirmDeleteCompany,
                      icon: const Icon(Icons.delete_outline),
                      label: Text(l10n.adminDeleteCompany),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRbacTab(BuildContext context) {
    final l10n = context.l10n;
    final role = _selectedRole;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
      children: <Widget>[
        Text(
          l10n.adminRbacTitle,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 8),
        Text(l10n.adminRbacSubtitle),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: DropdownButtonFormField<String>(
              initialValue: _selectedRoleId,
              decoration: InputDecoration(labelText: l10n.filterRoleLabel),
              items: _roles
                  .map(
                    (r) => DropdownMenuItem<String>(
                      value: r.id,
                      child: Text(_roleLabel(context, r.id)),
                    ),
                  )
                  .toList(growable: false),
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                setState(() {
                  _selectedRoleId = value;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        Card(
          child: Column(
            children: AdminPermission.values
                .map(
                  (permission) => Column(
                    children: <Widget>[
                      SwitchListTile.adaptive(
                        value: role.permissions.contains(permission),
                        title: Text(_permissionLabel(context, permission)),
                        onChanged: (value) {
                          final updated = Set<AdminPermission>.from(role.permissions);
                          if (value) {
                            updated.add(permission);
                          } else {
                            updated.remove(permission);
                          }
                          _updateRolePermissions(role.id, updated);
                        },
                      ),
                      if (permission != AdminPermission.values.last)
                        const Divider(height: 1),
                    ],
                  ),
                )
                .toList(growable: false),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            OutlinedButton.icon(
              onPressed: () {
                _updateRolePermissions(role.id, _repository.getDefaultPermissionsForRole(role.id));
                _showSnack(l10n.adminActionRoleReset);
              },
              icon: const Icon(Icons.restart_alt_outlined),
              label: Text(l10n.adminResetPermissions),
            ),
            FilledButton.tonalIcon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.adminActionRoleSaved),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: const Icon(Icons.verified_outlined),
              label: Text(l10n.adminSavePermissions),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildManagementTab(BuildContext context) {
    final l10n = context.l10n;
    final modules = _repository.getManagementModules();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
      children: <Widget>[
        Card(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.add_task_outlined),
                title: Text(l10n.adminCreateProjects),
                subtitle: Text(l10n.adminCreateProjectsSubtitle),
                trailing: IconButton(
                  icon: const Icon(Icons.play_circle_outline),
                  onPressed: () => context.go(AppRoutes.newProject),
                ),
              ),
              const Divider(height: 1),
              SwitchListTile.adaptive(
                value: _projectArchived,
                title: Text(l10n.adminArchiveProjects),
                subtitle: Text(l10n.adminArchiveProjectsSubtitle),
                onChanged: (value) {
                  setState(() {
                    _projectArchived = value;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          l10n.adminManagementModules,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 8),
        ...modules.map(
          (module) => Card(
            child: ListTile(
              leading: const Icon(Icons.settings_suggest_outlined),
              title: Text(module),
              trailing: TextButton(
                onPressed: () => _openModule(module),
                child: Text(l10n.adminOpen),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityTab(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final dateFormat = DateFormat.yMd(locale).add_Hm();
    final items = _repository.getActivities();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
      children: <Widget>[
        Text(
          l10n.adminActivityTitle,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 8),
        Text(l10n.adminActivitySubtitle),
        const SizedBox(height: 10),
        ...items.map(
          (item) => Card(
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.history_outlined, size: 18),
              ),
              title: Text(item.action),
              subtitle: Text('${item.actor} • ${dateFormat.format(item.createdAt)}'),
            ),
          ),
        ),
      ],
    );
  }

  String _roleLabel(BuildContext context, String roleId) {
    final l10n = context.l10n;
    switch (roleId) {
      case 'owner':
        return l10n.adminRoleOwner;
      case 'administrator':
        return l10n.adminRoleAdministrator;
      case 'projectManager':
        return l10n.roleProjectManager;
      case 'siteEngineer':
        return l10n.roleSiteEngineer;
      case 'foreman':
        return l10n.roleForeman;
      case 'accountant':
        return l10n.roleAccountant;
      case 'storekeeper':
        return l10n.roleStorekeeper;
      case 'safetyEngineer':
        return l10n.roleSafetyEngineer;
      case 'worker':
        return l10n.roleWorker;
      case 'viewer':
        return l10n.adminRoleViewer;
      default:
        return roleId;
    }
  }

  String _permissionLabel(BuildContext context, AdminPermission permission) {
    final l10n = context.l10n;
    switch (permission) {
      case AdminPermission.viewProjects:
        return l10n.adminPermissionViewProjects;
      case AdminPermission.editProjects:
        return l10n.adminPermissionEditProjects;
      case AdminPermission.deleteProjects:
        return l10n.adminPermissionDeleteProjects;
      case AdminPermission.createTasks:
        return l10n.adminPermissionCreateTasks;
      case AdminPermission.completeTasks:
        return l10n.adminPermissionCompleteTasks;
      case AdminPermission.viewFinance:
        return l10n.adminPermissionViewFinance;
      case AdminPermission.editFinance:
        return l10n.adminPermissionEditFinance;
      case AdminPermission.uploadDocuments:
        return l10n.adminPermissionUploadDocuments;
      case AdminPermission.deleteDocuments:
        return l10n.adminPermissionDeleteDocuments;
      case AdminPermission.manageEmployees:
        return l10n.adminPermissionManageEmployees;
      case AdminPermission.manageChats:
        return l10n.adminPermissionManageChats;
      case AdminPermission.manageReports:
        return l10n.adminPermissionManageReports;
      case AdminPermission.manageSettings:
        return l10n.adminPermissionManageSettings;
    }
  }

  void _updateRolePermissions(String roleId, Set<AdminPermission> permissions) {
    setState(() {
      _roles = _roles
          .map(
            (role) => role.id == roleId
                ? role.copyWith(permissions: permissions)
                : role,
          )
          .toList(growable: false);
    });
  }
}

class _SettingsField extends StatelessWidget {
  const _SettingsField({
    required this.controller,
    required this.label,
    this.isLast = false,
  });

  final TextEditingController controller;
  final String label;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}

class _StatGrid extends StatelessWidget {
  const _StatGrid({required this.items});

  final List<_StatItem> items;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth >= 900
            ? 5
            : constraints.maxWidth >= 620
                ? 3
                : 2;

        return GridView.builder(
          itemCount: items.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.8,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.value,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(item.title),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _StatItem {
  const _StatItem({required this.title, required this.value});

  final String title;
  final String value;
}

class _HierarchyNode extends StatelessWidget {
  const _HierarchyNode({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _HierarchyArrow extends StatelessWidget {
  const _HierarchyArrow();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Icon(Icons.south_rounded),
      ),
    );
  }
}
